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
  Vcl.Grids, vcl.wwdbigrd, vcl.wwdbgrid, DataSet.Serialize, uConsultaCEP,
  uConfigura, Vcl.Buttons, IniFiles, System.Threading, Vcl.Samples.Gauges;

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
    SpeedButton1: TSpeedButton;
    Timer1: TTimer;
    Gauge1: TGauge;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxPageControlCEPChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FQuery: TFDQuery;
    procedure CarregaListaCEP;
    procedure ConsultaCEP(XCEP: string; XFlag: boolean);
    procedure LimpaCampos;
    procedure PopulaCampos(XCep: TCEP);
    procedure ConsultaCEPAutomatico;
    procedure AtualizaArquivoIni;
    { Private declarations }
  public
    FAutomatico,FTempo,FNumero: string;
    { Public declarations }
  end;

var
  FormDesafio: TFormDesafio;

implementation

{$R *.dfm}

procedure TFormDesafio.cxPageControlCEPChange(Sender: TObject);
begin
  if cxPageControlCEP.ActivePageIndex=1 then
     CarregaListaCEP;
end;

procedure TFormDesafio.FormActivate(Sender: TObject);
var arqini: TIniFile;
begin
  if not FileExists(GetCurrentDir+'\Desafio.ini') then
     begin
       showmessage('Arquivo '+GetCurrentDir+'\Desafio.ini não localizado');
       exit;
     end;
  arqini := TIniFile.Create(GetCurrentDir+'\Desafio.ini');
  try
    FAutomatico := arqini.ReadString('CEPAutomatico','CEP','00000000');
    FTempo      := arqini.ReadString('CEPAutomatico','Tempo','5');
    FNumero     := arqini.ReadString('CEPAutomatico','Numero','10');
  finally
    Timer1.Interval := 60000 * StrToIntDef(FTempo,5);
    Timer1.Enabled  := true;
    arqini.DisposeOf;
  end;
end;

procedure TFormDesafio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormDesafio := nil;
  Action      := caFree;
end;

procedure TFormDesafio.Button1Click(Sender: TObject);
begin
  if length(trim(MaskEditCEP.Text))<8 then
     showmessage('CEP Inválido')
  else
     ConsultaCEP(MaskEditCEP.Text,true);
end;

procedure TFormDesafio.CarregaListaCEP;
var servico: TServico;
begin
  servico := TServico.Create;
  try
    DataSource1.DataSet := servico.CarregaListaCEP;
  finally
    servico.DisposeOf;
  end;
end;

procedure TFormDesafio.ConsultaCEP(XCEP: string; XFlag: boolean);
var cep: TCEP;
    servico: TServico;
    consulta: TConsultaCEP;
    cta: integer;
    achou: boolean;
begin
  servico  := TServico.Create;
  consulta := TConsultaCEP.Create;
  consulta.mensagem := XFlag;
  try
    if XFlag then
       LimpaCampos;
    cep := servico.VerificaCEPCadastrado(XCEP,cta); // verifica CEP no banco de dados
    if cta=0 then
       begin
         cep := consulta.ConsultarCEP(XCEP,achou).CEP; // consulta CEP na API
         if achou then
            begin
              servico.IncluiCEP(cep); // inclui CEP no banco de dados
              if XFlag then
                 PopulaCampos(cep);
            end;
       end
    else if XFlag then
       PopulaCampos(cep)

  finally
    servico.DisposeOf;
    consulta.DisposeOf;
  end;
end;

procedure TFormDesafio.LimpaCampos;
begin
  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';
  Edit5.Text := '';
  Edit6.Text := '';
end;

procedure TFormDesafio.PopulaCampos(XCep: TCEP);
begin
  Edit1.Text := Xcep.cep;
  Edit2.Text := Xcep.state;
  Edit3.Text := Xcep.city;
  Edit4.Text := Xcep.neighborhood;
  Edit5.Text := Xcep.street;
  Edit6.Text := Xcep.service;
end;


procedure TFormDesafio.SpeedButton1Click(Sender: TObject);
begin
  try
    Timer1.Enabled := false;
    if FormConfigura <> nil then
       FormConfigura.Close;
    FormConfigura := TFormConfigura.Create(nil);
    FormConfigura.MaskEditCEP.Text     := FAutomatico;
    FormConfigura.SpinEditTempo.Value  := StrToIntDef(FTempo,5);
    FormConfigura.SpinEditNumero.Value := StrToIntDef(FNumero,10);
    FormConfigura.Show;
  except
    On E: Exception do
    begin
      showmessage('Erro abrir configuração '+E.Message);
    end;
  end;
end;

procedure TFormDesafio.Timer1Timer(Sender: TObject);
begin
  try
    Timer1.Enabled := false;
    ConsultaCEPAutomatico;
  finally
    Timer1.Enabled := true;
  end;
end;

procedure TFormDesafio.ConsultaCEPAutomatico;
var task: ITask;
begin
  task := TTask.Create(procedure
                       var ix: integer;
                       begin
                         Gauge1.MinValue := 1;
                         Gauge1.MaxValue := StrToInt(FNumero);
                         Gauge1.Progress := 0;
                         for ix := 1 to StrToInt(FNumero) do
                         begin
                           ConsultaCEP(FAutomatico,false);
                           FAutomatico := inttostr(strtoint(FAutomatico)+1);
                           Gauge1.Progress := ix;
                         end;
                         TThread.Synchronize(TThread.CurrentThread,
                         procedure
                         begin
                           AtualizaArquivoIni;
                         end);
                       end);
  task.Start;
end;

procedure TFormDesafio.AtualizaArquivoIni;
var arqini: TIniFile;
begin
  arqini := TIniFile.Create(GetCurrentDir+'\Desafio.ini');
  try
    arqini.WriteString('CEPAutomatico','CEP',FAutomatico);
  finally
    arqini.DisposeOf;
  end;
end;
end.
