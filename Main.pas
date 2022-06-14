unit Main;

interface

uses
  //Sistema
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Mask,  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,

  //ClientDataSet
  Datasnap.DBClient, Data.DB,

  //Threads
  System.Threading,

  //Projeto
  ConsultaCEP, Endereco, EnderecoDAO;

type
  TfrmConsultaCep = class(TForm)
    pnlMain: TPanel;
    pgcPrincipal: TPageControl;
    tbsConsultaCep: TTabSheet;
    tbsPesquisa: TTabSheet;
    pnlConsultaMain: TPanel;
    pnlPesquisaMain: TPanel;
    pnlConsultaTop: TPanel;
    Label1: TLabel;
    btnConsultarCep: TButton;
    maskEdtCep: TMaskEdit;
    pnlConsultaBody: TPanel;
    DBGridResultadoCep: TDBGrid;
    cdsCeps: TClientDataSet;
    cdsCepscep: TStringField;
    cdsCepsUF: TStringField;
    cdsCepsCidade: TStringField;
    cdsCepsBairro: TStringField;
    cdsCepsLogradouro: TStringField;
    cdsCepsServico: TStringField;
    cdsCepsTipo_localizacao: TStringField;
    cdsCepsLatitude: TStringField;
    cdsCepsLongitude: TStringField;
    dsCeps: TDataSource;
    pnlPesquisaTop: TPanel;
    tbsConfiguracao: TTabSheet;
    pnlConfigMain: TPanel;
    btnPesquisar: TButton;
    Label2: TLabel;
    pnlPesquisaBody: TPanel;
    pnlPesquisaFooter: TPanel;
    pnlConfigBody: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    edtFiltroUF: TEdit;
    edtFiltroEndereco: TEdit;
    Label6: TLabel;
    DBNavigator1: TDBNavigator;
    mskEdtFiltroCepInicial: TMaskEdit;
    mskEdtFiltroCepFinal: TMaskEdit;
    DBGrid1: TDBGrid;
    cdsPesquisaEndereco: TClientDataSet;
    cdsPesquisaEnderecoCep: TStringField;
    cdsPesquisaEnderecoUF: TStringField;
    cdsPesquisaEnderecoCidade: TStringField;
    cdsPesquisaEnderecoBairro: TStringField;
    cdsPesquisaEnderecoLogradouro: TStringField;
    cdsPesquisaEnderecoServico: TStringField;
    cdsPesquisaEnderecoTipo_localizacao: TStringField;
    cdsPesquisaEnderecoLatitude: TStringField;
    cdsPesquisaEnderecoLongitude: TStringField;
    dsPesquisaEndereco: TDataSource;
    cdsPesquisaEnderecoId: TLargeintField;
    TimerConsultaAutomatica: TTimer;
    edtIntervalo: TEdit;
    Label3: TLabel;
    Label7: TLabel;
    mskEdtFaixaCepInicial: TMaskEdit;
    mskEdtFaixaCepFinal: TMaskEdit;
    StatusBarMain: TStatusBar;
    btnConsultaAutomaticaSobDemanda: TButton;
    Label9: TLabel;
    procedure btnConsultarCepClick(Sender: TObject);
    procedure maskEdtCepKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsPesquisaEnderecoBeforeDelete(DataSet: TDataSet);
    procedure cdsPesquisaEnderecoBeforePost(DataSet: TDataSet);
    procedure TimerConsultaAutomaticaTimer(Sender: TObject);
    procedure addLog(aTipoLog, aMensage : String);
    procedure btnConsultaAutomaticaSobDemandaClick(Sender: TObject);
    procedure edtIntervaloExit(Sender: TObject);
    procedure mskEdtFaixaCepInicialExit(Sender: TObject);
    procedure mskEdtFaixaCepFinalExit(Sender: TObject);
  private
    { Private declarations }
    FEnderecoDAOConsulta : TEnderecoDAO;
    FEnderecoDAOConsultaAutomatica : TEnderecoDAO;
    FEnderecoDAOPesquisa : TEnderecoDAO;
    FTaskConsultaAutomatica : ITask;
    FTaskConsulta : ITask;
    FCepInicial : Integer;
    FCepFinal : Integer;
    procedure TrataRetornoConsulta(aConsultaCep : TConsultaCEP);
    procedure TrataRetornoConsultaAutomatica(aConsultaCep : TConsultaCEP);
    procedure PopularCdsCep(aEndereco : TEndereco);
    procedure LimparCdsItensConsulta;
    procedure LimparCdsItensPesquisa;
    function RetornoCepToEndereco(aRetornoCep : TRetornoCep) : TEndereco;
    function DataSetToEndereco(aDts : TDataset) : TEndereco;
    procedure ConsultaAutomaticaCep();
    procedure ConfiguraRangeConsultaAutomatica;
  public
    { Public declarations }
    procedure ConsultarCep;
  end;

