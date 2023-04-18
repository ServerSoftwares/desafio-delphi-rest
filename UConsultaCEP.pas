unit UConsultaCEP;

interface

uses
  System.Classes, System.SysUtils, REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  RetornoCEP, IdHTTP, IdException, System.JSON, IdSSLOpenSSL, REST.Json, Messages,Messaging;

type
  TConsultaCEP = class
  private
    function ValidarCEP(CEP: string): Boolean;
  public
    FRestClient: TRESTClient;
    FRestRequest: TRESTRequest;
    FRestResponse: TRESTResponse;
    constructor Create;
    destructor Destroy; override;
    function ConsultarCEP(CEP: string): TRetornoCEP;
  end;

implementation

{ TConsultaCEP }

function TConsultaCEP.ConsultarCEP(CEP: string): TRetornoCEP;
var
  URL, Recurso: string;
  Response: string;
  Retorno: TRetornoCEP;
begin
  if not ValidarCEP(CEP) then
    raise Exception.Create('CEP informado é inválido');

  URL := 'https://brasilapi.com.br/api';
  Recurso := 'cep/v1/{cep}';


  FRestClient          := TRESTClient.Create(nil);
  FRestRequest         := TRESTRequest.Create(nil);
  FRestResponse        := TRESTResponse.Create(nil);


  FRestClient.BindSource.AutoActivate := True;
  FRestClient.BindSource.AutoEdit     := True;
  FRestClient.BindSource.AutoPost     := True;
  FRestClient.AllowCookies     := True;
  FRestClient.AutoCreateParams := True;
  FRestClient.BaseURL          := URL;

  FRestRequest.Client              := FRestClient;
  FRestRequest.Method              := rmGET;
  FRestRequest.Response            := FRestResponse;
  FRestRequest.AutoCreateParams    := True;
  FRestRequest.Resource            := Recurso;
  FRestRequest.Response            := FRestResponse;
  FRestRequest.SynchronizedEvents  := True;
  FRestRequest.Timeout             := 30000;

  FRestRequest.Params.ParameterByName('cep').Value := CEP;

  try
    FRestRequest.Execute;
    if FRestRequest.Response.Status.ClientErrorUnauthorized_401 then
      Raise Exception.Create('Erro: Consulta não autorizada.');

    if FRestRequest.Response.Status.ClientErrorNotFound_404 then
      Raise Exception.Create('Atenção.'+#13+'CEP não encontrado.'+#13+'Verifique a informação ou tente outro CEP.');

    if FRestResponse.Status.SuccessOK_200 then begin
      Result := TRetornoCEP.Create(FRestResponse.JSONValue.GetValue<string>('cep'),
                                   FRestResponse.JSONValue.GetValue<string>('state'),
                                   FRestResponse.JSONValue.GetValue<string>('city'),
                                   FRestResponse.JSONValue.GetValue<string>('neighborhood'),
                                   FRestResponse.JSONValue.GetValue<string>('street'),
                                   FRestResponse.JSONValue.GetValue<string>('service'))
    end;
  finally
    FRestClient.Free;
    FRestRequest.Free;
    FRestResponse.Free;
  end;
end;

constructor TConsultaCEP.Create;
begin
end;

destructor TConsultaCEP.Destroy;
begin
  inherited;
end;

function TConsultaCEP.ValidarCEP(CEP: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Length(CEP) <> 8 then
    Exit;
  for i := 1 to Length(CEP) do
    if not CharInSet(CEP[i], ['0'..'9']) then
      Exit;
  Result := True;
end;

end.
