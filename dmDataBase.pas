unit dmDataBase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI, System.IOUtils,
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TdmDB = class(TDataModule)
    fdConexao: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    tblEnderecos: TFDQuery;
    procedure fdConexaoAfterConnect(Sender: TObject);
    procedure fdConexaoBeforeConnect(Sender: TObject);

  private
    { Private declarations }

    MyDBPath: String;

  public
    { Public declarations }
  end;

var
  dmDB: TdmDB;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmDB.fdConexaoAfterConnect(Sender: TObject);
begin
   try
      if FileExists (MyDBPath) then
         begin
            tblEnderecos.Close;

            fdConexao.ExecSQL('CREATE TABLE IF NOT EXISTS tblEnderecos (CEP      VARCHAR(10) NOT NULL PRIMARY KEY,  '+
                              '                                         Endereco VARCHAR(200),                      '+
                              '                                         Bairro   VARCHAR(200),                      '+
                              '                                         Cidade   VARCHAR(200),                      '+
                              '                                         Estado   VARCHAR(2));                       ');
         end;
   except
   end;
end;

procedure TdmDB.fdConexaoBeforeConnect(Sender: TObject);
begin
   try
      // LOCAL PADRÃO ONDE SE ENCONTRA A TABELA
      MyDBPath := System.SysUtils.GetCurrentDir + '\DB\tblEnderecos.s3db';

      // ATRIBUIÇÃO ONDE SE ENCONTRA A TABELA
      fdConexao.Params.Values['DataBase'] := MyDBPath;
   except
   end;
end;

end.
