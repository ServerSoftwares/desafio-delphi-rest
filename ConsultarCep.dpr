program ConsultarCep;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmConsultaCep},
  Endereco in 'Endereco.pas',
  ConsultaCEP in 'ConsultaCEP.pas',
  enderecoDAO in 'enderecoDAO.pas',
  conexaoDB in 'conexaoDB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmConsultaCep, frmConsultaCep);
  Application.Run;
end.
