object dmCEP: TdmCEP
  OldCreateOrder = False
  Height = 363
  Width = 563
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSOLEDBSQL.1;Persist Security Info=False;User ID=sa;Ini' +
      'tial Catalog=ProjetoCEP;Data Source=(local);Initial File Name=""' +
      ';Server SPN="";Authentication="";Access Token=""'
    Provider = 'MSOLEDBSQL.1'
    Left = 56
    Top = 64
  end
  object ADODataSet1: TADODataSet
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    CommandText = 'SELECT CodigoCEP, CEP, estado, bairro, cidade, rua FROM CEP'
    Parameters = <>
    Left = 112
    Top = 64
    object ADODataSet1CodigoCEP: TAutoIncField
      FieldName = 'CodigoCEP'
      ReadOnly = True
    end
    object ADODataSet1CEP: TStringField
      FieldName = 'CEP'
      Size = 8
    end
    object ADODataSet1estado: TStringField
      FieldName = 'estado'
      Size = 50
    end
    object ADODataSet1bairro: TStringField
      FieldName = 'bairro'
      Size = 50
    end
    object ADODataSet1cidade: TStringField
      FieldName = 'cidade'
      Size = 50
    end
    object ADODataSet1rua: TStringField
      FieldName = 'rua'
      Size = 50
    end
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 168
    Top = 64
  end
end
