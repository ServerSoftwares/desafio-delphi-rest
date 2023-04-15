unit framePopUpDialogBox;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, FMX.Ani, FMX.Effects, FMX.ScrollBox, FMX.Memo, FMX.ListBox, FMX.Layouts,
  FMX.Memo.Types, FMX.Edit;

type
  TframeTelaPopUpDialogBox = class(TFrame)
    TelaComFundoEscuroMeioTransparente: TRectangle;
    faRectPopUpDialogBox_Movimento: TFloatAnimation;
    lbPopUpDialogBox: TListBox;
    lbiPopUpDialogBox00: TListBoxItem;
    lbiPopUpDialogBox01: TListBoxItem;
    lbiPopUpDialogBox02: TListBoxItem;
    lbiPopUpDialogBox03: TListBoxItem;
    lbiPopUpDialogBox04: TListBoxItem;
    lbiPopUpDialogBox05: TListBoxItem;
    lbiPopUpDialogBox06: TListBoxItem;
    lbiPopUpDialogBoxSair: TListBoxItem;
    rectMemoPopUpDialogBox: TRectangle;
    memoPopUpDialogBox: TMemo;
    faTelaComFundoEscuroMeioTransparente_Opacity: TFloatAnimation;
    rectBottonTelaPopUpDialogBox: TRectangle;
    panelPopUpDialogBox: TPanel;
    procedure TelaComFundoEscuroMeioTransparenteClick(Sender: TObject);

    // INÍCIO DAS PROCEDURES E FUNÇÕES ESPECÍFICAS
    procedure AbreTelaPopUpDialogBox ();
    procedure FechaTelaPopUpDialogBox ();
    procedure faRectPopUpDialogBox_MovimentoFinish(Sender: TObject);
    procedure ExecutaTelaPopUpDialogBox (arrayPopUpDialogBox: TArray<String>;
                                         MensagemDialogBox: String);
    procedure lbiPopUpDialogBox01Click(Sender: TObject);
    procedure lbiPopUpDialogBox01Tap(Sender: TObject; const Point: TPointF);
    procedure lbiPopUpDialogBox02Click(Sender: TObject);
    procedure lbiPopUpDialogBox02Tap(Sender: TObject; const Point: TPointF);
    procedure lbiPopUpDialogBox03Click(Sender: TObject);
    procedure lbiPopUpDialogBox03Tap(Sender: TObject; const Point: TPointF);
    procedure lbiPopUpDialogBox04Click(Sender: TObject);
    procedure lbiPopUpDialogBox04Tap(Sender: TObject; const Point: TPointF);
    procedure lbiPopUpDialogBox00Click(Sender: TObject);
    procedure lbiPopUpDialogBox00Tap(Sender: TObject; const Point: TPointF);
    procedure lbiPopUpDialogBox05Click(Sender: TObject);
    procedure lbiPopUpDialogBox05Tap(Sender: TObject; const Point: TPointF);
    procedure lbiPopUpDialogBox06Click(Sender: TObject);
    procedure lbiPopUpDialogBox06Tap(Sender: TObject; const Point: TPointF);
    procedure lbiPopUpDialogBoxSairClick(Sender: TObject);
    procedure lbiPopUpDialogBoxSairTap(Sender: TObject; const Point: TPointF);
    // FINAL DAS PROCEDURES E FUNÇÕES ESPECÍFICAS

  private
    { Private declarations }

  public
    { Public declarations }

  end;

implementation

{$R *.fmx}

uses
   ConsultaCEP.View.Principal;

procedure TframeTelaPopUpDialogBox.TelaComFundoEscuroMeioTransparenteClick(Sender: TObject);
begin
   FechaTelaPopUpDialogBox ();
end;

procedure TframeTelaPopUpDialogBox.ExecutaTelaPopUpDialogBox (arrayPopUpDialogBox: TArray<String>;
                                                              MensagemDialogBox: String);