var
  frmConsultaCep: TfrmConsultaCep;

implementation

{$R *.dfm}

procedure TfrmConsultaCep.addLog(aTipoLog, aMensage: String);
var
  vFile : TextFile;
begin
  AssignFile(vFile, 'log.txt');

  {$I-}
  Reset(vFile);
  {$I+}

  if (IOResult <> 0) then
    Rewrite(vFile)
  else
  begin
    CloseFile(vFile);
    Append(vFile);
  end;

  Writeln(vFile, aTipoLog + ': ' + aMensage + SlineBreak);

  CloseFile(vFile);
end;

procedure TfrmConsultaCep.btnConsultarCepClick(Sender: TObject);
begin
  consultarCep;
end;

procedure TfrmConsultaCep.btnPesquisarClick(Sender: TObject);
var
  vListaEnderecos : TList<TEndereco>;
  vEndereco : TEndereco;
begin
  LimparCdsItensPesquisa;

  FEnderecoDAOConsultaAutomatica.filterClear;
  FEnderecoDAOConsultaAutomatica.addFilterByCepRange(StrToIntDef(mskEdtFiltroCepInicial.Text, 0), StrToIntDef(mskEdtFiltroCepFinal.Text, 0));
  FEnderecoDAOConsultaAutomatica.addFilterByUF(edtFiltroUF.Text);
  FEnderecoDAOConsultaAutomatica.addFilterByEndereco(edtFiltroEndereco.Text);
  vListaEnderecos := FEnderecoDAOConsultaAutomatica.ListaEnderecos;

  try
    cdsPesquisaEndereco.DisableControls;
    cdsPesquisaEndereco.BeforePost := nil;
    for vEndereco in vListaEnderecos do
    begin
      cdsPesquisaEndereco.Append;
      cdsPesquisaEnderecoId.AsLargeInt := vEndereco.id;
      cdsPesquisaEnderecoCep.AsInteger := vEndereco.cep;
      cdsPesquisaEnderecoUF.AsString := vEndereco.UF;
      cdsPesquisaEnderecoCidade.AsString := vEndereco.Cidade;
      cdsPesquisaEnderecoBairro.AsString := vEndereco.Bairro;
      cdsPesquisaEnderecoLogradouro.AsString := vEndereco.Logradouro;
      cdsPesquisaEnderecoServico.AsString := vEndereco.Servico;
      cdsPesquisaEnderecoTipo_localizacao.AsString := vEndereco.Tipo_localizacao;
      cdsPesquisaEnderecoLatitude.AsString := vEndereco.Latitude;
      cdsPesquisaEnderecoLongitude.AsString := vEndereco.Longitude;
      cdsPesquisaEndereco.Post;

      FreeAndNil(vEndereco);
    end;
  finally
    cdsPesquisaEndereco.BeforePost := cdsPesquisaEnderecoBeforePost;
    cdsPesquisaEndereco.EnableControls;
    vListaEnderecos.Free;
  end;
end;

procedure TfrmConsultaCep.btnConsultaAutomaticaSobDemandaClick(Sender: TObject);
begin
  if Assigned(FTaskConsultaAutomatica) and (FTaskConsultaAutomatica.Status in [TTaskStatus.Running]) then
    StatusBarMain.Panels.Items[0].Text := 'Executando a consulta Consulta automática por faixa, aguarde o término do processo!'
  else
    ConsultaAutomaticaCep;
end;

procedure TfrmConsultaCep.cdsPesquisaEnderecoBeforeDelete(DataSet: TDataSet);
var
  vEndereco : TEndereco;
begin
  vEndereco := DataSetToEndereco(cdsPesquisaEndereco);
  try
    FEnderecoDAOPesquisa.Delete(vEndereco);
  finally
    vEndereco.Free;
  end;
end;

procedure TfrmConsultaCep.cdsPesquisaEnderecoBeforePost(DataSet: TDataSet);
var
  vEndereco : TEndereco;
