unit dmdCEP;

interface

uses
  System.SysUtils, System.Classes, Data.Win.ADODB, Data.DB, RetornoCEP;

type
  TdmCEP = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    ADODataSet1CodigoCEP: TAutoIncField;
    ADODataSet1CEP: TStringField;
    ADODataSet1estado: TStringField;
    ADODataSet1bairro: TStringField;
    ADODataSet1cidade: TStringField;
    ADODataSet1rua: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FiltrarConsulta(iCodigoFiltro: Integer; sFiltro, sFiltro2: string);
    procedure InserirCEPAPI(ARetornoCEP: TRetornoCEP);
  end;

var
  dmCEP: TdmCEP;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmCEP }

{ TdmCEP }

procedure TdmCEP.FiltrarConsulta(iCodigoFiltro: Integer; sFiltro, sFiltro2: string);
begin
  ADODataSet1.Filtered := false;

  case iCodigoFiltro of
    0 :  ADODataSet1.Filter := 'estado = ' + QuotedStr(sFiltro);
    1 :  ADODataSet1.Filter := 'uf = ' + QuotedStr(sFiltro);
    2 :  ADODataSet1.Filter := 'CEP >= ' + QuotedStr(sFiltro) + ' AND CEP <= ' + QuotedStr(sFiltro2);
  end;

  ADODataSet1.Filtered := True;
end;

procedure TdmCEP.InserirCEPAPI(ARetornoCEP: TRetornoCEP);
begin
  //ADODataSet1.Close;
  ADODataSet1.Append;
  ADODataSet1estado.AsString := ARetornoCEP.UF;
  ADODataSet1bairro.AsString := ARetornoCEP.Bairro;
  ADODataSet1cidade.AsString := ARetornoCEP.Cidade;
  ADODataSet1rua.AsString    := ARetornoCEP.Rua;
  ADODataSet1CEP.AsString    := ARetornoCEP.CEP;
  ADODataSet1.Post;
end;

end.
