unit conexaoDB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TConexao = class
  private
    FFDConnection : TFDConnection;
    FQuery : TFDQuery;
  public
    property FDConnection: TFDConnection read FFDConnection write FFDConnection;
    property Query : TFDQuery read FQuery write FQuery;

    constructor Create();
    destructor Destroy; override;
    procedure VerificaConexao;
  end;

implementation

{ TConexao }

constructor TConexao.Create();
begin
  inherited;
  FFDConnection := TFDConnection.Create(nil);
  FFDConnection.Params.Add('User_Name=postgres');
  FFDConnection.Params.Add('Password=postgres');
  FFDConnection.Params.Add('DriverID=PG');
  FFDConnection.LoginPrompt := False;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FFDConnection;
end;

destructor TConexao.Destroy;
begin
  FFDConnection.Free;
  FQuery.Free;
  inherited;
end;

procedure TConexao.VerificaConexao;
begin
  if not FFDConnection.Connected then
  begin
    FFDConnection.Connected := True;

    FQuery.SQL.Clear;
    FQuery.SQL.Add(
      ' CREATE SCHEMA IF NOT EXISTS cache_endereco ' +
      ' AUTHORIZATION postgres; ');
    FQuery.ExecSQL;


  //-- Table: cache_endereco.endereco
  //
  //-- DROP TABLE IF EXISTS cache_endereco.endereco;
    FQuery.SQL.Clear;
    FQuery.SQL.Add(
     '  CREATE TABLE IF NOT EXISTS cache_endereco.endereco                        ' +
     '  (                                                                         ' +
     '      id bigint NOT NULL,                                                   ' +
     '      cep integer NOT NULL,                                                 ' +
     '      uf character(2) COLLATE pg_catalog."default",                         ' +
     '      cidade character varying COLLATE pg_catalog."default",                ' +
     '      bairro character varying COLLATE pg_catalog."default",                ' +
     '      logradouro character varying COLLATE pg_catalog."default",            ' +
     '      servico character varying COLLATE pg_catalog."default",               ' +
     '      tipo_localizacao character varying COLLATE pg_catalog."default",      ' +
     '      latitude character varying COLLATE pg_catalog."default",              ' +
     '      longitude character varying COLLATE pg_catalog."default",             ' +
     '      CONSTRAINT cep_endereco_pkey PRIMARY KEY (id))                        ');
//     '     TABLESPACE pg_default;'
    FQuery.ExecSQL;


    FQuery.SQL.Clear;
    FQuery.SQL.Add(
    '  ALTER TABLE IF EXISTS cache_endereco.endereco ' +
    '    OWNER to postgres; ');
    FQuery.ExecSQL;


  //-- Index: idx_endereco_cep
  //
  //-- DROP INDEX IF EXISTS cache_endereco.idx_endereco_cep;
    FQuery.SQL.Clear;
    FQuery.SQL.Add(
     ' CREATE UNIQUE INDEX IF NOT EXISTS idx_endereco_cep ' +
     '     ON cache_endereco.endereco USING btree         ' +
     '     (cep ASC NULLS LAST)                           ' +
     '     TABLESPACE pg_default;                         ');
    FQuery.ExecSQL;


    FQuery.SQL.Clear;
    FQuery.SQL.Add(
     ' CREATE SEQUENCE IF NOT EXISTS cache_endereco.seq_endereco_id  ' +
     '     INCREMENT 1                                 ' +
     '     START 1                                     ' +
     '     MINVALUE 1;                                 ');
    FQuery.ExecSQL;


    FQuery.SQL.Clear;
    FQuery.SQL.Add(
     ' ALTER SEQUENCE cache_endereco.seq_endereco_id ' +
     '     OWNER TO postgres;                        ');
    FQuery.ExecSQL;
  end;
end;

end.
