unit View.BuscarCEP;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Layouts, FMX.Effects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, View.EditBuscaCEP,
  System.Generics.Collections, Model.CEP.Interfaces;

type
  TFrBuscarCEP = class(TForm)
    layBackGround: TLayout;
    recBackGround: TRectangle;
    layConsult: TLayout;
    layEditsConsult: TLayout;
    recListView: TRectangle;
    lsDadosCEP: TListView;
    frmBuscaCep: TfrEditBuscaCEP;
    procedure frmBuscaCeppthSearchClick(Sender: TObject);
    procedure frmBuscaCepedtCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure frmBuscaCeprecPathClick(Sender: TObject);
  private
    { Private declarations }

    procedure PopularListView(aListaCeps: TList<ICEP>);
  public
    { Public declarations }
  end;

var
  FrBuscarCEP: TFrBuscarCEP;

implementation

uses
  Controller.CEP;

{$R *.fmx}

procedure TFrBuscarCEP.frmBuscaCepedtCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  frmBuscaCep.edtCEPKeyDown(Sender, Key, KeyChar, Shift);

  if Key = vkReturn then
      frmBuscaCeppthSearchClick(Sender);
end;

procedure TFrBuscarCEP.frmBuscaCeppthSearchClick(Sender: TObject);
begin
  try
      With TControllerCEP.New do
      begin
          PesquisarCEP(frmBuscaCep.edtCep.Text);

          if ListaCeps.Count > 0 then
              PopularListView(ListaCeps);
      end;
  except on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TFrBuscarCEP.frmBuscaCeprecPathClick(Sender: TObject);
begin
  frmBuscaCeppthSearchClick(Sender);
end;

procedure TFrBuscarCEP.PopularListView(aListaCeps: TList<ICEP>);
var xCEP: ICEP;
begin
  lsDadosCEP.Items.Clear;
  lsDadosCEP.BeginUpdate;
  try
      for xCEP in aListaCeps do
      begin
          with lsDadosCEP.Items.Add do
          begin
              TagString := xCEP.CEP;
              TListItemText(Objects.FindDrawable('Cep')).Text    := 'CEP: ' + TagString;
              TListItemText(Objects.FindDrawable('Cidade')).Text := xCEP.Cidade + '/' + xCEP.Estado;
              TListItemText(Objects.FindDrawable('Rua')).Text    := xCEP.Rua + ' - ' + xCEP.Bairro;
              TListItemText(Objects.FindDrawable('Servico')).Text:= 'Consultado via: ' + xCEP.Servico;
          end;
      end;
  finally
      lsDadosCEP.EndUpdate;
  end;
end;

end.