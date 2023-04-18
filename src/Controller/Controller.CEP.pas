unit Controller.CEP;

interface

uses
  Model.CEP.Interfaces,
  Model.Request.Interfaces,
  System.Generics.Collections,
  System.JSON;

type
  TControllerCEP = class(TInterfacedObject, IControllerCEP)
  Private
    FListaCEPs: TList<ICEP>;

    function GetListaCeps: TList<ICEP>;

  Public
    class function New: IControllerCEP;

    constructor Create;
    Destructor Destroy; override;

    procedure RequestCEP(aCEP: String);
    procedure Gravar;

    Procedure PesquisarCEP(aCEP: String);
    procedure Validar(aCEP: String);

    property ListaCeps: TList<ICEP> read GetListaCeps;
  end;

implementation

uses
  Model.CEP,
  Model.Request.Factory,
  System.SysUtils,
  DAO.Cep,
  DataModule;

{ TControllerCEP }

class function TControllerCEP.New: IControllerCEP;
begin
  Result := Self.Create;
end;

constructor TControllerCEP.Create;
begin
  FListaCEPs := TList<ICEP>.Create;
end;

destructor TControllerCEP.Destroy;
begin
  if Assigned(FListaCEPs) then
      FreeAndNil(FListaCEPs);

  inherited;
end;

procedure TControllerCEP.RequestCEP(aCEP: String);
begin
  try
      With TFactorytRequest.NewCEP do
      begin
          Consultar(aCEP);

          if StatusCode <> 200 then
              raise Exception.Create('Não foi possivel consultar o cep, aguarde um momento...');

          FListaCEPs.ParseJSONToCEP(Response);
      end;
  except on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TControllerCEP.Validar(aCEP: String);
begin
  if aCEP = EmptyStr then
      raise Exception.Create('Por favor preencha o CEP para realizar a consulta!');
end;

function TControllerCEP.GetListaCeps: TList<ICEP>;
begin
  Result := FListaCeps;
end;

procedure TControllerCEP.Gravar;
begin
  TDAOCep.New(Dm.FdConnSQLite).GravarCeps(FListaCEPs);
end;

procedure TControllerCEP.PesquisarCEP(aCEP: String);
begin
  With TDAOCep.New(Dm.FdConnSQLite) do
  begin
      if Existe(aCep) then
          Consultar(FListaCeps, aCEP)
      else
      begin
          RequestCEP(aCEP);
          GravarCeps(FListaCEPs);
      end;
  end;
end;

end.
