unit DMSPecial;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.DBClient,
  FireDAC.Phys.Oracle, FireDAC.Phys.OracleDef, Data.FMTBcd, Data.SqlExpr,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDQueryConta: TFDQuery;
    SQLUpdate: TSQLQuery;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FQueryUpdate: TFDQuery;

    type TEscreveLog = procedure (Alog: string) of object;
  private
    { Private declarations }
  public
    { Public declarations }

  procedure abrirConta(AEscreveLog: TEscreveLog);
  procedure atualizaConta(AEscreveLog: TEscreveLog);

  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

procedure TDM.abrirConta;
begin
  FDQueryConta.Open;
end;

procedure TDM.atualizaConta(AEscreveLog: TEscreveLog);
begin
  while not FDQueryConta.Eof do
  begin
    FQueryUpdate.SQL.Clear;
    FQueryUpdate.SQL.Add('DELETE FROM LANCAMENVHL WHERE NUMLANCPAI = ' +  FDQueryConta.FieldByName('PARAMETRO1').AsString);
    AEscreveLog(FQueryUpdate.SQL.Text);
    FQueryUpdate.ExecSQL;

    FQueryUpdate.SQL.Clear;
    FQueryUpdate.SQL.Add('UPDATE LANCAMENVHL SET IDCONTACOR = ' +  FDQueryConta.FieldByName('PARAMETRO2').AsString + ' WHERE NUMERO_LANCAMENTO= ' + FDQueryConta.FieldByName('PARAMETRO1').AsString);
    AEscreveLog(FQueryUpdate.SQL.Text);
    FQueryUpdate.ExecSQL;

    FQueryUpdate.SQL.Clear;
    FQueryUpdate.SQL.Add('UPDATE MOVCAIXA SET TIPODOC = 6  WHERE NUMMOVIMENTO = ' +  FDQueryConta.FieldByName('PARAMETRO3').AsString);
    AEscreveLog(FQueryUpdate.SQL.Text);
    FQueryUpdate.ExecSQL;

    AEscreveLog(FormatDateTime('DD/MM/YYYY hh:mm:ss', Now));
    AEscreveLog(EmptyStr);
    FDQueryConta.Next;
  end;
end;

end.
