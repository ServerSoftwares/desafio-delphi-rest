unit uDAOCEP;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, ADODBXP, Data.Win.ADOConEd,
  FMX.Clipboard, Vcl.Clipbrd, FMX.Clipboard.Win;

type
  TRetornoCEP = record
    CEP: string;
    Logradouro: string;
    Bairro: string;
    Cidade: string;
    Estado: string;
  end;

  TCEPCustomDAO = class(TDataModule)
    FConnection: TADOConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetTableNames(const connection: TADOConnection): TArray<string>;
    constructor Create(const AConnectionString: string);
    function Consultar(const ACep: string): TRetornoCEP;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

constructor TCEPCustomDAO.Create(const AConnectionString: string);
begin
  FConnection := TADOConnection.Create(nil);
  FConnection.ConnectionString := AConnectionString;
  Clipboard.AsText := (AConnectionString);
  FConnection.LoginPrompt := False;
  FConnection.Open;
end;

function TCEPCustomDAO.Consultar(const ACep: string): TRetornoCEP;
var
  qrConsultaCEP: TADOQuery;
begin
  Result.CEP := '';
  Result.Logradouro := '';
  Result.Bairro := '';
  Result.Cidade := '';
  Result.Estado := '';

  qrConsultaCEP := TADOQuery.Create(nil);
  try
    qrConsultaCEP.Connection := FConnection;
    qrConsultaCEP.SQL.Text := 'SELECT * FROM tbCEP WHERE CEP = ' + QuotedStr(ACep);
    qrConsultaCEP.Open;

    if not qrConsultaCEP.IsEmpty then
    begin
      Result.CEP := qrConsultaCEP.FieldByName('CEP').AsString;
      Result.Logradouro := qrConsultaCEP.FieldByName('Logradouro').AsString;
      Result.Bairro := qrConsultaCEP.FieldByName('Bairro').AsString;
      Result.Cidade := qrConsultaCEP.FieldByName('Cidade').AsString;
      Result.Estado := qrConsultaCEP.FieldByName('Estado').AsString;
    end;
  finally
    qrConsultaCEP.Free;
  end;
end;

function TCEPCustomDAO.GetTableNames(const connection: TADOConnection): TArray<string>;
var
  schema: string;
  tables: TADOTable;
  tableNames: TArray<string>;
  i: Integer;
begin
  schema := connection.DefaultDatabase;
  tables := TADOTable.Create(nil);
  try
    tables.Connection := connection;
    tables.TableName := 'INFORMATION_SCHEMA.TABLES';
    tables.Filter := 'TABLE_SCHEMA=''' + schema + '''';
    tables.Open;
    SetLength(tableNames, tables.RecordCount);
    tables.First;
    i := 0;
    while not tables.Eof do
    begin
      tableNames[i] := tables.FieldByName('TABLE_NAME').AsString;
      Inc(i);
      tables.Next;
    end;
  finally
    tables.Free;
  end;
  Result := tableNames;
end;

end.

