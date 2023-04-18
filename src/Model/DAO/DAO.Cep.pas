unit DAO.Cep;

interface

uses
  Model.CEP.Interfaces,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  System.Generics.Collections;

type
  TDAOCep = class(TInterfacedObject, IDAOCep)
  Private
    FConnection: TFDConnection;
    FQuery     : TFDQuery;

    procedure PassarParams(aCep: ICEP);
    procedure ParseToCEPs(aListaCeps: TList<ICEP>);
  Public
    class function New(aConnection: TFDConnection): IDAOCep;

    constructor Create(aConnection: TFDConnection);
    destructor Destroy; Override;

    function Existe(aCep: String): Boolean;

    procedure Consultar(aListaCep: TList<ICEP>; aCep:String);
    procedure GravarCEPs(aListaCeps: TList<ICEP>);


    const cSQL_Consulta = 'Select                 '+
                          '  Cep, Estado, Cidade, '+
                          '  Bairro, Rua, Servico '+
                          'From CEP               '+
                          'Where Cep = :Cep       ';

    const cSQL_Existe   = 'Select           '+
                          '  Cep            '+
                          'From CEP         '+
                          'Where Cep = :Cep ';

    const cSQL_Insert   = 'Insert Into CEP                                    '+
                          '  (Cep, Estado, Cidade, Bairro, Rua, Servico)      '+
                          'Values                                             '+
                          '  (:Cep, :Estado, :Cidade, :Bairro, :Rua, :Servico)';

    const cSQL_Update   = 'Update CEP                                                          '+
                          '  Set Cep = :Cep, Estado = :Estado,                                 '+
                          '  Cidade = :Cidade, Bairro = :Bairro, Rua = :Rua, Servico = :Servico'+
                          'Where Cep = :Cep                                                    ';
  end;

implementation

uses
  System.SysUtils, Model.CEP;

{ TDAOCep }

class function TDAOCep.New(aConnection: TFDConnection): IDAOCep;
begin
  Result := Self.Create(aConnection);
end;

constructor TDAOCep.Create(aConnection: TFDConnection);
begin
  FConnection := aConnection;

  FQuery            := TFDQuery.Create(nil);
  FQuery.Connection := aConnection;
end;

destructor TDAOCep.Destroy;
begin
  if Assigned(FQuery) then
      FreeAndNil(FQuery);

  inherited;
end;

procedure TDAOCep.Consultar(aListaCep: TList<ICEP>; aCep:String);
begin
  try
      try
          FQuery.SQL.Text := cSQL_Consulta;

          if FQuery.Params.FindParam('Cep')     <> nil then
              FQuery.Params.ParamByName('Cep').AsString    := aCep;

          FQuery.Open;

          if FQuery.IsEmpty then
              raise Exception.Create('N�o foi encontrado registro para o cep: ' + aListaCep.First.CEP);

          ParseToCEPs(aListaCep);
      finally
          FQuery.Close;
      end;
  except on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TDAOCep.Existe(aCep: String): Boolean;
begin
  try
      try
          FQuery.SQL.Text := cSQL_Existe;

          if FQuery.Params.FindParam('Cep')     <> nil then
              FQuery.Params.ParamByName('Cep').AsString    := aCep;

          FQuery.Open;

          Result := not FQuery.IsEmpty;
      finally
          FQuery.Close;
      end;
  except on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TDAOCep.GravarCEPs(aListaCeps: Tlist<ICEP>);
var xCEP: ICEP;
begin
  try
      try
          for xCEP in aListaCeps do
          begin
              if Existe(xCEP.CEP) then
                  FQuery.SQL.Text := cSQL_Update
              else
                  FQuery.SQL.Text := cSQL_Insert;

              PassarParams(xCEP);
              FQuery.ExecSQL;
          end;
      finally
          FQuery.Close;
      end;
  except on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TDAOCep.ParseToCEPs(aListaCeps: TList<ICEP>);
var xCep: ICEP;
begin
  while not FQuery.Eof do
  begin
      xCep := TCep.New;

      if FQuery.Fields.FindField('Cep')       <> nil then
          xCep.CEP    := FQuery.Fields.FindField('Cep').AsString;
      if FQuery.Fields.FieldByName('Estado')  <> nil then
          xCep.Estado :=    FQuery.Fields.FindField('Estado').AsString;
      if FQuery.Fields.FieldByName('Cidade')  <> nil then
          xCep.Cidade :=    FQuery.Fields.FieldByName('Cidade').AsString;
      if FQuery.Fields.FieldByName('Bairro')  <> nil then
          xCep.Bairro :=    FQuery.Fields.FieldByName('Bairro').AsString;
      if FQuery.Fields.FieldByName('Rua')     <> nil then
          xCep.Rua    :=    FQuery.Fields.FieldByName('Rua').AsString;
      if FQuery.Fields.FieldByName('Servico') <> nil then
          xCep.Servico:=    FQuery.Fields.FieldByName('Servico').AsString;

      if aListaCeps.IndexOf(xCep) < 0 then
          aListaCeps.Add(xCep);

      FQuery.Next;
  end;
end;

procedure TDAOCep.PassarParams(aCep: ICEP);
begin
  if FQuery.Params.FindParam('Cep')     <> nil then
      FQuery.Params.ParamByName('Cep').AsString    := aCep.CEP;
  if FQuery.Params.FindParam('Estado')  <> nil then
      FQuery.Params.ParamByName('Estado').AsString := aCep.Estado;
  if FQuery.Params.FindParam('Cidade')  <> nil then
      FQuery.Params.ParamByName('Cidade').AsString := aCep.Cidade;
  if FQuery.Params.FindParam('Bairro')  <> nil then
      FQuery.Params.ParamByName('Bairro').AsString := aCep.Bairro;
  if FQuery.Params.FindParam('Rua')     <> nil then
      FQuery.Params.ParamByName('Rua').AsString    := aCep.Rua;
  if FQuery.Params.FindParam('Servico') <> nil then
      FQuery.Params.ParamByName('Servico').AsString:= aCep.Servico;
end;

end.