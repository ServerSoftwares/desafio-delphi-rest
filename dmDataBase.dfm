object dmDB: TdmDB
  Height = 630
  Width = 1356
  PixelsPerInch = 192
  object fdConexao: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = fdConexaoAfterConnect
    BeforeConnect = fdConexaoBeforeConnect
    Left = 104
    Top = 86
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 398
    Top = 88
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 720
    Top = 90
  end
  object tblEnderecos: TFDQuery
    Connection = fdConexao
    SQL.Strings = (
      'Select * From Conexao')
    Left = 102
    Top = 246
  end
end
