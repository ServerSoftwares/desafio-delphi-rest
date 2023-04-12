program Desafio;

uses
  Vcl.Forms,
  uDesafio in 'view\uDesafio.pas' {FormDesafio},
  uConexao in 'repository\uConexao.pas' {FormConexao: TDataModule},
  uServico in 'service\uServico.pas',
  uCEP in 'model\uCEP.pas',
  uConsultaCEP in 'service\uConsultaCEP.pas',
  uConfigura in 'view\uConfigura.pas' {FormConfigura};

{$R *.res}

var
   FCEPAutomatico: integer;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormDesafio, FormDesafio);
  Application.CreateForm(TFormConexao, FormConexao);
  Application.Run;
end.
