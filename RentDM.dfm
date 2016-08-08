object dmRent: TdmRent
  OldCreateOrder = False
  Left = 374
  Top = 253
  Height = 340
  Width = 451
  object adocRent: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=data.mdb;Persist S' +
      'ecurity Info=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
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
end
