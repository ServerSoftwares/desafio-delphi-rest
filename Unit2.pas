unit unit2;

interface

uses
  System.Classes, System.SysUtils, REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TConsultaCEP = class
  private
    FCEP: string;
    FRetornoCEP: TRetornoCEP;
    FCEPDAO: TCEPDAO;
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
    procedure ConfigurarRESTClient;
    function ValidarCEP(CEP: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function ConsultarCEP(CEP: string): TRetornoCEP;
  end;

implementation

const
  URL_BASE_API = 'https://brasilapi.com.br/api/cep/v1/';

constructor TConsultaCEP.Create;
begin
  FRetornoCEP := TRetornoCEP.Create;
  FCEPDAO := TCEPDAO.Create;
  FRESTClient := TRESTClient.Create(nil);
  FRESTRequest := TRESTRequest.Create(nil);
  FRESTResponse := TRESTResponse.Create(nil);
  ConfigurarRESTClient;
end;

destructor TConsultaCEP.Destroy;
begin
  FRetornoCEP.Free;
  FCEPDAO.Free;
  FRESTClient.Free;
  FRESTRequest.Free;
  FRESTResponse.Free;
  inherited;
end;

function TConsultaCEP.ConsultarCEP(CEP: string): TRetornoCEP;
var
  CEPGravado: TRetornoCEP;
begin
  FCEP := StringReplace(CEP, '-', '', [rfReplaceAll]); //remove a máscara do CEP, caso exista
  if not ValidarCEP(FCEP) then
  begin
    FRetornoCEP.Mensagem := 'CEP inválido.';
    Exit(FRetornoCEP);
  end;

  CEPGravado := FCEPDAO.ObterCEP(FCEP);
  if CEPGravado <> nil then //se já existe no banco, retorna do banco de dados
    Exit(CEPGravado);

  FRESTRequest.Params.ParameterByName('cep').Value := FCEP;
  try
    FRESTRequest.Execute;
    if FRESTResponse.StatusCode = 200 then //se retornou OK, popula a classe de retorno
    begin
      FRetornoCEP.UF := FRESTResponse.JSONValue.GetValue<string>('state');
      FRetornoCEP.Cidade := FRESTResponse.JSONValue.GetValue<string>('city');
      FRetornoCEP.Bairro := FRESTResponse.JSONValue.GetValue<string>('neighborhood');
      FRetornoCEP.Endereco := FRESTResponse.JSONValue.GetValue<string>('street');
      FRetornoCEP.Mensagem := 'CEP encontrado.';
      FCEPDAO.GravarCEP(FCEP, FRetornoCEP); //grava no banco de dados
    end
    else
      FRetornoCEP.M




