object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 498
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 73
    Height = 13
    Caption = 'Informe o CEP:'
  end
  object Label2: TLabel
    Left = 8
    Top = 125
    Width = 28
    Height = 13
    Caption = 'Filtro:'
  end
  object btnValidarCEP: TButton
    Left = 8
    Top = 51
    Width = 121
    Height = 25
    Caption = 'Validar CEP'
    TabOrder = 0
    OnClick = btnValidarCEPClick
  end
  object medtCEP: TMaskEdit
    Left = 8
    Top = 27
    Width = 118
    Height = 21
    EditMask = '99999-999;0;'
    MaxLength = 9
    TabOrder = 1
    Text = ''
  end
  object DBNavigator1: TDBNavigator
    Left = 361
    Top = 431
    Width = 240
    Height = 25
    DataSource = dmCEP.DataSource1
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 176
    Top = 27
    Width = 488
    Height = 374
    DataSource = dmCEP.DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object cbFiltro: TComboBox
    Left = 8
    Top = 144
    Width = 145
    Height = 21
    TabOrder = 4
    Text = 'cbFiltro'
    OnChange = cbFiltroChange
    Items.Strings = (
      'UF'
      'Endereco'
      'Faixa')
  end
  object Edit1: TEdit
    Left = 8
    Top = 184
    Width = 145
    Height = 21
    TabOrder = 5
  end
  object Edit2: TEdit
    Left = 8
    Top = 224
    Width = 145
    Height = 21
    TabOrder = 6
    Visible = False
  end
  object btnFiltro: TButton
    Left = 78
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Filtrar'
    TabOrder = 7
    OnClick = btnFiltroClick
  end
end