begin
  vEndereco := DataSetToEndereco(cdsPesquisaEndereco);
  try
    if cdsPesquisaEnderecoId.AsString <> '' then
      FEnderecoDAOPesquisa.Update(vEndereco)
    else
      FEnderecoDAOPesquisa.Insert(vEndereco);
  finally
    vEndereco.Free;
  end;
end;

procedure TfrmConsultaCep.ConfiguraRangeConsultaAutomatica;
begin
  FCepInicial := StrToIntDef(mskEdtFaixaCepInicial.Text, 0);
  FCepFinal := StrToIntDef(mskEdtFaixaCepFinal.Text, 0);
end;

procedure TfrmConsultaCep.ConsultaAutomaticaCep;
begin
  if not (Assigned(FTaskConsultaAutomatica) and (FTaskConsultaAutomatica.Status in [TTaskStatus.Running])) then
  begin
    StatusBarMain.Panels.Items[0].Text := 'Executando a consulta Consulta automática por faixa';

    FTaskConsultaAutomatica := TTask.Run(
    procedure
    var
      FConsultaCep : TConsultaCep;
      vCep : Integer;
    begin
      FConsultaCep := TConsultaCep.Create;
      try
        try
          for vCep := FCepInicial to FCepFinal do
          begin
            try
              //Aguarda 5 segundos para fazer novo consulta
              sleep(5000);

              if FConsultaCep.ConsultarCEP(vCep.ToString) then
              begin
                TrataRetornoConsultaAutomatica(FConsultaCep);
              end
              else
              begin
                TThread.Synchronize(nil,
                procedure
                begin
                  addLog('Consulta', 'Cep: ' + vCep.ToString + sLineBreak + FConsultaCep.RetornoCep.Erro);
                end);
              end;
            except
              on E:Exception do
              begin
                TThread.Synchronize(nil,
                procedure
                begin
                  addLog('Excecao', 'Cep: ' + vCep.ToString + sLineBreak + E.Message);
                end);
              end;
            end;
          end;

          TThread.Synchronize(nil,
          procedure
          begin
            StatusBarMain.Panels.Items[0].Text := '';
          end);

        except
          on E:Exception do
          begin
            TThread.Synchronize(nil,
            procedure
            begin
              addLog('Excecao', 'Cep: ' + vCep.ToString + sLineBreak + E.Message);
            end);
          end;
        end;
      finally
        FConsultaCep.Free;
      end;
    end);
  end;
end;

procedure TfrmConsultaCep.consultarCep;
var
  vListaEnderecos : TList<TEndereco>;
  vEndereco : TEndereco;
  vCep : Integer;
begin
  LimparCdsItensConsulta;

  FEnderecoDAOConsulta.filterClear;
  FEnderecoDAOConsulta.addFilterByCep(StrToIntDef(maskEdtCep.Text, 0));
  vListaEnderecos := FEnderecoDAOConsulta.ListaEnderecos;
  try
    if vListaEnderecos.Count > 0 then
    begin
      for vEndereco in vListaEnderecos do
      begin
        PopularCdsCep(vEndereco);
        FreeAndNil(vEndereco);
      end;
    end
    else
    begin
      if not (Assigned(FTaskConsulta) and (FTaskConsulta.Status in [TTaskStatus.Running])) then
      begin
        vCep := StrToIntDef(maskEdtCep.Text, 0);

        FTaskConsulta := TTask.Run(
        procedure
        var
          FConsultaCep : TConsultaCep;
        begin
          FConsultaCep := TConsultaCep.Create;
          try
            try
              if FConsultaCep.ConsultarCEP(vCep.ToString) then
              begin
                TThread.Synchronize(nil,
                procedure
                begin
                  TrataRetornoConsulta(FConsultaCep);
                end);
              end
              else
              begin
                TThread.Synchronize(nil,
                procedure
                begin
                  addLog('Consulta', 'Cep: ' + vCep.ToString + sLineBreak + FConsultaCep.RetornoCep.Erro);
                end);

                raise Exception.Create(FConsultaCep.RetornoCep.Erro);
              end;
            except
              on E:Exception do
              begin
                TThread.Synchronize(nil,
                procedure
                begin
                  addLog('Excecao', 'Cep: ' + vCep.ToString + sLineBreak + E.Message);
                  Application.ShowException(E);
                end);
              end;
            end;
          finally
            FConsultaCep.Free;
          end;
        end);
      end
      else
        ShowMessage('Aguarde a conclusão da consulta em andamento.');
    end;
  finally
    vListaEnderecos.Free;
  end;