begin
   TThread.Synchronize(nil,
      procedure
      var
         a,
         ItemInicialEmbranco: Integer;
      begin
         try
            // MESAGEM DO PopUpDialogBox
            memoPopUpDialogBox.Lines.Clear;
            memoPopUpDialogBox.Text := MensagemDialogBox;
            ItemInicialEmbranco := 0;

            // INCLUI OS ÍTENS DO MENU PopUp
            for a := 0 to High (arrayPopUpDialogBox) do
               begin
                  if TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [a]))) is TListBoxItem then
                     begin
                        // HABILITO VISUALMENTE OS ÍTENS NO MENU
                        TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [a]))).Visible := True;

                        // INFORMO O NOME DE CADA OPÇÃO DO MENU
                        TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [a]))).Text := arrayPopUpDialogBox [a];

                        // VERIFICO O PRIMEIRO ÍTEM QUE ESTÁ EM BRANCO
                        if (Trim (arrayPopUpDialogBox [a]) = '') and (ItemInicialEmbranco = 0) then
                           begin
                              ItemInicialEmbranco := a;
                           end;
                     end;
               end;

            // SE ItemInicialEmbranco IGUAL A "-1" É PORQUE NÃO TEM NENHUMA OPÇÃO EM BRANCO
            // E NESSE CASO A POSIÇÃO DA OPÇÃO "SAIR" SEMPRE SERÁ A ÚLTIMA
            if (TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [0]))) is TListBoxItem) and
               (Trim (TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [High (arrayPopUpDialogBox)]))).Text) <> '') then
               begin
                  ItemInicialEmbranco := High (arrayPopUpDialogBox)+1;
               end;

            // ALTERO A ORDEM DO ÚLTIMO ListBoxItem, QUE É A OPÇÃO "SAIR" PARA QUE FIQUE ABAIXO
            // DO ÚLTIMO ÍTEM DA LISTA
            lbiPopUpDialogBoxSair.Index := ItemInicialEmbranco;

            // O PRÓXIMO for DESABILITA VISUALMENTE OS ÍTENS DO MENU QUE NÃO SERÃO UTILIZADOS
            // NA TELA PopUp E COLOQUEI "ItemInicialEmbranco+1" NO for, POIS IREI DESABILITAR
            // APENAS OS ÍTENS POSTERIORES, OU SEJA, A PARTIR DO ÚLTIMO ÍTEM DO MENU.
            // AJUSTO O TAMANHO DO rectPopUpDialogBox E A VARIÁVEL ItemInicialEmbranco INICIA
            // A PARTIR DO PRIMEIRO ÍTEM EM BRANCO, OU SEJA, SEM OPÇÃO A EXECUTAR
            for a := ItemInicialEmbranco to lbPopUpDialogBox.Count-1 do
               begin
                  if TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [a]))) is TListBoxItem then
                     begin
                        // DESATIVO VISUALMENTE O ListBoxItem DO MENU QUE NÃO É NECESSÁRIO
                        TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [a]))).Visible := False;

                        // DIMINUO O TAMANHO DO rectPopUpDialogBox PARA CABER SÓ O TOTAL DE OPÇÕES
                        // COLOQUEI "+1" NO ItemInicialEmbranco POIS TEM MAIS O ÚLTIMO
                        // ListBoxItem, QUE É A OPÇÃO "SAIR"
                        panelPopUpDialogBox.Height := (ItemInicialEmbranco+1) * TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [a]))).Height;
                     end;
               end;

            // QUANDO NÃO TIVER NENHUM ÍTEM EM BRANCO, O TAMANHO DO rect SERÁ O TAMANHO
            // DE TODAS AS OPÇÕES
            if ItemInicialEmbranco = High (arrayPopUpDialogBox)+1 then
               begin
                  panelPopUpDialogBox.Height := (ItemInicialEmbranco+1) * TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [0]))).Height;
               end;

            // QUANDO O ÍTEM ZERO ESTIVER EM BRANCO SIGNIFICA DIZER QUE É APENAS UMA MENSAGEM INFORMATIVA
            // E NESSE CASO APAGO ESSE ÍTEM PARA NÃO FICAR MOSTRANDO NA TELA
            if (TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [0]))) is TListBoxItem) and
               (Trim (TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [0]))).Text) = '') then
               begin
                  // DESATIVO VISUALMENTE O ListBoxItem DO MENU QUE NÃO É NECESSÁRIO
                  TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [0]))).Visible := False;

                  // COLOQUEI "+100" NO Height PARA AJUSTAR O TAMANHO E FICAR IDEAL
                  panelPopUpDialogBox.Height := panelPopUpDialogBox.Height - TListBoxItem (FindComponent ('lbiPopUpDialogBox'+Format('%2.2d', [0]))).Height;
               end;

            // AJUSTO O TAMANHO DO POPUP
            panelPopUpDialogBox.Height := panelPopUpDialogBox.Height + 20;

            // VAI PARA O PRIMEIRO ÍTEM DA LISTA
            lbPopUpDialogBox.ScrollToItem (lbPopUpDialogBox.ListItems[0]);

            // CHAMO A TELA COM O MENU
            AbreTelaPopUpDialogBox ();
         except
         end;
      end);
