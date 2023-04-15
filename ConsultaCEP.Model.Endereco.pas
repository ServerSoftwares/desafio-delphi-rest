unit ConsultaCEP.Model.Endereco;

interface

uses
  System.Classes,
  System.JSON,
  System.SysUtils,
  REST.Types,
  REST.Client,
  ConsultaCEP.Model.Records.Endereco;

type
   TConsultaCEP = class

   private
      { Private declarations }
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      function VoltaCEP (CEP: String): TRetornoCEP;
end;

implementation

{ TConsultaCEP }

constructor TConsultaCEP.Create;
begin
//
end;

destructor TConsultaCEP.Destroy;
begin
  inherited;
end;

function TConsultaCEP.VoltaCEP(CEP: String): TRetornoCEP;
var
   jsonResponse: TJSONObject;
   RESTClient_ConsultaCEP: TRESTClient;
   RESTRequest_ConsultaCEP: TRestRequest;
   RESTResponse_ConsultaCEP: TRESTResponse;
begin
   try
      try
         // PROPRIEDADES TRESTResponse
         RESTResponse_ConsultaCEP := TRESTResponse.Create (nil);

         // PROPRIEDADES TRESTClient
         RESTClient_ConsultaCEP := TRESTClient.Create('https://brasilapi.com.br/api/cep/v1/'+CEP);

         // PROPRIEDADES TRestRequest
         RESTRequest_ConsultaCEP := TRestRequest.Create(nil);
         RESTRequest_ConsultaCEP.Client := RESTClient_ConsultaCEP;
         RESTRequest_ConsultaCEP.Response := RESTResponse_ConsultaCEP;
         RESTRequest_ConsultaCEP.Method := rmGET;

         // LIMPO OS PARÂMETROS E O BODY DO REQUEST
         RESTRequest_ConsultaCEP.Params.Clear;
         RESTRequest_ConsultaCEP.Body.ClearBody;

         // EXECUTA TRestRequest
         RESTRequest_ConsultaCEP.Execute;

         try
            // LEITURA DO RESPONSE
            jsonResponse := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes (RESTResponse_ConsultaCEP.Content), 0) as TJSONObject;

            if RESTResponse_ConsultaCEP.StatusCode = 200 then
               begin
                  // PEGO OS CAMPOS DO JSON
                  Result.Endereco := jsonResponse.GetValue<string>('street', '');
                  Result.Bairro := jsonResponse.GetValue<string>('neighborhood', '');
                  Result.Cidade := jsonResponse.GetValue<string>('city', '');
                  Result.Estado := jsonResponse.GetValue<string>('state', '');
                  Result.CEP := CEP;
                  Result.Status := 200;
               end
            else
               begin
                  // STATUS DE ERRO
                  Result.Status := 404;
               end;
         finally
            jsonResponse.DisposeOf;
         end;
      except
         // STATUS DE ERRO
         Result.Status := 500;
      end;
   finally
      RESTClient_ConsultaCEP.DisposeOf;
      RESTRequest_ConsultaCEP.DisposeOf;
      RESTResponse_ConsultaCEP.DisposeOf;
   end;
end;

end.