end;

function TfrmConsultaCep.DataSetToEndereco(aDts: TDataset): TEndereco;
var
  vEndereco : TEndereco;
begin
  vEndereco := TEndereco.Create;
  result := vEndereco;
  vEndereco.id := cdsPesquisaEnderecoId.AsLargeInt;
  vEndereco.cep := cdsPesquisaEnderecoCep.AsInteger;
  vEndereco.UF := cdsPesquisaEnderecoUF.AsString;
  vEndereco.Cidade := cdsPesquisaEnderecoCidade.AsString;
  vEndereco.Bairro := cdsPesquisaEnderecoBairro.AsString;
  vEndereco.Logradouro := cdsPesquisaEnderecoLogradouro.AsString;
  vEndereco.Servico := cdsPesquisaEnderecoServico.AsString;
  vEndereco.Tipo_localizacao := cdsPesquisaEnderecoTipo_localizacao.AsString;
  vEndereco.Latitude := cdsPesquisaEnderecoLatitude.AsString;
  vEndereco.Longitude := cdsPesquisaEnderecoLongitude.AsString;
end;

procedure TfrmConsultaCep.edtIntervaloExit(Sender: TObject);
begin
  TimerConsultaAutomatica.Enabled := False;
  TimerConsultaAutomatica.Interval := StrToIntDef(edtIntervalo.Text, 5) * 60 * 1000;
  TimerConsultaAutomatica.Enabled := True;
end;

procedure TfrmConsultaCep.FormCreate(Sender: TObject);
begin
  ConfiguraRangeConsultaAutomatica;

  cdsCeps.CreateDataSet;
  cdsCeps.Open;

  cdsPesquisaEndereco.CreateDataSet;
  cdsPesquisaEndereco.Open;

  FEnderecoDAOConsulta := TEnderecoDAO.Create;
  FEnderecoDAOConsultaAutomatica := TEnderecoDAO.Create;
  FEnderecoDAOPesquisa := TEnderecoDAO.Create;
end;

procedure TfrmConsultaCep.FormDestroy(Sender: TObject);
begin
  FEnderecoDAOPesquisa.Free;
  FEnderecoDAOConsulta.Free;
  FEnderecoDAOConsultaAutomatica.Free;

  if Assigned(FTaskConsultaAutomatica) then
  begin
    if FTaskConsultaAutomatica.Status in [TTaskStatus.Running] then
      FTaskConsultaAutomatica.Wait();
    FTaskConsultaAutomatica._Release;
  end;

  if Assigned(FTaskConsulta) then
  begin
    if FTaskConsulta.Status in [TTaskStatus.Running] then
      FTaskConsulta.Wait();
    FTaskConsulta._Release;
  end;
end;

procedure TfrmConsultaCep.FormShow(Sender: TObject);
begin
  pgcPrincipal.ActivePage := tbsConsultaCep;
  if maskEdtCep.CanFocus then
    maskEdtCep.SetFocus;
end;

procedure TfrmConsultaCep.LimparCdsItensConsulta;
begin
  cdsCeps.EmptyDataSet;
  cdsCeps.Open;
end;

procedure TfrmConsultaCep.LimparCdsItensPesquisa;
begin
  cdsPesquisaEndereco.EmptyDataSet;
  cdsPesquisaEndereco.Open;
end;

procedure TfrmConsultaCep.maskEdtCepKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    consultarCep;
end;

procedure TfrmConsultaCep.mskEdtFaixaCepFinalExit(Sender: TObject);
begin
  ConfiguraRangeConsultaAutomatica;
end;

procedure TfrmConsultaCep.mskEdtFaixaCepInicialExit(Sender: TObject);
begin
  ConfiguraRangeConsultaAutomatica;
end;

procedure TfrmConsultaCep.PopularCdsCep(aEndereco : TEndereco);
begin
  cdsCeps.Append;
  cdsCepscep.AsInteger := aEndereco.cep;
  cdsCepsUF.AsString := aEndereco.UF;
  cdsCepsCidade.AsString := aEndereco.Cidade;
  cdsCepsBairro.AsString := aEndereco.Bairro;
  cdsCepsLogradouro.AsString := aEndereco.Logradouro;
  cdsCepsServico.AsString := aEndereco.Servico;
  cdsCepsTipo_localizacao.AsString := aEndereco.Tipo_localizacao;
  cdsCepsLatitude.AsString := aEndereco.Latitude;
  cdsCepsLongitude.AsString := aEndereco.Longitude;
  cdsCeps.Post;