end;

procedure TframeTelaPopUpDialogBox.faRectPopUpDialogBox_MovimentoFinish(Sender: TObject);
begin
   TThread.Synchronize(nil,
      procedure
      begin
         try
            if faRectPopUpDialogBox_Movimento.StopValue = frmPrincipal.Height+1 then
               begin
                  frmPrincipal.frameTelaPopUpDialogBox.Visible := False;
               end;
         except
         end;
      end);
end;

procedure TframeTelaPopUpDialogBox.FechaTelaPopUpDialogBox ();
begin
   TThread.Synchronize(nil,
      procedure
      begin
         try
            // PARÂMETROS DO FloatAnimation
            faTelaComFundoEscuroMeioTransparente_Opacity.StartValue := 0.5;
            faTelaComFundoEscuroMeioTransparente_Opacity.StopValue := 0;

            // INICIA O FloatAnimation
            faTelaComFundoEscuroMeioTransparente_Opacity.Start;

            // PARÂMETROS DA MOVIMENTAÇÃO DO FloatAnimationTelaPopUp
            faRectPopUpDialogBox_Movimento.StartValue := panelPopUpDialogBox.Position.Y;

            faRectPopUpDialogBox_Movimento.StopValue := frmPrincipal.Height+1;

            // ALTERO ALGUMAS PROPRIEDADES DO FLOATANIMATTION E NO OnClose VOLTO AO "NORMAL"
            faRectPopUpDialogBox_Movimento.Duration := 0.3;
            faRectPopUpDialogBox_Movimento.AnimationType := TAnimationType.In;
            faRectPopUpDialogBox_Movimento.Interpolation := TInterpolationType.Linear;

            // INICIA O FloatAnimationTelaPopUp
            faRectPopUpDialogBox_Movimento.Start;
         except
         end;
      end);
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox00Click(Sender: TObject);
begin
   try
      // EXECUTA A ROTINA OnTap DO COMPONENTE
      lbiPopUpDialogBox00Tap(Sender, PointF (0, 0));
   except
   end;
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox00Tap(Sender: TObject; const Point: TPointF);
begin
   TelaComFundoEscuroMeioTransparenteClick(Self);
   arrayPopUpDialogBoxProcedures [00];
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox01Click(Sender: TObject);
begin
   try
      // EXECUTA A ROTINA OnTap DO COMPONENTE
      lbiPopUpDialogBox01Tap(Sender, PointF (0, 0));
   except
   end;
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox01Tap(Sender: TObject; const Point: TPointF);
begin
   TelaComFundoEscuroMeioTransparenteClick(Self);
   arrayPopUpDialogBoxProcedures [01];
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox02Click(Sender: TObject);
begin
   try
      // EXECUTA A ROTINA OnTap DO COMPONENTE
      lbiPopUpDialogBox02Tap(Sender, PointF (0, 0));
   except
   end;
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox02Tap(Sender: TObject; const Point: TPointF);
begin
   TelaComFundoEscuroMeioTransparenteClick(Self);
   arrayPopUpDialogBoxProcedures [02];
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox03Click(Sender: TObject);
begin
   try
      // EXECUTA A ROTINA OnTap DO COMPONENTE
      lbiPopUpDialogBox03Tap(Sender, PointF (0, 0));
   except
   end;
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox03Tap(Sender: TObject; const Point: TPointF);
begin
   TelaComFundoEscuroMeioTransparenteClick(Self);
   arrayPopUpDialogBoxProcedures [03];
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox04Click(Sender: TObject);
begin
   try
      // EXECUTA A ROTINA OnTap DO COMPONENTE
      lbiPopUpDialogBox04Tap(Sender, PointF (0, 0));
   except
   end;
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox04Tap(Sender: TObject; const Point: TPointF);
begin
   TelaComFundoEscuroMeioTransparenteClick(Self);
   arrayPopUpDialogBoxProcedures [04];
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox05Click(Sender: TObject);
begin
   try
      // EXECUTA A ROTINA OnTap DO COMPONENTE
      lbiPopUpDialogBox05Tap(Sender, PointF (0, 0));
   except
   end;
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox05Tap(Sender: TObject; const Point: TPointF);
begin
   TelaComFundoEscuroMeioTransparenteClick(Self);
   arrayPopUpDialogBoxProcedures [05];
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox06Click(Sender: TObject);
begin
   try
      // EXECUTA A ROTINA OnTap DO COMPONENTE
      lbiPopUpDialogBox06Tap(Sender, PointF (0, 0));
   except
   end;
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBox06Tap(Sender: TObject; const Point: TPointF);
begin
   TelaComFundoEscuroMeioTransparenteClick(Self);
   arrayPopUpDialogBoxProcedures [06];
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBoxSairClick(Sender: TObject);
begin
   try
      // EXECUTA A ROTINA OnTap DO COMPONENTE
      lbiPopUpDialogBoxSairTap(Sender, PointF (0, 0));
   except
   end;
