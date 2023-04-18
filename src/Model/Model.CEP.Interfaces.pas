unit Model.CEP.Interfaces;

interface

uses
  System.JSON,
  Generics.Collections;

type
  ICEP = interface
    ['{05AEAC8C-2191-402B-A51D-5ACD77AAF857}']
    function GetBairro : String;
    function GetCEP    : String;
    function GetCidade : String;
    function GetEstado : String;
    function GetRua    : String;
    function GetServico: String;

    procedure SetBairro(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetEstado(const Value: String);
    procedure SetRua(const Value: String);
    procedure SetServico(const Value: String);

    property CEP    : String read GetCEP      write SetCEP;
    property Estado : String read GetEstado   write SetEstado;
    property Cidade : String read GetCidade   write SetCidade;
    property Bairro : String read GetBairro   write SetBairro;
    property Rua    : String read GetRua      write SetRua;
    property Servico: String read GetServico  write SetServico;
  end;

  IControllerCEP = interface
    ['{06185EB9-79F3-4A64-9A80-BE14A2615634}']
    function GetListaCeps: TList<ICEP>;

    Procedure PesquisarCEP(aCEP: String);
    procedure Validar(aCEP: String);

    property ListaCeps: TList<ICEP> read GetListaCeps;
  end;

  IDAOCep = interface
    ['{A96318DB-BE73-424D-B470-3B0BE287AF9E}']
    function Existe(aCep: String): Boolean;

    procedure Consultar(aListaCep: TList<ICEP>; aCep:String);
    procedure GravarCEPs(aListaCeps: Tlist<ICEP>);
  end;

  THelperListaCEPs = class Helper for TList<ICEP>
    procedure ParseJSONToCEP(aJsonValue: TJSONValue);
  end;

implementation

uses
  Model.CEP;

procedure THelperListaCEPs.ParseJSONToCEP(aJsonValue: TJSONValue);
var xJObj  : TJSONObject;
    xJArray: TJSONArray;
    xCep   : ICEP;
    I      : Integer;
begin
  xJObj := TJSONObject(aJsonValue);
  xCEP  := TCEP.New;

  if xJObj.FindValue('cep')          <> nil then
      xCep.CEP    := xJObj.GetValue('cep').Value;
  if xJObj.FindValue('state')        <> nil then
      xCep.Estado := xJObj.GetValue('state').Value;
  if xJObj.FindValue('city')         <> nil then
      xCep.Cidade := xJObj.GetValue('city').Value;
  if xJObj.FindValue('neighborhood') <> nil then
      xCep.Bairro := xJObj.GetValue('neighborhood').Value;
  if xJObj.FindValue('street') <> nil then
      xCep.Rua    := xJObj.GetValue('street').Value;
  if xJObj.FindValue('service')      <> nil then
      xCep.Servico:= xJObj.GetValue('service').Value;

  if Self.IndexOf(xCep) < 0 then
      Self.Add(xCep);
end;

end.
