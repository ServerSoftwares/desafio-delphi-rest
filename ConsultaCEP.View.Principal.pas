unit ConsultaCEP.View.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Objects, FMX.Edit, FMX.StdCtrls, FMX.Ani, FMX.Controls.Presentation,
  FMX.Layouts, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.TabControl,
  FMX.Effects, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, framePopUpDialogBox,
  ConsultaCEP.Model.Records.Endereco;

type
  TExecutarProcedure = procedure of object; // ROTINA PopUpDialogBox_PerguntaComOpcoes

  TfrmPrincipal = class(TForm)
    layoutToolBar: TLayout;
    lblToolBar: TLabel;
    layoutToolBar_Botoes_e_PesquisarCEP: TLayout;
    BotaoSuperiorEsquerdo: TSpeedButton;
    faBotaoSuperiorEsquerdo_Opacity: TFloatAnimation;
    BotaoSuperiorDireito: TSpeedButton;
    faBotaoSuperiorDireito_Opacity: TFloatAnimation;
    panelBuscarCEP: TPanel;
    eBuscarCEP: TEdit;
    cebBuscarCEP: TClearEditButton;
    imagemBuscarCEP: TImage;
    StyleBookTemaEscuro: TStyleBook;
    layoutMensagemEspera: TLayout;
    rectMensagemEspera_PreencheTelaTransparente: TRectangle;
    layoutMensagemEspera_BoxMeio: TLayout;
    arcAnimacaoEsperaFundo: TArc;
    rectMensagemEspera_BoxMeio: TRectangle;
    shadowMensagemEspera_BoxMeio: TShadowEffect;
    arcAnimacaoEspera: TArc;
    FloatAnimationAnimacaoEspera: TFloatAnimation;
    lblMensagemEspera: TLabel;
    tabPrincipal: TTabControl;
    tabConsultaCEP: TTabItem;
    panelConsultaCEP_Endereco: TPanel;
    lblConsultaCEP_Endereco_Cabecalho: TLabel;
    panelConsultaCEP_Cabecalho: TPanel;
    lblConsultaCEP_Cabecalho: TLabel;
    layoutConsultaCEP_Cidade_UF: TLayout;
    panelConsultaCEP_Bairro: TPanel;
    lblConsultaCEP_Bairro_Cabecalho: TLabel;
    panelConsultaCEP_Cidade: TPanel;
    lblConsultaCEP_Cidade_Cabecalho: TLabel;
    lblConsultaCEP_Cidade: TLabel;
    layoutConsultaCEP_Botoes_SalvarEndereco: TLayout;
    rectConsultaCEP_Botao_SalvarEndereco: TRectangle;
    lblConsultaCEP_Botao_SalvarEndereco: TLabel;
    tabConsultaEndereçosSalvos: TTabItem;
    lblConsultaEndereçosSalvos: TLabel;
    lblConsultaCEP_Endereco: TLabel;
    lblConsultaCEP_Bairro: TLabel;
    panelConsultaCEP_UF: TPanel;
    lblConsultaCEP_UF_Cabecalho: TLabel;
    lblConsultaCEP_UF: TLabel;
    BotaoSuperiorCentralDireito: TSpeedButton;
    faBotaoSuperiorCentralDireito_Opacity: TFloatAnimation;
    frameTelaPopUpDialogBox: TframeTelaPopUpDialogBox;
    layoutConsultaEndereçosSalvos: TLayout;
    lvConsultaEndereçosSalvos: TListView;
    ImagemMenuSuspenso: TImage;
    ImagemMolduraEscura: TImage;

    // INÍCIO DAS PROCEDURES E FUNÇÕES ESPECÍFICAS
    procedure TelaMensagemEspera (TextoMensagem: String;
                                  HabilitaMensagem: Boolean);
    procedure TransicaoTabItemTThreadSynchronize (NomeTabControl: TTabControl;
                                                  NomeTabItem: TTabItem;
                                                  DirecaoTransicaoTabItem: TTabTransitionDirection);
    procedure ActiveTabTThreadSynchronize (NomeTabControl: TTabControl;
                                           NomeTabItem: TTabItem);
    procedure AlteraPropriedadesBotaoSuperiorEsquerdo (Ativar: Boolean;
                                                       Estilo,
                                                       Texto: String;
                                                       TamanhoBotao: Integer);
    procedure AlteraPropriedadesBotaoSuperiorCentralDireito (Ativar: Boolean;
                                                             Estilo,
                                                             Texto: String;
                                                             TamanhoBotao: Integer);
    procedure AlteraPropriedadesBotaoSuperiorDireito (Ativar: Boolean;
                                                      Estilo,
                                                      Texto: String;
                                                      TamanhoBotao: Integer);
    procedure MensagemTThreadSynchronize (Mensagem: String);
    procedure PopUpDialogBox_PerguntaComOpcoes (MensagemDialogBox,
                                                Mensagem00,
                                                Mensagem01,
                                                Mensagem02,
                                                Mensagem03,
                                                Mensagem04,
                                                Mensagem05,
                                                Mensagem06: String;
                                                ExecutarRotina00,
                                                ExecutarRotina01,
                                                ExecutarRotina02,
                                                ExecutarRotina03,
                                                ExecutarRotina04,
                                                ExecutarRotina05,
                                                ExecutarRotina06: TExecutarProcedure);
    procedure RotinaNaoExecutaNadaPopUpDialogBox ();
    procedure IniciaCampos_frmPrincipal ();
    procedure Maximiza_frmPrincipal (MaximizaTela: Boolean);
    procedure IncluiEnderecosNaListView (EnderecoCompleto: TRetornoCEP);
    procedure PopUpDialogBox_ExcluirEnderecoLista ();
    procedure ExcluirEnderecoLista ();
    // FINAL DAS PROCEDURES E FUNÇÕES ESPECÍFICAS

    procedure eBuscarCEPEnter(Sender: TObject);
    procedure eBuscarCEPExit(Sender: TObject);
    procedure eBuscarCEPTyping(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BotaoSuperiorCentralDireitoClick(Sender: TObject);
    procedure imagemBuscarCEPClick(Sender: TObject);
    procedure eBuscarCEPKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure rectConsultaCEP_Botao_SalvarEnderecoClick(Sender: TObject);
    procedure BotaoSuperiorDireitoClick(Sender: TObject);
    procedure BotaoSuperiorEsquerdoClick(Sender: TObject);
    procedure lvConsultaEndereçosSalvosItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  arrayPopUpDialogBoxProcedures: Array of Procedure of object;

implementation

uses
  uFormat,
  uFuncoesGerais,
  dmDataBase,
  ConsultaCEP.Model.Endereco,
  ConsultaCEP.Model.db.Endereco;

{$R *.fmx}

procedure TfrmPrincipal.eBuscarCEPEnter(Sender: TObject);
begin
   TThread.Synchronize(nil,
      procedure
      begin
         try
            // DESABILITA A IMAGEM COM A "LUPA"
            imagemBuscarCEP.Visible := False;
            eBuscarCEP.Margins.Left := 10;
            AlteraPropriedadesBotaoSuperiorCentralDireito(True, 'styleBuscar', '', 44);
            cebBuscarCEP.Visible := True;

            if (Trim (eBuscarCEP.Text) = '') or
               (Trim (eBuscarCEP.Text) = eBuscarCEP.TextPrompt) then
               begin
                  eBuscarCEP.Text := '';
                  eBuscarCEP.TextSettings.FontColor := TAlphaColorRec.White;
               end;
         except
         end;
      end);
end;

procedure TfrmPrincipal.eBuscarCEPExit(Sender: TObject);
begin
   TThread.Synchronize(nil,
      procedure
      begin
         try
            AlteraPropriedadesBotaoSuperiorCentralDireito(False, '', '', 44);

            // HABILITA A IMAGEM COM A "LUPA"
            imagemBuscarCEP.Visible := True;
            eBuscarCEP.Margins.Left := 5;
            cebBuscarCEP.Visible := False;

            if (Trim (eBuscarCEP.Text) = '') or
               (Trim (eBuscarCEP.Text) = eBuscarCEP.TextPrompt) then
               begin
                  eBuscarCEP.Text := '';
                  eBuscarCEP.TextSettings.FontColor := TAlphaColorRec.Darkgray;
               end;
         except
         end;
      end);
end;

procedure TfrmPrincipal.eBuscarCEPKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
   if Key = vkReturn then
      begin
         BotaoSuperiorCentralDireitoClick(Self);
      end;
end;

procedure TfrmPrincipal.eBuscarCEPTyping(Sender: TObject);
begin
   try
      Formatar (Sender, TFormato.CEP);
   except
   end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
   AlteraPropriedadesBotaoSuperiorEsquerdo(False, '', '', 44);
   AlteraPropriedadesBotaoSuperiorCentralDireito(False, '', '', 44);
   AlteraPropriedadesBotaoSuperiorDireito(True, 'styleMenuSuspenso', '', 44);

   // INICIA SEMPRE COM A TAB
   ActiveTabTThreadSynchronize (tabPrincipal{NomeTabControl},
                                tabConsultaCEP{NomeTabItem});

   // INICIA OS CAMPOS DO FORM PRINCIPAL
   IniciaCampos_frmPrincipal ();

   // MINIMIZA FORM PRINCIPAL
   Maximiza_frmPrincipal (False{MaximizaTela});
end;

procedure TfrmPrincipal.imagemBuscarCEPClick(Sender: TObject);
begin
   TThread.Synchronize(nil,
      procedure
      begin
         try
            eBuscarCEP.SetFocus;
         except
         end;
      end);
end;

procedure TfrmPrincipal.TransicaoTabItemTThreadSynchronize (NomeTabControl: TTabControl;
                                                            NomeTabItem: TTabItem;
                                                            DirecaoTransicaoTabItem: TTabTransitionDirection);
begin
   // SE USAR SetActiveTabWithTransitionAsync DEVE TER UM TThread.Synchronize
   TThread.Synchronize(nil,
      procedure
      begin
         try
            // VAI PARA UMA TELA ESPECÍFICA
            NomeTabControl.SetActiveTabWithTransitionAsync(NomeTabItem,
                                                           TTabTransition.Slide,
                                                           DirecaoTransicaoTabItem,
                                                           nil);
         except
         end;
      end);
end;

procedure TfrmPrincipal.ActiveTabTThreadSynchronize (NomeTabControl: TTabControl;
                                                     NomeTabItem: TTabItem);
begin
   // SE USAR ActiveTab DEVE TER UM TThread.Synchronize
   TThread.Synchronize(nil,
      procedure
      begin
         try
            NomeTabControl.ActiveTab := NomeTabItem;
         except
         end;
      end);
end;

procedure TfrmPrincipal.AlteraPropriedadesBotaoSuperiorEsquerdo (Ativar: Boolean;
                                                                 Estilo,
                                                                 Texto: String;
                                                                 TamanhoBotao: Integer);
begin
   TThread.Synchronize(nil,
      procedure
      begin
         try
            BotaoSuperiorEsquerdo.Visible := Ativar;
            BotaoSuperiorEsquerdo.StyleLookup := Estilo;
            BotaoSuperiorEsquerdo.Width := TamanhoBotao;
            BotaoSuperiorEsquerdo.Text := Texto;

            if Ativar then
               begin
                  faBotaoSuperiorEsquerdo_Opacity.StartValue := 0;
                  faBotaoSuperiorEsquerdo_Opacity.StopValue := 1;
                  faBotaoSuperiorEsquerdo_Opacity.Start;
               end;
         except
         end;
      end);
end;

procedure TfrmPrincipal.BotaoSuperiorCentralDireitoClick(Sender: TObject);
begin
   TThread.CreateAnonymousThread(
      procedure
      var
         RetornoCEP: TRetornoCEP;
         ConsultaCEP: TConsultaCEP;
      begin
         if (Trim (eBuscarCEP.Text) = '') or
            (Trim (eBuscarCEP.Text) = eBuscarCEP.TextPrompt) then
               begin
                  exit;
               end;

         // MAXIMIZA FORM PRINCIPAL
         Maximiza_frmPrincipal (True{MaximizaTela});

         if Length (eBuscarCEP.Text) <> 10 then
            begin
               MensagemTThreadSynchronize('Formato de CEP inválido!');

               // INICIA OS CAMPOS DO FORM PRINCIPAL
               IniciaCampos_frmPrincipal ();
               exit;
            end;

         try
            // MESAGEM DE ESPERA
            TelaMensagemEspera ('Consultando CEP...',  True);

            // CRIAÇÃO DA CLASSE TConsultaCEP
            ConsultaCEP := TConsultaCEP.Create;

            // CONSULTO O CEP INFORMADO
            RetornoCEP := ConsultaCEP.VoltaCEP(eBuscarCEP.Text);

            if RetornoCEP.Status = 200 then
               begin
                  TThread.Synchronize(nil,
                     procedure
                     begin
                        // PREENCHIMENTO DOS CAMPOS
                        lblConsultaCEP_Cabecalho.Text := 'Endereço completo para o CEP: '+eBuscarCEP.Text;
                        lblConsultaCEP_Endereco.Text := RetornoCEP.Endereco;
                        lblConsultaCEP_Endereco.TagString := eBuscarCEP.Text;
                        lblConsultaCEP_Bairro.Text := RetornoCEP.Bairro;
                        lblConsultaCEP_Cidade.Text := RetornoCEP.Cidade;
                        lblConsultaCEP_UF.Text := RetornoCEP.Estado;
                     end);
               end
            else if RetornoCEP.Status = 404 then
               begin
                  MensagemTThreadSynchronize('CEP não encontrado!');

                  // INICIA OS CAMPOS DO FORM PRINCIPAL
                  IniciaCampos_frmPrincipal ();
              end
            else
               begin
                  MensagemTThreadSynchronize('Serviço de consulta de CEP indisponível no momento!');

                  // INICIA OS CAMPOS DO FORM PRINCIPAL
                  IniciaCampos_frmPrincipal ();
               end;
         finally
            ConsultaCEP.DisposeOf;

            // MESAGEM DE ESPERA
            TelaMensagemEspera ('',  False);
         end;
      end).Start;
end;

procedure TfrmPrincipal.BotaoSuperiorDireitoClick(Sender: TObject);
begin
   TThread.CreateAnonymousThread(
      procedure
      var
         DB_Enderecos: TDB_Enderecos;
      begin
         try
            try
               // MAXIMIZA FORM PRINCIPAL
               Maximiza_frmPrincipal (True{MaximizaTela});

               // MESAGEM INFORMATIVA
               TelaMensagemEspera ('Consultando endereços...',  True);

               // CRIAÇÃO DA CLASSE DE CONEXÃO COM O DB
               DB_Enderecos := TDB_Enderecos.Create;

               // ALTERO OS BOTÕES SUPERIORES
               AlteraPropriedadesBotaoSuperiorEsquerdo (True, 'styleSetaEsquerda', '', 44);
               AlteraPropriedadesBotaoSuperiorCentralDireito(False, '', '', 44);
               AlteraPropriedadesBotaoSuperiorDireito (False, '', '', 44);

               // LIMPA OS ÍTENS DA ListView RELAÇÃO DOS ENDEREÇOS SALVOS
               ClearListViewTThreadSynchronize (lvConsultaEndereçosSalvos);

               // APAGA QUALQUER FILTRO QUE EXISTA NA LISTVIEW
               ApagaFiltroListViewSearchBox(lvConsultaEndereçosSalvos);

               // LEITURA DE TODOS OS ENDEREÇOS
               if DB_Enderecos.ListarEnderecos ('Select * From tblEnderecos ORDER BY tblEnderecos.Endereco') then
                  begin
                     if dmDB.tblEnderecos.Eof then
                        begin
                           MensagemTThreadSynchronize('Não existem endereços salvos!');
                           exit;
                        end
                     else
                        begin
                           TThread.Synchronize(nil,
                              procedure
                              var
                                 EnderecoCompleto: TRetornoCEP;
                              begin
                                 while not dmDB.tblEnderecos.Eof do
                                    begin
                                       EnderecoCompleto.CEP := dmDB.tblEnderecos.FieldByName ('CEP').AsString;
                                       EnderecoCompleto.Endereco := dmDB.tblEnderecos.FieldByName ('Endereco').AsString;
                                       EnderecoCompleto.Bairro := dmDB.tblEnderecos.FieldByName ('Bairro').AsString;
                                       EnderecoCompleto.Cidade := dmDB.tblEnderecos.FieldByName ('Cidade').AsString;
                                       EnderecoCompleto.Estado := dmDB.tblEnderecos.FieldByName ('Estado').AsString;

                                       // INCLUI OS CLIENTES NA ListView
                                       IncluiEnderecosNaListView (EnderecoCompleto);

                                       // PRÓXIMO REGISTRO
                                       dmDB.tblEnderecos.Next;
                                    end;
                              end);
                        end;
                  end
               else
                  begin
                     MensagemTThreadSynchronize('Erro ao conectar com o banco de dados, tente novamente por favor!');
                     exit;
                  end;

               // VAI PARA UMA TELA ESPECÍFICA
               TransicaoTabItemTThreadSynchronize(tabPrincipal,
                                                  tabConsultaEndereçosSalvos,
                                                  TTabTransitionDirection.Normal);
            except
            end;
         finally
            TelaMensagemEspera ('',  False);
            DB_Enderecos.DisposeOf;
         end;
      end).Start;
end;

procedure TfrmPrincipal.BotaoSuperiorEsquerdoClick(Sender: TObject);
begin
   try
      TThread.Synchronize(nil,
         procedure
         begin
            eBuscarCEP.Text := '';
         end);

      // VAI PARA UMA TELA ESPECÍFICA
      TransicaoTabItemTThreadSynchronize(tabPrincipal,
                                         tabConsultaCEP,
                                         TTabTransitionDirection.Reversed);

      // CONFIGURA OS BOTÕES SUPERIORES
      AlteraPropriedadesBotaoSuperiorEsquerdo(False, '', '', 44);
      AlteraPropriedadesBotaoSuperiorCentralDireito(False, '', '', 44);
      AlteraPropriedadesBotaoSuperiorDireito(True, 'styleMenuSuspenso', '', 44);

      // MINIMIZA FORM PRINCIPAL
      Maximiza_frmPrincipal (False{MaximizaTela});
   except
   end;
end;

procedure TfrmPrincipal.AlteraPropriedadesBotaoSuperiorCentralDireito (Ativar: Boolean;
                                                                       Estilo,
                                                                       Texto: String;
                                                                       TamanhoBotao: Integer);
begin
   TThread.Synchronize(nil,
      procedure
      begin
         try
            BotaoSuperiorCentralDireito.Visible := Ativar;
            BotaoSuperiorCentralDireito.StyleLookup := Estilo;
            BotaoSuperiorCentralDireito.Width := TamanhoBotao;
            BotaoSuperiorCentralDireito.Text := Texto;

            if Ativar then
               begin
                  faBotaoSuperiorCentralDireito_Opacity.StartValue := 0;
                  faBotaoSuperiorCentralDireito_Opacity.StopValue := 1;
                  faBotaoSuperiorCentralDireito_Opacity.Start;
               end;
         except
         end;
      end);
end;

procedure TfrmPrincipal.AlteraPropriedadesBotaoSuperiorDireito (Ativar: Boolean;
                                                                Estilo,
                                                                Texto: String;
                                                                TamanhoBotao: Integer);
begin
   TThread.Synchronize(nil,
      procedure
      begin
         try
            BotaoSuperiorDireito.Visible := Ativar;
            BotaoSuperiorDireito.StyleLookup := Estilo;
            BotaoSuperiorDireito.Width := TamanhoBotao;
            BotaoSuperiorDireito.Text := Texto;

            if Ativar then
               begin
                  faBotaoSuperiorDireito_Opacity.StartValue := 0;
                  faBotaoSuperiorDireito_Opacity.StopValue := 1;
                  faBotaoSuperiorDireito_Opacity.Start;
               end;
         except
         end;
      end);
end;

procedure TfrmPrincipal.TelaMensagemEspera (TextoMensagem: String;
                                            HabilitaMensagem: Boolean);
begin
   TThread.Synchronize(nil,
      procedure
      begin
         try
            // ANIMAÇÃO DE ESPERA
            layoutMensagemEspera.Visible := HabilitaMensagem;
            layoutMensagemEspera_BoxMeio.BringToFront;
            FloatAnimationAnimacaoEspera.Enabled := HabilitaMensagem;
            lblMensagemEspera.Text := TextoMensagem;
         except
         end;
      end);
end;

procedure TfrmPrincipal.MensagemTThreadSynchronize (Mensagem: String);
begin
   // NOVA TELA DE MENSAGENS USANDO O MENU SUSPENSO
   TThread.Synchronize(nil,
      procedure
      begin
         try
            // EXECUTA O PopUpDialogBox COM AS OPÇÕES DO MENU
            PopUpDialogBox_PerguntaComOpcoes (Mensagem,
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              RotinaNaoExecutaNadaPopUpDialogBox,
                                              RotinaNaoExecutaNadaPopUpDialogBox,
                                              RotinaNaoExecutaNadaPopUpDialogBox,
                                              RotinaNaoExecutaNadaPopUpDialogBox,
                                              RotinaNaoExecutaNadaPopUpDialogBox,
                                              RotinaNaoExecutaNadaPopUpDialogBox,
                                              RotinaNaoExecutaNadaPopUpDialogBox);
         except
         end;
      end);
end;

procedure TfrmPrincipal.PopUpDialogBox_PerguntaComOpcoes (MensagemDialogBox,
                                                          Mensagem00,
                                                          Mensagem01,
                                                          Mensagem02,
                                                          Mensagem03,
                                                          Mensagem04,
                                                          Mensagem05,
                                                          Mensagem06: String;
                                                          ExecutarRotina00,
                                                          ExecutarRotina01,
                                                          ExecutarRotina02,
                                                          ExecutarRotina03,
                                                          ExecutarRotina04,
                                                          ExecutarRotina05,
                                                          ExecutarRotina06: TExecutarProcedure);
begin
   TThread.Synchronize(nil,
      procedure
      var
         arrayPopUpDialogBox: TArray<String>;
      begin
         try
            // APAGAR QUALQUER ELEMENTO QUE ESTEJA NA MATRIZ
            arrayPopUpDialogBox := nil;
            arrayPopUpDialogBoxProcedures := nil;

            // INFORMO A DIMENSÃO DO array COM O TOTAL DE OPÇÕES DO MENU
            SetLength (arrayPopUpDialogBox, 07); {TArray<String>}
            SetLength (arrayPopUpDialogBoxProcedures, 07); {Array of Procedure of object}

            // INFORMO AS OPÇÕES DO MENU
            arrayPopUpDialogBox [0] := Mensagem00;
            arrayPopUpDialogBox [1] := Mensagem01;
            arrayPopUpDialogBox [2] := Mensagem02;
            arrayPopUpDialogBox [3] := Mensagem03;
            arrayPopUpDialogBox [4] := Mensagem04;
            arrayPopUpDialogBox [5] := Mensagem05;
            arrayPopUpDialogBox [6] := Mensagem06;

            // INFORMO AS ROTINAS QUE SERÃO EXECUTADAS EM CADA ListBoxItem
            arrayPopUpDialogBoxProcedures [0] := ExecutarRotina00;
            arrayPopUpDialogBoxProcedures [1] := ExecutarRotina01;
            arrayPopUpDialogBoxProcedures [2] := ExecutarRotina02;
            arrayPopUpDialogBoxProcedures [3] := ExecutarRotina03;
            arrayPopUpDialogBoxProcedures [4] := ExecutarRotina04;
            arrayPopUpDialogBoxProcedures [5] := ExecutarRotina05;
            arrayPopUpDialogBoxProcedures [6] := ExecutarRotina06;

            // ADICIONA OS ÍTENS AO MENU E EXECUTA A TELA PopUpDialogBox
            frameTelaPopUpDialogBox.ExecutaTelaPopUpDialogBox (arrayPopUpDialogBox,
                                                               MensagemDialogBox);
         except
         end;
      end);
end;

procedure TfrmPrincipal.rectConsultaCEP_Botao_SalvarEnderecoClick(
  Sender: TObject);
begin
   TThread.CreateAnonymousThread(
      procedure
      var
         DB_Enderecos: TDB_Enderecos;
         EnderecoCompleto: TRetornoCEP;
      begin
         try
            // MESAGEM INFORMATIVA
            TelaMensagemEspera ('Salvando endereço...',  True);

            // CRIAÇÃO DA CLASSE DE CONEXÃO COM O DB
            DB_Enderecos := TDB_Enderecos.Create;

            // VERIFICO SE JÁ FOI CONSULTADO ALGUM CEP
            if Trim (lblConsultaCEP_Endereco.TagString) = '' then
               begin
                  MensagemTThreadSynchronize('Você precisa pesquisar algum CEP!');
                  exit;
               end;

            // VERIFICA SE O CEP JÁ EXISTE NA BASE DE DADOS
            if DB_Enderecos.ListarEnderecos ('Select CEP From tblEnderecos Where CEP = '''+lblConsultaCEP_Endereco.TagString+''' ') then
               begin
                  if dmDB.tblEnderecos.Eof then
                     begin
                        EnderecoCompleto.CEP := lblConsultaCEP_Endereco.TagString;
                        EnderecoCompleto.Endereco := lblConsultaCEP_Endereco.Text;
                        EnderecoCompleto.Bairro := lblConsultaCEP_Bairro.Text;
                        EnderecoCompleto.Cidade := lblConsultaCEP_Cidade.Text;
                        EnderecoCompleto.Estado := lblConsultaCEP_UF.Text;

                        if DB_Enderecos.InserirEndereco(EnderecoCompleto{EnderecoCompleto}) then
                           begin
                              MensagemTThreadSynchronize('CEP salvo com sucesso!');
                           end
                        else
                           begin
                              MensagemTThreadSynchronize('Não consegui salvar o CEP no banco de dados, tente novamente por favor!');
                           end;
                     end
                  else
                     begin
                        MensagemTThreadSynchronize('O CEP informado já existe no banco de dados!');
                     end;
               end
            else
               begin
                  MensagemTThreadSynchronize('Erro ao conectar com o banco de dados, tente novamente por favor!');
               end;
         finally
            DB_Enderecos.DisposeOf;

            // MESAGEM INFORMATIVA
            TelaMensagemEspera ('',  False);
         end;
      end).Start;
end;

procedure TfrmPrincipal.RotinaNaoExecutaNadaPopUpDialogBox ();
begin
   // NÃO EXECUTA NADA, POIS É QUANDO A OPÇÃO NÃO TEM NADA A EXECUTAR, ÓBVIO, KKKKK
end;

procedure TfrmPrincipal.IniciaCampos_frmPrincipal ();
begin
   TThread.Synchronize(nil,
      procedure
      begin
         lblConsultaCEP_Cabecalho.Text := 'Endereço completo';
         lblConsultaCEP_Endereco.TagString := '';
         lblConsultaCEP_Endereco.Text := '';
         lblConsultaCEP_Bairro.Text := '';
         lblConsultaCEP_Cidade.Text := '';
         lblConsultaCEP_UF.Text := '';
      end);
end;

procedure TfrmPrincipal.lvConsultaEndereçosSalvosItemClickEx(
  const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
   try
      if (lvConsultaEndereçosSalvos.Width-LocalClickPos.X <= 70) and
         (LocalClickPos.Y <= 75) then
         begin
            PopUpDialogBox_ExcluirEnderecoLista ();
         end;
   except
   end;
end;

procedure TfrmPrincipal.Maximiza_frmPrincipal (MaximizaTela: Boolean);
begin
   TThread.Synchronize(nil,
      procedure
      begin
         if MaximizaTela then
            begin
               frmPrincipal.Height := 415;
            end
         else
            begin
               frmPrincipal.Height := 95;
            end;
      end);
end;

procedure TfrmPrincipal.IncluiEnderecosNaListView (EnderecoCompleto: TRetornoCEP);
begin
   TThread.Synchronize(nil,
      procedure
      var
         Item: TListViewItem;
      begin
         try
            // APAGA QUALQUER FILTRO QUE EXISTA NA LISTVIEW
            ApagaFiltroListViewSearchBox(lvConsultaEndereçosSalvos);

            // Propriedade ItemObjects Text
            Item := lvConsultaEndereçosSalvos.Items.Add;

            // ÍTENS DA ListView
            Item.TagString := EnderecoCompleto.CEP;

            // CAMPOS DA ListView
            Item.Data ['Endereco'] := EnderecoCompleto.Endereco;
            Item.Data ['Bairro'] := EnderecoCompleto.Bairro;
            Item.Data ['Cidade_UF'] := EnderecoCompleto.Cidade+'('+EnderecoCompleto.Estado+')';
            Item.Data ['CEP'] := EnderecoCompleto.CEP;

            // IMAGENS DA ListView
            Item.Data ['ImagemBoxComSombra'] := ImagemMolduraEscura.Bitmap;
            Item.Data ['ImagemMenuSuspenso'] := ImagemMenuSuspenso.Bitmap;
         except
         end;
      end);
end;

procedure TfrmPrincipal.PopUpDialogBox_ExcluirEnderecoLista ();
begin
   try
      // EXECUTA O PopUpDialogBox COM AS OPÇÕES DO MENU
      PopUpDialogBox_PerguntaComOpcoes ('Vamos excluir o endereço da lista?',
                                        'Sim, desejo excluir',
                                        'Não desejo excluir',
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        ExcluirEnderecoLista,
                                        RotinaNaoExecutaNadaPopUpDialogBox,
                                        RotinaNaoExecutaNadaPopUpDialogBox,
                                        RotinaNaoExecutaNadaPopUpDialogBox,
                                        RotinaNaoExecutaNadaPopUpDialogBox,
                                        RotinaNaoExecutaNadaPopUpDialogBox,
                                        RotinaNaoExecutaNadaPopUpDialogBox);
   except
   end;
end;

procedure TfrmPrincipal.ExcluirEnderecoLista ();
var
   DB_Enderecos: TDB_Enderecos;
begin
   try
      try
         // CRIAÇÃO DA CLASSE DE CONEXÃO COM O DB
         DB_Enderecos := TDB_Enderecos.Create;

         if DB_Enderecos.ExcluirEndereco(lvConsultaEndereçosSalvos.Items[lvConsultaEndereçosSalvos.ItemIndex].TagString{CEP}) then
            begin
               lvConsultaEndereçosSalvos.Items.Delete(lvConsultaEndereçosSalvos.ItemIndex);
            end
         else
            begin
               MensagemTThreadSynchronize('Não consegui excluir o endereço, tente novamente por favor!');
            end;
      except
      end;
   finally
      DB_Enderecos.DisposeOf;
   end;
end;

end.


