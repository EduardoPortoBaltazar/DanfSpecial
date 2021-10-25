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
    SQL.Strings = (
      'SELECT'
      ' R.NUM_RESERVA'
      ',L.NUMERO_LANCAMENTO AS PARAMETRO1'
      ', CASE GP.TIPOGRUPOPRODUTO'
      'WHEN '#39'B'#39' THEN'
      'CT.IDCONTACOR'
      'else'
      'CR.IDCONTACOR'
      'END AS PARAMETRO2'
      ', MC.NUMMOVIMENTO AS PARAMETRO3'
      '  FROM LANCAMENVHL L'
      'INNER JOIN CONTACOR CC ON CC.IDCONTACOR = L.IDCONTACOR'
      
        'INNER JOIN LANCPDV LP on LP.NUMERO_LANCAMENTO = L.NUMERO_LANCAME' +
        'NTO'
      
        'INNER JOIN NOTAPDV N ON N.NUMNOTA = cast(trim(Substring(LP.DOCUM' +
        'ENTO from 9 for 10)) as numeric(10,2))'
      
        'INNER JOIN LANCAMENPDV LV ON LV.NUMNOTA = N.NUMNOTA AND LP.COD_I' +
        'TEM_PDV = LV.CODITEM'
      
        'INNER JOIN MOVCAIXA MC ON LV.NUMMESA = MC.NUMMESA AND LV.DATAMES' +
        'A = MC.DATAMESA AND N.NUMNOTA = MC.NUMNOTA'
      
        'INNER JOIN ITEM I ON I.CODITEM = LP.COD_ITEM_PDV  AND I.CODITEM ' +
        '=  LV.CODITEM'
      
        'INNER JOIN GRUPOPRODUTO GP ON GP.IDGRUPOPRODUTOPAI IS NOT NULL A' +
        'ND GP.IDGRUPOPRODUTO = I.CODGRUPOITEM'
      'INNER JOIN RESERVA R'
      'LEFT JOIN PARAMS PR ON IDHOTEL = 1'
      'ON R.NUMERO_UH ='
      'CASE'
      'char_length(LV.POSICAO)'
      'WHEN 4 THEN'
      'cast(trim(Substring(LV.POSICAO from 2 for 5)) as numeric(10,0))'
      'WHEN 3 THEN LV.POSICAO'
      'END'
      ' AND R.COD_STATUS_RESERVA = 2'
      
        'INNER JOIN CONTACOR CT ON CT.NUM_RESERVA = R.NUM_RESERVA AND CT.' +
        'NUM_CONTA = 1'
      
        'INNER JOIN CONTACOR CR ON CR.NUM_RESERVA = R.NUM_RESERVA AND CR.' +
        'NUM_CONTA = 2'
      'WHERE'
      '       DATA_LANCAMENTO = PR.DATA_ULT_AUDITORIA'
      '   AND CC.NOME_CONTA = '#39'RESTAURANTE'#39
      '   AND CC.DATA_CRIACAO IS NOT NULL'
      '   AND CC.DATA_ENCERRAMENTO IS NULL'
      '   AND N.DATAEMISSAO = PR.DATA_ULT_AUDITORIA'
      'GROUP BY'
      'L.NUMERO_LANCAMENTO'
      ', LP.COD_PDV'
      ', CC.IDCONTACOR'
      ', R.NUM_RESERVA'
      ', LV.POSICAO'
      ',CT.IDCONTACOR'
      ',CR.IDCONTACOR'
      ', CT.NUM_CONTA'
      ', CR.NUM_CONTA'
      ', N.DATAEMISSAO'
      ', LP.DOCUMENTO'
      
        ', cast(trim(Substring(LP.DOCUMENTO from 9 for 10)) as numeric(10' +
        ',0))'
      ', N.NUMNOTA'
      ', N.VALORTOTAL'
      ', L.VALOR_LANCAMENTO'
      ', GP.TIPOGRUPOPRODUTO'
      ', MC.NUMMOVIMENTO'
      ', CC.NOME_CONTA'
      ', N.CUPOMCANCELADO'
      '')
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