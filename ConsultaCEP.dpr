program ConsultaCEP;

uses
  System.StartUpCopy,
  FMX.Forms,
  ConsultaCEP.View.Principal in 'ConsultaCEP.View.Principal.pas' {frmPrincipal},
  ConsultaCEP.Model.Endereco in 'ConsultaCEP.Model.Endereco.pas',
  ConsultaCEP.Controller.Endereco in 'ConsultaCEP.Controller.Endereco.pas',
  ConsultaCEP.Model.Records.Endereco in 'ConsultaCEP.Model.Records.Endereco.pas',
  uFormat in 'uFormat.pas',
  uFuncoesGerais in 'uFuncoesGerais.pas',
  framePopUpDialogBox in 'framePopUpDialogBox.pas' {frameTelaPopUpDialogBox: TFrame},
  dmDataBase in 'dmDataBase.pas' {dmDB: TDataModule},
  ConsultaCEP.Model.db.Endereco in 'ConsultaCEP.Model.db.Endereco.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmDB, dmDB);
  Application.Run;
end.