end;

procedure TframeTelaPopUpDialogBox.lbiPopUpDialogBoxSairTap(Sender: TObject; const Point: TPointF);
begin
   FechaTelaPopUpDialogBox ();
end;

procedure TframeTelaPopUpDialogBox.AbreTelaPopUpDialogBox ();
begin
   TThread.Synchronize(nil,
      procedure
      var
         AlturaTela: Integer;
      begin
         try
            // PEGO A ALTURA DA TELA
            AlturaTela := frmPrincipal.Height;

            rectBottonTelaPopUpDialogBox.Height := 10;

            // COLOQUEI "+110" NO Height PARA AJUSTAR O TAMANHO E FICAR IDEAL
            panelPopUpDialogBox.Height := panelPopUpDialogBox.Height+110;


            // HABILITO O FRAME
            frmPrincipal.frameTelaPopUpDialogBox.BringToFront;
            frmPrincipal.frameTelaPopUpDialogBox.Visible := True;

            // PARÂMETROS DO FloatAnimation
            faTelaComFundoEscuroMeioTransparente_Opacity.StartValue := 0;
            faTelaComFundoEscuroMeioTransparente_Opacity.StopValue := 0.5;

            // INICIA O FloatAnimation
            faTelaComFundoEscuroMeioTransparente_Opacity.Start;

            // INICIA O rectTelaPopUpDialogBox ABAIXO DO TAMANHO DA TELA
            panelPopUpDialogBox.Position.Y := AlturaTela+1;

            // HABILITO VISULAMENTE O MENU SUSPENSO
            panelPopUpDialogBox.Visible := True;

            // PARÂMETROS DA MOVIMENTAÇÃO DO FloatAnimationTelaPopUp
            faRectPopUpDialogBox_Movimento.StartValue := AlturaTela+1;
            faRectPopUpDialogBox_Movimento.StopValue := AlturaTela-panelPopUpDialogBox.Height-40;

            // ALTERO ALGUMAS PROPRIEDADES DO FLOATANIMATTION E NO OnClose VOLTO AO "NORMAL"
            faRectPopUpDialogBox_Movimento.Duration := 2;
            faRectPopUpDialogBox_Movimento.AnimationType := TAnimationType.Out;
            faRectPopUpDialogBox_Movimento.Interpolation := TInterpolationType.Elastic;

            // INICIA O FloatAnimationTelaPopUp
            faRectPopUpDialogBox_Movimento.Start;
         except
            FechaTelaPopUpDialogBox ();
         end;
      end);
end;

end.


