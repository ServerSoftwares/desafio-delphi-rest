unit ConsultaCEP;

interface

uses
  //Sistema
  System.Classes, System.Generics.Collections,

  //Rest
  REST.Types, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.Net.HttpClient,

  //ClientDataSet
  MidasLib, Datasnap.DBClient, Data.DB,

  //Expressão regular
  System.RegularExpressions,

  Endereco;

type
  TConsultaCEP = class;
  TProcRetornoCep = procedure(aConsultaCep : TConsultaCEP) of object;

  TRetornoCep = class
    private
      Fcep: string;
      FLogradouro: String;
      FTipo_localizacao: String;
      FLatitude: String;
      FBairro: String;
      FServico: String;
      FUF: String;
      FCidade: String;
      FLongitude: String;
      FErro: String;
      Fid: Int64;
    public
      property id : Int64 read Fid write Fid;
      property cep : string read Fcep write Fcep;
      property UF: String read FUF write FUF;
      property Cidade: String read FCidade write FCidade;
      property Bairro: String read FBairro write FBairro;
      property Logradouro: String read FLogradouro write FLogradouro;
      property Servico: String read FServico write FServico;
      property Tipo_localizacao: String read FTipo_localizacao write FTipo_localizacao;
      property Latitude: String read FLatitude write FLatitude;
      property Longitude: String read FLongitude write FLongitude;
      property Erro : String read FErro write FErro;

      procedure LimparDados;
  end;

  TConsultaCEP = class
    private
      FRESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
      FRESTClient: TRESTClient;
      FRESTResponse: TRESTResponse;
      FRESTRequest: TRESTRequest;
      FcdsResponse: TClientDataSet;
      FRetornoCep: TRetornoCep;
      const
      REQUEST_TIMEOUT = 408;
      SUCESS_HTTPCODE = 200;
      HTTPCODE_NOT_FOUND = 404;
      HTTPCODE_INTERNAL_SERVER_EROOR = 500;
      procedure InicializarComponentesREST;
      procedure LerRetornoRest;
      function validarCep(aCep : String) : Boolean;
    public
      constructor Create();
      destructor Destroy; override;
      function ConsultarCEP(aCep : String) : Boolean;
      property RetornoCep : TRetornoCep read FRetornoCep write FRetornoCep;
  end;

  implementation

uses
  System.SysUtils;

{ TConsultaCEP }

procedure TConsultaCEP.InicializarComponentesREST;
begin
  FRESTResponse := TRESTResponse.Create(Nil);
  FRESTClient := TRESTClient.Create('https://brasilapi.com.br/api/cep/v2/');
  FRESTRequest := TRESTRequest.Create(nil);
  FRESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(Nil);
  FcdsResponse := TClientDataSet.Create(Nil);

  FRESTResponse.ContentType := 'application/json';

  FRESTResponseDataSetAdapter.Active          := False;
  FRESTResponseDataSetAdapter.Dataset         := FcdsResponse;
  FRESTResponseDataSetAdapter.Response        := FRESTResponse;
  FRESTResponseDataSetAdapter.NestedElements  := True;

  FRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRESTClient.AcceptCharset := 'utf-8, *;q=0.8';
//  FRESTClient.BaseURL := ''
  FRESTClient.SecureProtocols := [THTTPSecureProtocol.TLS12];
  FRESTClient.ConnectTimeout := 5000;
  FRESTClient.ReadTimeout := 5000;

  FRESTRequest.AssignedValues := [TCustomRESTRequest.TAssignedValue.rvConnectTimeout, TCustomRESTRequest.TAssignedValue.rvReadTimeout];
  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
  FRESTRequest.ConnectTimeout := 5000;
  FRESTRequest.ReadTimeout := 5000;
end;

