object FormConexao: TFormConexao
  OldCreateOrder = False
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
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 24
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\ProDelphiBerlin\DesafioDelphi\dll\libpq.dll'
    Left = 56
    Top = 80
  end
  object FDMemTableCEP: TFDMemTable
    FieldDefs = <
      item
        Name = 'cep'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'state'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'city'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'neighborhood'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'street'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'service'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 136
    Top = 56
    object FDMemTableCEPcep: TStringField
      FieldName = 'cep'
      Size = 10
    end
    object FDMemTableCEPstate: TStringField
      FieldName = 'state'
      Size = 2
    end
    object FDMemTableCEPcity: TStringField
      FieldName = 'city'
      Size = 100
    end
    object FDMemTableCEPneighborhood: TStringField
      FieldName = 'neighborhood'
      Size = 100
    end
    object FDMemTableCEPstreet: TStringField
      FieldName = 'street'
      Size = 100
    end
    object FDMemTableCEPservice: TStringField
      FieldName = 'service'
    end
  end
end
