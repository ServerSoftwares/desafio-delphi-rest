unit Model.CEP;

interface

uses
  Model.CEP.Interfaces;

type
  TCEP = class(TInterfacedObject, ICEP)
  Private
    FBairro: String;
    FServico: String;
    FCEP: String;
    FCidade: String;
    FEstado: String;
    FRua: String;

    function GetBairro: String;
    function GetCEP: String;
    function GetCidade: String;
    function GetEstado: String;
    function GetRua: String;
    function GetServico: String;

    procedure SetBairro(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetEstado(const Value: String);
    procedure SetRua(const Value: String);
    procedure SetServico(const Value: String);
  Public
    class function New: ICEP;

    property CEP    : String read GetCEP      write SetCEP;
    property Estado : String read GetEstado   write SetEstado;
    property Cidade : String read GetCidade   write SetCidade;
    property Bairro : String read GetBairro   write SetBairro;
    property Rua    : String read GetRua      write SetRua;
    property Servico: String read GetServico  write SetServico;
  end;

implementation

{ TCEP }

class function TCEP.New: ICEP;
begin
  Result := Self.Create;
end;

procedure TCEP.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TCEP.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TCEP.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TCEP.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TCEP.SetRua(const Value: String);
begin
  FRua := Value;
end;

procedure TCEP.SetServico(const Value: String);
begin
  FServico := Value;
end;

function TCEP.GetBairro: String;
begin
  Result := FBairro;
end;

function TCEP.GetCEP: String;
begin
  Result := FCEP;
end;

function TCEP.GetCidade: String;
begin
  Result := FCidade;
end;

function TCEP.GetEstado: String;
begin
  Result := FEstado;
end;

function TCEP.GetRua: String;
begin
  Result := FRua;
end;

function TCEP.GetServico: String;
begin
  Result := FServico;
end;

end.
