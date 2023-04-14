unit uConsultaCEP;

interface

uses
  System.Net.HttpClient, System.Net.URLClient, System.Net.HttpClientComponent,
  System.SysUtils, System.JSON, System.Classes, uRetornoCEP;

type
  TConsultaCEP = class
  public
    class function Consultar(const CEP: string): TRetornoCEP;
  end;

implementation

class function TConsultaCEP.Consultar(const CEP: string): TRetornoCEP;
const
  url = 'https://brasilapi.com.br/api/cep/v1/';
var
  client: TNetHTTPClient;
  response: IHTTPResponse;
  json: TJSONObject;
begin
  client := TNetHTTPClient.Create(nil);
  try
    client.ConnectionTimeout := 5000;
    response := client.Get(url+cep);
    Result := TRetornoCEP.Create;
     if response.StatusCode = 200 then
     begin
        json := TJSONObject.ParseJSONValue(response.ContentAsString) as TJSONObject;
        try
          Result.Consulta := 'OK';
          Result.CEP := json.GetValue('cep').Value;
          Result.Logradouro := json.GetValue('street').Value;
          Result.Bairro := json.GetValue('neighborhood').Value;
          Result.Cidade := json.GetValue('city').Value;
          Result.Estado := json.GetValue('state').Value;
          Result.Service:= json.GetValue('service').Value;
        except
          on E: Exception do
          Result.Consulta:= 'Erro: ' + E.Message;
        end;
     end else
     begin
      Result.Consulta:= 'Erro: Cep Inexistente, Status Code: ' + response.StatusCode.tostring;
     end;
  except
    on E: ENetHTTPClientException do
    Result.Consulta:='Erro: Serviço de CEP está indisponível no momento, tente novamente mais tarde.';
  end;
  client.Free;
end;

end.

