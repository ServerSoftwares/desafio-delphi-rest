unit uConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  TFormConexao = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDMemTableCEP: TFDMemTable;
    FDMemTableCEPcep: TStringField;
    FDMemTableCEPstate: TStringField;
    FDMemTableCEPcity: TStringField;
    FDMemTableCEPneighborhood: TStringField;
    FDMemTableCEPstreet: TStringField;
    FDMemTableCEPservice: TStringField;
  private
    { Private declarations }
  public
    function AbreConexaoBD: boolean;
    function FechaConexaoBD: boolean;
    { Public declarations }
  end;

var
  FormConexao: TFormConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TFormConexao.AbreConexaoBD: boolean;
begin
  try
    FDConnection1.Connected := true;
    Result := true;
  except
    On E: Exception do
    begin
      result := false;
    end;
  end;
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


end.
