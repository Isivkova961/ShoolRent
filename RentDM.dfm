object dmRent: TdmRent
  OldCreateOrder = False
  Left = 374
  Top = 253
  Height = 340
  Width = 451
  object adocRent: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=data.mdb;Persist S' +
      'ecurity Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.ACE.OLEDB.12.0'
    Left = 24
    Top = 24
  end
  object adoqRegistr: TADOQuery
    Connection = adocRent
    Parameters = <>
    Left = 24
    Top = 72
  end
  object adoqRegCount: TADOQuery
    Connection = adocRent
    Parameters = <>
    Left = 24
    Top = 120
  end
  object adoqDress: TADOQuery
    Active = True
    Connection = adocRent
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM dress')
    Left = 184
    Top = 72
  end
  object dsDress: TDataSource
    DataSet = adoqDress
    Left = 224
    Top = 72
  end
  object adoqFitting: TADOQuery
    Active = True
    Connection = adocRent
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM fitting')
    Left = 88
    Top = 120
  end
  object dsFitting: TDataSource
    DataSet = adoqFitting
    Left = 128
    Top = 120
  end
  object adoqApron: TADOQuery
    Active = True
    Connection = adocRent
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM apron')
    Left = 184
    Top = 128
  end
  object dsApron: TDataSource
    DataSet = adoqApron
    Left = 224
    Top = 128
  end
end
