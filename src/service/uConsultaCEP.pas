unit uConsultaCEP;

interface

uses uCEP, REST.Client, REST.Response.Adapter, RESTRequest4D, DataSet.Serialize, Rest.JSON, Data.DBXJSON, System.SysUtils,
  REST.HttpClient;

type
  TRetornoCEP = class
  private
    FCEP: TCEP;
  public
    property CEP: TCEP read FCEP;
  end;

  TConsultaCEP = class
  private
    FMensagem: boolean;
  public
    function ConsultarCEP(XCEP: string; out XAchou: boolean): TRetornoCEP;
    property Mensagem: boolean read FMensagem write FMensagem;
  end;

implementation

uses
  Vcl.Dialogs;

{ TConsultaCEP }

function TConsultaCEP.ConsultarCEP(XCEP: string; out XAchou: boolean): TRetornoCEP;
var wresponse: IResponse;
    wret: TRetornoCEP;
    wfiltro: string;
begin
  wret := TRetornoCEP.Create;
  try
    wresponse := TRequest.New.BaseURL('http://brasilapi.com.br/api/cep/v1/'+XCEP)
      .Accept('application/json')
      .Timeout(5000) // 5 segundos
      .Get;
    case wresponse.StatusCode of
      400,404,500: begin
                      XAchou := false;
                      if Mensagem then
                         showmessage('Não foi possível localizar CEP');
                   end;
      504: begin
             XAchou := false;
             if Mensagem then
                showmessage('Consulta de CEP indisponível no momento. Tente mais tarde.');
           end
    else
       begin
         XAchou := true;
         wret.FCEP := TJson.JsonToObject<TCEP>(wresponse.Content);
       end;
    end;
  except
    on E: Exception do
    begin
      XAchou := false;
      if Mensagem then
         showmessage('Problema ao consultar CEP '+E.Message);
    end;
  end;
  result := wret;
end;

end.
