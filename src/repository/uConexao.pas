unit uConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, IniFiles;

type
  TFormConexao = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ConfiguraConexao;
    { Private declarations }
  public
    function AbreConexaoBD: boolean;
    function FechaConexaoBD: boolean;
    { Public declarations }
  end;

var
  FormConexao: TFormConexao;

implementation

uses
  Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TFormConexao.AbreConexaoBD: boolean;
begin
  try
    ConfiguraConexao;
//    FDConnection1.Connected := true;
    Result := true;
  except
    On E: Exception do
    begin
      showmessage('Problema ao conectar banco de dados '+E.Message);
      result := false;
    end;
  end;
end;

procedure TFormConexao.DataModuleCreate(Sender: TObject);
begin
  ConfiguraConexao;
end;

function TFormConexao.FechaConexaoBD: boolean;
begin
  try
    FDConnection1.Connected := false;
    Result := true;
  except
    On E: Exception do
    begin
      result := false;
    end;
  end;
end;

procedure TFormConexao.ConfiguraConexao;
var arqini: TIniFile;
    database,server,porta,vendorlib: string;
begin
  if not FileExists(GetCurrentDir+'\Desafio.ini') then
     begin
       showmessage('Atenção! Arquivo '+GetCurrentDir+'\Desafio.ini não localizado');
       exit;
     end;

  arqini := TIniFile.Create(GetCurrentDir+'\Desafio.ini');
  try
    vendorlib := arqini.ReadString('ConexaoDB','VendorLib','');
    database  := arqini.ReadString('ConexaoDB','DataBase','');
    server    := arqini.ReadString('ConexaoDB','Server','');
    porta     := arqini.ReadString('ConexaoDB','Porta','');

    try
      FDConnection1.Connected       := false;
      FDPhysPgDriverLink1.VendorLib := vendorlib;
      FDConnection1.Params.Clear;
      FDConnection1.Params.Add('Database='+database);
      FDConnection1.Params.Add('Server='+server);
      FDConnection1.Params.Add('User_Name=postgres');
      FDConnection1.Params.Add('Password=postgres');
      FDConnection1.Params.Add('Server='+server);
      FDConnection1.Params.Add('Port='+porta);
      FDConnection1.Params.Add('DriverID=PG ');

      FDConnection1.Connected := true;
    Except
      On E: Exception do
      begin
        ShowMessage('Erro ao conectar banco de dados '+E.Message);
      end;
    end;
  finally
    arqini.DisposeOf;
  end;
end;
end.
