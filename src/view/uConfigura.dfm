object FormConfigura: TFormConfigura
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configura'
  ClientHeight = 208
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 281
    Height = 208
    Align = alClient
    BevelOuter = bvNone
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 366
    ExplicitHeight = 163
    DesignSize = (
      281
      208)
    object Shape1: TShape
      Left = 5
      Top = 30
      Width = 268
      Height = 2
      Anchors = [akLeft, akTop, akRight]
      ExplicitWidth = 700
    end
    object Label1: TLabel
      Left = 5
      Top = 7
      Width = 209
      Height = 21
      Caption = 'Consulta Automaticamente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 5
      Top = 39
      Width = 54
      Height = 13
      Caption = 'A Partir De'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 5
      Top = 91
      Width = 91
      Height = 13
      Caption = 'A Cada X Minutos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 4
      Top = 147
      Width = 111
      Height = 13
      Caption = 'N'#250'mero de Consultas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object MaskEditCEP: TMaskEdit
      Left = 5
      Top = 54
      Width = 137
      Height = 29
      EditMask = '99999\-999;0; '
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
    object SpinEditTempo: TSpinEdit
      Left = 5
      Top = 107
      Width = 138
      Height = 31
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      Increment = 5
      MaxValue = 60
      MinValue = 5
      ParentFont = False
      TabOrder = 1
      Value = 5
    end
    object SpinEditNumero: TSpinEdit
      Left = 4
      Top = 163
      Width = 138
      Height = 31
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      Increment = 10
      MaxValue = 50
      MinValue = 10
      ParentFont = False
      TabOrder = 2
      Value = 10
    end
  end
end
