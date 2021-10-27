object DM: TDM
  OldCreateOrder = False
  Height = 322
  Width = 509
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Port=3050')
    LoginPrompt = False
    Left = 40
    Top = 48
  end
  object FDQueryConta: TFDQuery
    Connection = FDConnection
    Left = 48
    Top = 200
  end
  object SQLUpdate: TSQLQuery
    Params = <>
    Left = 208
    Top = 200
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    DriverID = 'FB'
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_1\bin\fbclient.dll'
    Left = 40
    Top = 104
  end
  object FQueryUpdate: TFDQuery
    Connection = FDConnection
    Left = 320
    Top = 184
  end
end
