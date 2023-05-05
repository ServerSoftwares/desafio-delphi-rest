unit Model.Request.CEP;

interface

uses
  Model.Request.Interfaces,
  System.JSON,
  RESTRequest4D;

type
  TRequestCEP = class(TInterfacedObject, IRequestCEP)
  private
    FRequest   : IRequest;
    FStatusCode: Integer;
    FResponse  : TJSONValue;

    function GetStatusCode: Integer;
    function GetResponse: TJSONValue;

    procedure Configurar(aCep: String);

  public
    constructor Create;
    Destructor Destroy; Override;
    class function New: IRequestCEP;

    function Consultar(aCep: String): IRequestCEP;

    property Response  : TJSONValue read GetResponse;
    property StatusCode: Integer    read GetStatusCode;
  end;

  const cURLApiCep   = 'https://brasilapi.com.br/api/cep/v1/';
  const cContentType = 'application/json';

implementation

uses
  System.SysUtils;

{ TRequestCEP }

class function TRequestCEP.New: IRequestCEP;
begin
  Result := Self.Create;
end;

constructor TRequestCEP.Create;
begin
  FRequest := TRequest.New;
end;

destructor TRequestCEP.Destroy;
begin
  inherited;

  if Assigned(FResponse) then
      FreeAndNil(FResponse);
end;

function TRequestCEP.GetResponse: TJSONValue;
begin
  Result := FResponse;
end;

function TRequestCEP.GetStatusCode: Integer;
begin
  Result := FStatusCode;
end;

procedure TRequestCEP.Configurar(aCep: String);
begin
  FRequest.BaseURL(cURLApiCep + aCep);
  FRequest.ContentType(cContentType);
end;

function TRequestCEP.Consultar(aCep: String): IRequestCEP;
var xResponse: IResponse;
begin
  try
      Configurar(aCep);

      xResponse := FRequest.Get;

      FStatusCode:= xResponse.StatusCode;
      FResponse  := TJSONValue.ParseJSONValue(xResponse.JSONValue.ToJSON);

  except on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.