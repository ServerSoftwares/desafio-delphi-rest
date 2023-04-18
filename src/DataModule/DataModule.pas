unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.Client;

type
  TDm = class(TDataModule)
    FdConnSQLite: TFDConnection;
    FdWaitCursor: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    procedure FdConnSQLiteAfterConnect(Sender: TObject);
    procedure FdConnSQLiteBeforeConnect(Sender: TObject);
  private
    { Private declarations }

    procedure CriarBD;
    procedure CriarTabelas;
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDm.CriarBD;
begin
  if not DirectoryExists(GetCurrentDir + '\BD' ) then
      ForceDirectories(GetCurrentDir + '\BD');

  FDConnSQLite.Params.Values['Database'] := GetCurrentDir + '\BD\Database.db';
end;

procedure TDm.CriarTabelas;
var xFDQuery: TFDQuery;
begin
  xFDQuery            := TFDQuery.Create(nil);
  try
      xFDQuery.Connection := FdConnSQLite;

      xFDQuery.ExecSQL('CREATE TABLE IF NOT EXISTS CEP (                     '+
                       '   Cep	          VARCHAR(100) PRIMARY KEY NOT NULL, '+
                       '   Estado	        VARCHAR(100) NOT NULL,             '+
                       '   Cidade	            VARCHAR(100) NOT NULL,         '+
                       '   Bairro	      VARCHAR(100) NOT NULL,               '+
                       '   Rua	        VARCHAR(100) NOT NULL,               '+
                       '   Servico	  VARCHAR(100) NOT NULL)                 ');
  finally
      FreeAndNil(xFDQuery);
  end;
end;

procedure TDm.FdConnSQLiteAfterConnect(Sender: TObject);
begin
  CriarTabelas;
end;

procedure TDm.FdConnSQLiteBeforeConnect(Sender: TObject);
var xFDQuery: TFDQuery;
begin
  CriarBD;
end;

end.