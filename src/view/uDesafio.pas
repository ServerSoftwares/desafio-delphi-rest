unit uDesafio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  uServico, FireDAC.Comp.Client, uCEP, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, dxBarBuiltInMenu, cxPC, Data.DB,
  Vcl.Grids, vcl.wwdbigrd, vcl.wwdbgrid, DataSet.Serialize;

type
  TFormDesafio = class(TForm)
    Panel1: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    MaskEditCEP: TMaskEdit;
    Button1: TButton;
    cxPageControlCEP: TcxPageControl;
    cxTabSheetFicha: TcxTabSheet;
    cxTabSheetLista: TcxTabSheet;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    wwDBGrid1: TwwDBGrid;
    DataSource1: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure cxPageControlCEPChange(Sender: TObject);
  private
    FQuery: TFDQuery;
    procedure CarregaListaCEP;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDesafio: TFormDesafio;

implementation

{$R *.dfm}

procedure TFormDesafio.Button1Click(Sender: TObject);
var cep: TCEP;
    servico: TServico;

begin
  servico  := TServico.Create;
  try
    cep := servico.CarregaCEP(MaskEditCEP.Text);

    Edit1.Text := cep.cep;
    Edit2.Text := cep.state;
    Edit3.Text := cep.city;
    Edit4.Text := cep.neighborhood;
    Edit5.Text := cep.street;
    Edit6.Text := cep.street
  finally
    servico.DisposeOf;
  end;
end;

procedure TFormDesafio.cxPageControlCEPChange(Sender: TObject);
begin
  if cxPageControlCEP.ActivePageIndex=1 then
     CarregaListaCEP;
end;

procedure TFormDesafio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormDesafio := nil;
  Action      := caFree;
end;

procedure TFormDesafio.CarregaListaCEP;
var servico: TServico;
    query: TFDQuery;
begin
  servico := TServico.Create;
  try
    query               := servico.CarregaListaCEP;
    DataSource1.DataSet := query;
  finally
    servico.DisposeOf;
  end;
end;

end.