end;

function TfrmConsultaCep.RetornoCepToEndereco(
  aRetornoCep: TRetornoCep): TEndereco;
var
  vEndereco : TEndereco;
begin
  vEndereco := TEndereco.Create;
  vEndereco.cep := StrToInt(aRetornoCep.cep);
  vEndereco.UF := aRetornoCep.UF;
  vEndereco.Cidade := aRetornoCep.Cidade;
  vEndereco.Bairro := aRetornoCep.Bairro;
  vEndereco.Logradouro := aRetornoCep.Logradouro;
  vEndereco.Servico := aRetornoCep.Servico;
  vEndereco.Tipo_localizacao := aRetornoCep.Tipo_localizacao;
  vEndereco.Latitude := aRetornoCep.Latitude;
  vEndereco.Longitude := aRetornoCep.Longitude;
  Result := vEndereco;
end;

procedure TfrmConsultaCep.TimerConsultaAutomaticaTimer(Sender: TObject);
begin
  ConsultaAutomaticaCep;
end;

procedure TfrmConsultaCep.TrataRetornoConsulta(aConsultaCep: TConsultaCEP);
var
  vListaEnderecos : TList<TEndereco>;
  vEndereco, vNovoEndereco : TEndereco;
begin
  LimparCdsItensConsulta;

  if aConsultaCep.RetornoCep.Erro = EmptyStr then
  begin
    vEndereco := RetornoCepToEndereco(aConsultaCep.RetornoCep);
    try
      PopularCdsCep(vEndereco);
    finally
      vEndereco.Free;
    end;

    FEnderecoDAOConsulta.addFilterByCep(StrToInt(aConsultaCep.RetornoCep.cep));
    vListaEnderecos := FEnderecoDAOConsulta.ListaEnderecos;
    try
      if vListaEnderecos.Count = 0 then
      begin
        vEndereco := RetornoCepToEndereco(aConsultaCep.RetornoCep);
        try
          FEnderecoDAOConsulta.Insert(vEndereco);
        finally
          FreeAndNil(vEndereco);
        end;
      end
      else
      begin
        for vEndereco in vListaEnderecos do
        begin
          try
            vNovoEndereco := RetornoCepToEndereco(aConsultaCep.RetornoCep);
            vNovoEndereco.id := vEndereco.id;
            FEnderecoDAOConsulta.Update(vNovoEndereco);
          finally
            FreeAndNil(vEndereco);
            FreeAndNil(vNovoEndereco);
          end;
        end;
      end;
    finally
      vListaEnderecos.Free;
    end;
  end
  else
  begin
    raise Exception.Create(aConsultaCep.RetornoCep.Erro);
  end;
end;

procedure TfrmConsultaCep.TrataRetornoConsultaAutomatica(
  aConsultaCep: TConsultaCEP);
var
  vListaEnderecos : TList<TEndereco>;
  vEndereco, vNovoEndereco : TEndereco;
begin
  if aConsultaCep.RetornoCep.Erro = EmptyStr then
  begin
    FEnderecoDAOConsulta.filterClear;
    FEnderecoDAOConsulta.addFilterByCep(StrToInt(aConsultaCep.RetornoCep.cep));
    vListaEnderecos := FEnderecoDAOConsulta.ListaEnderecos;
    try
      if vListaEnderecos.Count = 0 then
      begin
        vEndereco := RetornoCepToEndereco(aConsultaCep.RetornoCep);
        try
          FEnderecoDAOConsulta.Insert(vEndereco);
        finally
          FreeAndNil(vEndereco);
        end;
      end
      else
      begin
        for vEndereco in vListaEnderecos do
        begin
          try
            vNovoEndereco := RetornoCepToEndereco(aConsultaCep.RetornoCep);
            vNovoEndereco.id := vEndereco.id;
            FEnderecoDAOConsulta.Update(vNovoEndereco);
          finally
            FreeAndNil(vEndereco);
            FreeAndNil(vNovoEndereco);
          end;
        end;
      end;
    finally
      vListaEnderecos.Free;
    end;
  end
  else
  begin
    raise Exception.Create(aConsultaCep.RetornoCep.Erro);
  end;
end;

end.
