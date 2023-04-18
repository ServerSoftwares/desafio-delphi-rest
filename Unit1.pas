unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, UConsultaCEP,
  Vcl.Mask, REST.Json, Data.DB, Data.Win.ADODB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    btnValidarCEP: TButton;
    medtCEP: TMaskEdit;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    cbFiltro: TComboBox;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    btnFiltro: TButton;
    procedure btnValidarCEPClick(Sender: TObject);
    procedure cbFiltroChange(Sender: TObject);
    procedure btnFiltroClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ProgressBar1: TProgressBar;

implementation

Uses dmdCep;

{$R *.dfm}

procedure TForm1.btnFiltroClick(Sender: TObject);
begin
  dmCEP.FiltrarConsulta(cbFiltro.ItemIndex, Edit1.text, Edit2.text);
end;

procedure TForm1.btnValidarCEPClick(Sender: TObject);
var
  ConsultaCEP : TConsultaCEP;
begin
  ProgressBar1 := TProgressBar.Create(Self);
  ProgressBar1.Parent := Form1;
  ProgressBar1.Max := 100;
  ProgressBar1.Width := 200;
  ProgressBar1.Height := 100;
  ConsultaCEP.Create;
  ProgressBar1.Position := 50;
  dmCEP.InserirCEPAPI(ConsultaCEP.ConsultarCEP(medtCEP.text));
  ProgressBar1.Position := 100;
  FreeAndNil(ProgressBar1);
end;

procedure TForm1.cbFiltroChange(Sender: TObject);
begin
  if cbFiltro.ItemIndex = 2 then
    Edit2.Visible := True
  else
    Edit2.Visible := False;
end;

end.
