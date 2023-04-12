object FormConexao: TFormConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=API'
      'User_Name=postgres'
      'Password=postgres'
      'Server=192.168.1.200'
      'Port=5433'
      'DriverID=PG')
    LoginPrompt = False
    Left = 56
    Top = 24
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 56
    Top = 80
  end
end
