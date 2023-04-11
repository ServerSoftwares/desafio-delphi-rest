object FormDesafio: TFormDesafio
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Desafio'
  ClientHeight = 458
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 678
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 713
    DesignSize = (
      678
      81)
    object Shape1: TShape
      Left = 5
      Top = 30
      Width = 665
      Height = 2
      Anchors = [akLeft, akTop, akRight]
      ExplicitWidth = 700
    end
    object Label1: TLabel
      Left = 5
      Top = 7
      Width = 100
      Height = 21
      Caption = 'Consulta CEP'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object MaskEditCEP: TMaskEdit
      Left = 5
      Top = 38
      Width = 139
      Height = 29
      EditMask = '00000\-000;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      MaxLength = 9
      ParentFont = False
      TabOrder = 0
      Text = ''
    end
    object Button1: TButton
      Left = 149
      Top = 38
      Width = 153
      Height = 30
      Caption = 'Consultar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object cxPageControlCEP: TcxPageControl
    Left = 0
    Top = 81
    Width = 678
    Height = 377
    Align = alClient
    ParentBackground = False
    ParentColor = False
    TabOrder = 1
    Properties.ActivePage = cxTabSheetFicha
    Properties.CustomButtons.Buttons = <>
    Properties.Style = 9
    Properties.TabPosition = tpBottom
    OnChange = cxPageControlCEPChange
    ExplicitLeft = 32
    ExplicitTop = 208
    ExplicitWidth = 289
    ExplicitHeight = 193
    ClientRectBottom = 357
    ClientRectRight = 678
    ClientRectTop = 0
    object cxTabSheetFicha: TcxTabSheet
      Caption = 'Ficha'
      ImageIndex = 0
      ExplicitTop = 6
      ExplicitWidth = 713
      DesignSize = (
        678
        357)
      object Label2: TLabel
        Left = 5
        Top = 9
        Width = 22
        Height = 17
        Caption = 'CEP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 5
        Top = 67
        Width = 15
        Height = 17
        Caption = 'UF'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 5
        Top = 124
        Width = 25
        Height = 17
        Caption = 'CITY'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 5
        Top = 183
        Width = 101
        Height = 17
        Caption = 'NEIGHBORHOOD'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 5
        Top = 240
        Width = 43
        Height = 17
        Caption = 'STREET'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 6
        Top = 296
        Width = 48
        Height = 17
        Caption = 'SERVICE'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 5
        Top = 29
        Width = 665
        Height = 29
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 700
      end
      object Edit2: TEdit
        Left = 5
        Top = 87
        Width = 665
        Height = 29
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        ExplicitWidth = 700
      end
      object Edit3: TEdit
        Left = 5
        Top = 145
        Width = 665
        Height = 29
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        ExplicitWidth = 700
      end
      object Edit4: TEdit
        Left = 5
        Top = 203
        Width = 665
        Height = 29
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        ExplicitWidth = 700
      end
      object Edit5: TEdit
        Left = 5
        Top = 260
        Width = 665
        Height = 29
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        ExplicitWidth = 700
      end
      object Edit6: TEdit
        Left = 5
        Top = 316
        Width = 665
        Height = 29
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        ExplicitWidth = 700
      end
    end
    object cxTabSheetLista: TcxTabSheet
      Caption = 'Lista'
      ImageIndex = 1
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 281
      ExplicitHeight = 165
      object wwDBGrid1: TwwDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 668
        Height = 347
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        DisableThemes = True
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        ExplicitLeft = 96
        ExplicitTop = 120
        ExplicitWidth = 320
        ExplicitHeight = 120
      end
    end
  end
  object DataSource1: TDataSource
    Left = 296
    Top = 153
  end
end
