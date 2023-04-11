program Desafio;

uses
  Vcl.Forms,
  uDesafio in 'view\uDesafio.pas' {FormDesafio},
  uConexao in 'repository\uConexao.pas' {FormConexao: TDataModule},
  uServico in 'service\uServico.pas',
  uCEP in 'model\uCEP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormDesafio, FormDesafio);
  Application.CreateForm(TFormConexao, FormConexao);
  Application.Run;
end.
