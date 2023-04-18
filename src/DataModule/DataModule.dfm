object Dm: TDm
  Height = 164
  Width = 640
  object FdConnSQLite: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = FdConnSQLiteAfterConnect
    BeforeConnect = FdConnSQLiteBeforeConnect
    Left = 16
    Top = 8
  end
  object FdWaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 120
    Top = 8
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 16
    Top = 72
  end
end
