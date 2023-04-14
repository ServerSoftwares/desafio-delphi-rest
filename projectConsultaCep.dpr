program projectConsultaCep;

uses
  System.StartUpCopy,
  FMX.Forms,
  uPrincipal in '..\ConsultaCepnew\Fonte\View\uPrincipal.pas' {frmPrincipal},
  uConsultaCep in '..\ConsultaCepnew\Fonte\Controller\uConsultaCep.pas',
  uRetornoCep in '..\ConsultaCepnew\Fonte\Controller\uRetornoCep.pas',
  uLog in '..\ConsultaCepnew\Fonte\Controller\uLog.pas',
  uDAOCEP in '..\ConsultaCepnew\Fonte\Model\uDAOCEP.pas',
  uValidaCep in '..\ConsultaCepnew\Fonte\Controller\uValidaCep.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

