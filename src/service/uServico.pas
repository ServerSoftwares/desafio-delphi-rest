unit uServico;

interface

uses Horse, FireDAC.Comp.Client, RESTRequest4D, DataSet.Serialize,
  Data.DB, uConexao, uCEP, System.SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Dapt, System.JSON,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  Rest.JSON, Data.DBXJSON, REST.Response.Adapter, uConsultaCEP;


type
  TServico = class
  private
    FConexao: TFormConexao;
    FCEP: TCEP;
  public
    constructor Create;
    function VerificaCEPCadastrado(XCEP: string; out XCta: integer): TCEP;
    function CarregaListaCEP: TFDQuery;
    procedure IncluiCEP(XCEP: TCEP);
  end;

implementation

uses
  Vcl.Dialogs;

{ TServico }


procedure TServico.IncluiCEP(XCEP: TCEP);
var query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  try
    try
      FConexao.FDConnection1.StartTransaction;
      with query do
      begin
        Connection := FConexao.FDConnection1;
        DisableControls;
        Close;
        SQL.Clear;
        Params.Clear;
        SQL.Add('insert into "cep" ("cep","state","city","neighborhood","street","service") ');
        SQL.Add('values (:xcep,:xstate,:xcity,:xneighborhood,:xstreet,:xservice) ');
        ParamByName('xcep').AsString          := XCEP.cep;
        ParamByName('xstate').AsString        := XCEP.state;
        ParamByName('xcity').AsString         := XCEP.city;
        ParamByName('xneighborhood').AsString := XCEP.neighborhood;
        ParamByName('xstreet').AsString       := XCEP.street;
        ParamByName('xservice').AsString      := XCEP.service;
        ExecSQL;
        EnableControls;
      end;
      FConexao.FDConnection1.Commit;
    except
      On E: Exception do
      begin
        FConexao.FDConnection1.Rollback;
        showmessage('Problema ao incluir CEP '+E.Message);
      end;
    end;
  finally
    query.DisposeOf;
  end;
end;

function TServico.VerificaCEPCadastrado(XCEP: string; out XCta: integer): TCEP;
var query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  try
    if not FConexao.AbreConexaoBD then
       begin
         result := nil;
         exit;
       end;
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
    XCta   := query.RecordCount;
    Result := TJson.JsonToObject<TCEP>(query.ToJSONObject.ToString);
  finally
    FConexao.FechaConexaoBD;
    query.DisposeOf;
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
      query.FieldByName('id').Visible := false;
      query.FieldByName('city').DisplayWidth := 30;
      query.FieldByName('neighborhood').DisplayWidth := 30;
      query.FieldByName('street').DisplayWidth := 30;
    end;
    Result := query;
  finally
  end;
end;

constructor TServico.Create;
begin
  Fconexao := TFormConexao.Create(nil);
end;
end.
