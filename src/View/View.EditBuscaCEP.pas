unit View.EditBuscaCEP;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation,
  FMX.Edit, FMX.Layouts, FMX.Effects;

type
  TfrEditBuscaCEP = class(TFrame)
    recBackgrounEdit: TRectangle;
    layMain: TLayout;
    edtCEP: TEdit;
    pthSearch: TPath;
    shEditCEP: TShadowEffect;
    recPath: TRectangle;
    procedure edtCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtCEPMouseEnter(Sender: TObject);
    procedure edtCEPMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TfrEditBuscaCEP.edtCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
//  if Length(edtCEP.Text) = 2 then
//      edtCEP.Text := edtCEP.Text + '.'
//  else
//  if Length(edtCEP.Text) = 6 then
//      edtCEP.Text := edtCEP.Text + '-';

//  edtCEP.SelStart := Length(edtCEP.Text);
end;

procedure TfrEditBuscaCEP.edtCEPMouseEnter(Sender: TObject);
begin
  shEditCEP.Enabled := edtCEP.IsFocused;
end;

procedure TfrEditBuscaCEP.edtCEPMouseLeave(Sender: TObject);
begin
  shEditCEP.Enabled := edtCEP.IsFocused;
end;

end.