unit uConfigura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Samples.Spin, IniFiles;

type
  TFormConfigura = class(TForm)
    Panel1: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    MaskEditCEP: TMaskEdit;
    SpinEditTempo: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEditNumero: TSpinEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConfigura: TFormConfigura;

implementation

{$R *.dfm}

procedure TFormConfigura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormConfigura := nil;
  Action        := caFree;
end;

procedure TFormConfigura.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var arqini: TIniFile;
begin
  try
    arqini := TIniFile.Create(GetCurrentDir+'\Desafio.ini');
    arqini.WriteString('CEPAutomatico','CEP',MaskEditCEP.Text);
    arqini.WriteString('CEPAutomatico','Tempo',SpinEditTempo.Value.ToString);
    arqini.WriteString('CEPAutomatico','Numero',SpinEditNumero.Value.ToString);
  finally
    arqini.DisposeOf;
  end;
end;

procedure TFormConfigura.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then
     close;
end;

end.
