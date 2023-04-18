program SrConsultaCEP;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.BuscarCEP in 'View\View.BuscarCEP.pas' {FrBuscarCEP},
  Model.Request.Interfaces in 'Model\Model.Request.Interfaces.pas',
  Model.Request.Factory in 'Model\Model.Request.Factory.pas',
  Model.Request.CEP in 'Model\Model.Request.CEP.pas',
  View.EditBuscaCEP in 'View\View.EditBuscaCEP.pas' {frEditBuscaCEP: TFrame},
  Model.CEP.Interfaces in 'Model\Model.CEP.Interfaces.pas',
  Controller.CEP in 'Controller\Controller.CEP.pas',
  Model.CEP in 'Model\Model.CEP.pas',
  DAO.Cep in 'Model\DAO\DAO.Cep.pas',
  DataModule in 'DataModule\DataModule.pas' {Dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrBuscarCEP, FrBuscarCEP);
  Application.CreateForm(TDm, Dm);
  Application.Run;
end.
