object frmConsultaCep: TfrmConsultaCep
  Left = 0
  Top = 0
  Caption = 'ConsultaCep'
  ClientHeight = 419
  ClientWidth = 823
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 823
    Height = 400
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pgcPrincipal: TPageControl
      Left = 0
      Top = 0
      Width = 823
      Height = 400
      ActivePage = tbsConsultaCep
      Align = alClient
      TabOrder = 0
      object tbsConsultaCep: TTabSheet
        Caption = 'Consulta Cep'
        object pnlConsultaMain: TPanel
          Left = 0
          Top = 0
          Width = 815
          Height = 372
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object pnlConsultaTop: TPanel
            Left = 0
            Top = 0
            Width = 815
            Height = 57
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label1: TLabel
              Left = 10
              Top = 5
              Width = 19
              Height = 13
              Caption = 'Cep'
            end
            object btnConsultarCep: TButton
              Left = 91
              Top = 22
              Width = 82
              Height = 25
              Caption = 'Consultar'
              TabOrder = 1
              OnClick = btnConsultarCepClick
            end
            object maskEdtCep: TMaskEdit
              Left = 10
              Top = 24
              Width = 73
              Height = 21
              EditMask = '99999-999;0;'
              MaxLength = 9
              TabOrder = 0
              Text = ''
              OnKeyPress = maskEdtCepKeyPress
            end
          end
          object pnlConsultaBody: TPanel
            Left = 0
            Top = 57
            Width = 815
            Height = 315
            Align = alClient
            TabOrder = 1
            object DBGridResultadoCep: TDBGrid
              Left = 1
              Top = 1
              Width = 813
              Height = 313
              Align = alClient
              BorderStyle = bsNone
              DataSource = dsCeps
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'cep'
                  Width = 63
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UF'
                  Width = 25
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Cidade'
                  Width = 112
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Bairro'
                  Width = 89
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Logradouro'
                  Width = 160
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Servico'
                  Width = 69
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Tipo_localizacao'
                  Width = 93
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Latitude'
                  Width = 82
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Longitude'
                  Width = 80
                  Visible = True
                end>
            end
          end
        end
      end
      object tbsPesquisa: TTabSheet
        Caption = 'Pesquisa'
        ImageIndex = 1
        object pnlPesquisaMain: TPanel
          Left = 0
          Top = 0
          Width = 815
          Height = 372
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object pnlPesquisaTop: TPanel
            Left = 0
            Top = 0
            Width = 815
            Height = 57
            Align = alTop
            BevelOuter = bvSpace
            TabOrder = 0
            object Label2: TLabel
              Left = 10
              Top = 5
              Width = 65
              Height = 13
              Caption = 'Cep por faixa'
            end
            object Label4: TLabel
              Left = 89
              Top = 27
              Width = 17
              Height = 13
              Caption = 'At'#233
            end
            object Label5: TLabel
              Left = 193
              Top = 5
              Width = 13
              Height = 13
              Caption = 'UF'
            end
            object Label6: TLabel
              Left = 248
              Top = 5
              Width = 45
              Height = 13
              Caption = 'Endere'#231'o'
            end
            object btnPesquisar: TButton
              Left = 591
              Top = 20
              Width = 91
              Height = 25
              Caption = 'Pesquisar'
              TabOrder = 4
              OnClick = btnPesquisarClick
            end
            object edtFiltroUF: TEdit
              Left = 193
              Top = 24
              Width = 47
              Height = 21
              TabOrder = 2
            end
            object edtFiltroEndereco: TEdit
              Left = 248
              Top = 24
              Width = 335
              Height = 21
              TabOrder = 3
            end
            object mskEdtFiltroCepInicial: TMaskEdit
              Left = 10
              Top = 24
              Width = 73
              Height = 21
              EditMask = '99999-999;0;'
              MaxLength = 9
              TabOrder = 0
              Text = ''
            end
            object mskEdtFiltroCepFinal: TMaskEdit
              Left = 112
              Top = 24
              Width = 73
              Height = 21
              EditMask = '99999-999;0;'
              MaxLength = 9
              TabOrder = 1
              Text = ''
            end
          end
          object pnlPesquisaBody: TPanel
            Left = 0
            Top = 57
            Width = 815
            Height = 274
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object DBGrid1: TDBGrid
              Left = 0
              Top = 0
              Width = 815
              Height = 274
              Align = alClient
              BorderStyle = bsNone
              DataSource = dsPesquisaEndereco
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              Columns = <
                item
                  Expanded = False
                  FieldName = 'cep'
                  Width = 63
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'UF'
                  Width = 25
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Cidade'
                  Width = 112
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Bairro'
                  Width = 89
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Logradouro'
                  Width = 160
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Servico'
                  Width = 69
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Tipo_localizacao'
                  Width = 93
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Latitude'
                  Width = 82
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'Longitude'
                  Width = 80
                  Visible = True
                end>
            end
          end
          object pnlPesquisaFooter: TPanel
            Left = 0
            Top = 331
            Width = 815
            Height = 41
            Align = alBottom
            TabOrder = 2
            DesignSize = (
              815
              41)
            object DBNavigator1: TDBNavigator
              Left = 583
              Top = 8
              Width = 219
              Height = 25
              DataSource = dsPesquisaEndereco
              VisibleButtons = [nbDelete, nbPost, nbCancel]
              Anchors = [akRight, akBottom]
              TabOrder = 0
            end
          end
        end
      end
      object tbsConfiguracao: TTabSheet
        Caption = 'Configura'#231#227'o'
        ImageIndex = 2
        object pnlConfigMain: TPanel
          Left = 0
          Top = 0
          Width = 815
          Height = 372
          Align = alClient
          TabOrder = 0
          object pnlConfigBody: TPanel
            Left = 1
            Top = 1
            Width = 813
            Height = 370
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object Label3: TLabel
              Left = 10
              Top = 5
              Width = 174
              Height = 13
              Caption = 'Intervalo consulta autom'#225'tica (min.)'
            end
            object Label7: TLabel
              Left = 10
              Top = 55
              Width = 240
              Height = 13
              Caption = 'Informe a faixa de CEPs para consulta autom'#225'tica'
            end
            object Label9: TLabel
              Left = 88
              Top = 79
              Width = 17
              Height = 13
              Caption = 'At'#233
            end
            object edtIntervalo: TEdit
              Left = 10
              Top = 26
              Width = 33
              Height = 21
              NumbersOnly = True
              TabOrder = 0
              Text = '5'
              TextHint = '5'
              OnExit = edtIntervaloExit
            end
            object mskEdtFaixaCepInicial: TMaskEdit
              Left = 10
              Top = 76
              Width = 69
              Height = 21
              EditMask = '99999-999;0;'
              MaxLength = 9
              TabOrder = 1
              Text = '93806860'
              TextHint = '93806860'
              OnExit = mskEdtFaixaCepInicialExit
            end
            object mskEdtFaixaCepFinal: TMaskEdit
              Left = 113
              Top = 76
              Width = 72
              Height = 21
              EditMask = '99999-999;0;'
              MaxLength = 9
              TabOrder = 2
              Text = '93806874'
              TextHint = '93806874'
              OnExit = mskEdtFaixaCepFinalExit
            end
            object btnConsultaAutomaticaSobDemanda: TButton
              Left = 10
              Top = 105
              Width = 240
              Height = 25
              Caption = 'Executar consulta manualmente'
              TabOrder = 3
              OnClick = btnConsultaAutomaticaSobDemandaClick
            end
          end
        end
      end
    end
  end
  object StatusBarMain: TStatusBar
    Left = 0
    Top = 400
    Width = 823
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object cdsCeps: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 184
    object cdsCepscep: TStringField
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      EditMask = '00000\-999;0;_'
      Size = 8
    end
    object cdsCepsUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsCepsCidade: TStringField
      FieldName = 'Cidade'
      Size = 100
    end
    object cdsCepsBairro: TStringField
      FieldName = 'Bairro'
      Size = 100
    end
    object cdsCepsLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 100
    end
    object cdsCepsServico: TStringField
      DisplayLabel = 'Servi'#231'o'
      FieldName = 'Servico'
      Size = 40
    end
    object cdsCepsTipo_localizacao: TStringField
      DisplayLabel = 'Tipo de localiza'#231#227'o'
      FieldName = 'Tipo_localizacao'
    end
    object cdsCepsLatitude: TStringField
      FieldName = 'Latitude'
    end
    object cdsCepsLongitude: TStringField
      FieldName = 'Longitude'
    end
  end
  object dsCeps: TDataSource
    AutoEdit = False
    DataSet = cdsCeps
    Left = 168
    Top = 184
  end
  object cdsPesquisaEndereco: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsPesquisaEnderecoBeforePost
    BeforeDelete = cdsPesquisaEnderecoBeforeDelete
    Left = 48
    Top = 248
    object cdsPesquisaEnderecoId: TLargeintField
      FieldName = 'Id'
    end
    object cdsPesquisaEnderecoCep: TStringField
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      EditMask = '00000\-999;0;_'
      Size = 8
    end
    object cdsPesquisaEnderecoUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsPesquisaEnderecoCidade: TStringField
      FieldName = 'Cidade'
      Size = 100
    end
    object cdsPesquisaEnderecoBairro: TStringField
      FieldName = 'Bairro'
      Size = 100
    end
    object cdsPesquisaEnderecoLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 100
    end
    object cdsPesquisaEnderecoServico: TStringField
      DisplayLabel = 'Servi'#231'o'
      FieldName = 'Servico'
      Size = 40
    end
    object cdsPesquisaEnderecoTipo_localizacao: TStringField
      DisplayLabel = 'Tipo de localiza'#231#227'o'
      FieldName = 'Tipo_localizacao'
    end
    object cdsPesquisaEnderecoLatitude: TStringField
      FieldName = 'Latitude'
    end
    object cdsPesquisaEnderecoLongitude: TStringField
      FieldName = 'Longitude'
    end
  end
  object dsPesquisaEndereco: TDataSource
    DataSet = cdsPesquisaEndereco
    Left = 168
    Top = 248
  end
  object TimerConsultaAutomatica: TTimer
    Interval = 300000
    OnTimer = TimerConsultaAutomaticaTimer
    Left = 336
    Top = 184
  end
end
