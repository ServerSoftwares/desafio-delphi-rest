unit uServico;

interface

uses Horse, FireDAC.Comp.Client, RESTRequest4D, DataSet.Serialize,
  Data.DB, uConexao, uCEP, System.SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Dapt, System.JSON,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  Rest.JSON, Data.DBXJSON, REST.Response.Adapter;


type
  TServico = class
  private
    FConexao: TFormConexao;
    FCEP: TCEP;
    procedure IncluiCEP;
    function GetCEP(XCEP: string): Boolean;
  public
    constructor Create;
    function CarregaCEP(XCEP: string): TCEP;
    function CarregaListaCEP: TFDQuery;
  end;

implementation

uses
  Vcl.Dialogs;

{ TServico }

function TServico.CarregaCEP(XCEP: string): TCEP;
var query: TFDQuery;
begin
  query    := TFDQuery.Create(nil);
  try
    if not FConexao.AbreConexaoBD then
       exit;
    with query do
    begin
      Connection := Fconexao.FDConnection1;
      DisableControls;
      Close;
      SQL.Clear;
      Params.Clear;
      SQL.Add('select * from "cep" where "cep"."cep"=:xcep ');
      ParamByName('xcep').AsString := XCEP;
      Open;
      EnableControls;
    end;

    if query.RecordCount=0 then //
       begin
         if GetCEP(XCEP) then
            begin
              IncluiCEP;
              with query do
              begin
                Connection := Fconexao.FDConnection1;
                DisableControls;
                Close;
                SQL.Clear;
                Params.Clear;
                SQL.Add('select * from "cep" order by "id" DESC limit 1 ');
                Open;
                EnableControls;
              end;
            end;
       end;
    Result := TJson.JsonToObject<TCEP>(query.ToJSONObject.ToString);
  finally
    query.DisposeOf;
  end;
end;

procedure TServico.IncluiCEP;
var query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  try
    with query do
    begin
      Connection := FConexao.FDConnection1;
      DisableControls;
      Close;
      SQL.Clear;
      Params.Clear;
      SQL.Add('insert into "cep" ("cep","state","city","neighborhood","street","service") ');
      SQL.Add('values (:xcep,:xstate,:xcity,:xneighborhood,:xstreet,:xservice) ');
      ParamByName('xcep').AsString          := FCEP.cep;
      ParamByName('xstate').AsString        := FCEP.state;
      ParamByName('xcity').AsString         := FCEP.city;
      ParamByName('xneighborhood').AsString := FCEP.neighborhood;
      ParamByName('xstreet').AsString       := FCEP.street;
      ParamByName('xservice').AsString      := FCEP.service;
      ExecSQL;
      EnableControls;
    end;
  except
    On E: Exception do
    begin
      showmessage('Problema ao incluir CEP '+E.Message);
    end;
  end;
end;

function TServico.CarregaListaCEP: TFDQuery;
var query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  try
    if not FConexao.AbreConexaoBD then
       exit;
    with query do
    begin
      Connection := FConexao.FDConnection1;
      DisableControls;
      Close;
      SQL.Clear;
      Params.Clear;
      SQL.Add('select * from "cep" order by "cep" ');
      Open;
      EnableControls;
    end;
    Result := query;
  finally
  end;
end;

constructor TServico.Create;
begin
  Fconexao := TFormConexao.Create(nil);
end;

function TServico.GetCEP(XCEP: string): Boolean;
var wresponse: IResponse;
    wret: boolean;
    wfiltro: string;
begin
  try
    FConexao.FDMemTableCEP.Open;
    wresponse := TRequest.New.BaseURL('http://brasilapi.com.br/api/cep/v1/'+XCEP)
      .Accept('application/json')
      .Timeout(300000) // 300 segundos
      .Get;
    FCEP    := TJson.JsonToObject<TCEP>(wresponse.Content);
    case wresponse.StatusCode of
      400,404,500: begin
                 wret := false;
               end;
    else
       begin
         wret := true;
       end;
    end;
  except
    wret := false;
  end;
  result := wret;
end;
end.