procedure TConsultaCEP.LerRetornoRest;
begin
  FRetornoCep.LimparDados;

  if FRESTResponse.StatusCode = SUCESS_HTTPCODE then
  begin
    if Assigned(FcdsResponse.FindField('cep')) then
      FRetornoCep.cep := FcdsResponse.FieldByName('cep').AsString;

    if Assigned(FcdsResponse.FindField('state')) then
      FRetornoCep.UF := FcdsResponse.FieldByName('state').AsString;

    if Assigned(FcdsResponse.FindField('city')) then
      FRetornoCep.Cidade := FcdsResponse.FieldByName('city').AsString;

    if Assigned(FcdsResponse.FindField('neighborhood')) then
      FRetornoCep.Bairro := FcdsResponse.FieldByName('neighborhood').AsString;

    if Assigned(FcdsResponse.FindField('street')) then
      FRetornoCep.Logradouro := FcdsResponse.FieldByName('street').AsString;

    if Assigned(FcdsResponse.FindField('service')) then
      FRetornoCep.Servico := FcdsResponse.FieldByName('service').AsString;

    if Assigned(FcdsResponse.FindField('location')) then
    begin
      if Assigned(FcdsResponse.FindField('location.type')) then
        FRetornoCep.Tipo_localizacao := FcdsResponse.FieldByName('location.type').AsString;

      if Assigned(FcdsResponse.FindField('location.coordinates')) then
      begin
        if Assigned(FcdsResponse.FindField('location.coordinates.latitude')) then
          FRetornoCep.Latitude := FcdsResponse.FieldByName('location.coordinates.latitude').AsString;

        if Assigned(FcdsResponse.FindField('location.coordinates.longitude')) then
          FRetornoCep.Longitude := FcdsResponse.FieldByName('location.coordinates.longitude').AsString;
      end;
    end;
  end
  else if FRESTResponse.StatusCode = HTTPCODE_NOT_FOUND then
  begin
    FRetornoCep.Erro := 'Ocorreu um erro na consulta de CEP!';

    if Assigned(FcdsResponse.FindField('type')) then
      FRetornoCep.Erro := FRetornoCep.Erro + sLineBreak + FcdsResponse.FieldByName('type').AsString + ': ';

    if Assigned(FcdsResponse.FindField('message')) then
      FRetornoCep.Erro := FRetornoCep.Erro + FcdsResponse.FieldByName('message').AsString;

//    if Assigned(FcdsResponse.FindField('name')) then
//      FRetornoCep.Erro := FcdsResponse.FieldByName('name').AsString;
  end
  else if FRESTResponse.StatusCode = HTTPCODE_INTERNAL_SERVER_EROOR then
  begin
    FRetornoCep.Erro := 'Ocorreu um erro na consulta de CEP!' + sLineBreak + FRESTResponse.Content;
  end;
end;

function TConsultaCEP.ConsultarCEP(aCep : String) : Boolean;
var
  vCep : String;
begin
  vCep := StringReplace(aCep, '-', '', [rfReplaceAll]);

  if validarCep(vCep) then
  begin
    try
      FRESTResponseDataSetAdapter.Active := False;
      FRESTRequest.Resource := vCep;
      FRESTRequest.Execute;
      FRESTResponseDataSetAdapter.Active := True;

      lerRetornoRest;

      Result := FRetornoCep.Erro = EmptyStr;
    except
      on E:Exception do
      begin
        Result := False;
        if (FRESTResponse.StatusCode = REQUEST_TIMEOUT)
           or (Pos('time out', AnsiLowerCase(FRESTResponse.Content)) > 1)
           or (Pos('timeout', AnsiLowerCase(FRESTResponse.Content)) > 1)
           or (Pos('(12002) o tempo limite da operação foi atingido', AnsiLowerCase(FRESTResponse.Content)) > 1)
           or (Pos('time out', AnsiLowerCase(FRetornoCep.Erro)) > 1)
           or (Pos('timeout', AnsiLowerCase(FRetornoCep.Erro)) > 1)
           or (Pos('(12002) o tempo limite da operação foi atingido', AnsiLowerCase(FRetornoCep.Erro)) > 1)
        then
        begin
          FRetornoCep.Erro := 'Serviço está indisponível, tente novamente mais tarde.';
        end
        else
          FRetornoCep.Erro := 'Ocorreu um erro ao consultar o CEP:' + sLineBreak + E.Message;
      end;
    end;
  end
  else
    Result := False;
end;

constructor TConsultaCEP.Create();
begin
  FRetornoCep := TRetornoCep.Create;
  InicializarComponentesREST;
end;

destructor TConsultaCEP.Destroy;
begin
  FRetornoCep.Free;
  FRESTResponseDataSetAdapter.Free;
  FRESTClient.Free;
  FRESTResponse.Free;
  FRESTRequest.Free;
  FcdsResponse.Free;
  inherited;
end;

function TConsultaCEP.validarCep(aCep : String) : Boolean;
var
  ExpressaoRegular: TRegEx;
begin
  ExpressaoRegular := TRegEx.Create('^\d{8}$');

  if not (ExpressaoRegular.IsMatch(aCep)) then
  begin
    FRetornoCep.Erro := 'CEP inválido!' + sLineBreak + 'Corrija o CEP e tente novamente.';
    Result := False;
  end
  else
    Result := True;
end;
{ TRetornoCep }

procedure TRetornoCep.LimparDados;
begin
  Fcep := EmptyStr;
  FLogradouro := EmptyStr;
  FTipo_localizacao := EmptyStr;
  FLatitude := EmptyStr;
  FBairro := EmptyStr;
  FServico := EmptyStr;
  FUF := EmptyStr;
  FCidade := EmptyStr;
  FLongitude := EmptyStr;
  FErro := EmptyStr;
end;

end.
