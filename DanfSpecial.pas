unit DanfSpecial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.WinXPanels, Vcl.StdCtrls, Vcl.Buttons, Vcl.Menus;

type
  TFPrincipal = class(TForm)
    imgFundo: TImage;
    pnlContente: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    CardPanel: TCardPanel;
    CardPrincipal: TCard;
    CardLog: TCard;
    mmLog: TMemo;
    spbFechar: TSpeedButton;
    spbMinimizar: TSpeedButton;
    pnlDirBanco: TPanel;
    Label1: TLabel;
    edtDiretorio: TEdit;
    spbDiretorio: TSpeedButton;
    OpenDialog: TOpenDialog;
    TrayIconDownload: TTrayIcon;
    SpeedButton1: TSpeedButton;
    popTryIcon: TPopupMenu;
    Maximizar1: TMenuItem;
    Timer: TTimer;
    procedure SpeedButton1Click(Sender: TObject);
    procedure spbFecharClick(Sender: TObject);
    procedure spbDiretorioClick(Sender: TObject);
    procedure spbMinimizarClick(Sender: TObject);
    procedure Maximizar1Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
    procedure escreveLog(Alog: string);
    procedure atualizar;
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
  DMSPecial;

{$R *.dfm}

procedure TFPrincipal.atualizar;
begin
 DM.FDConnection.Params.Database := edtDiretorio.Text;
 DM.FDConnection.Connected := True;
 CardPanel.ActiveCard := CardLog;
 DM.abrirConta(escreveLog);
 DM.atualizaConta(escreveLog);
end;

procedure TFPrincipal.escreveLog(Alog: string);
begin
  mmLog.Lines.Add(Alog);
end;

procedure TFPrincipal.Maximizar1Click(Sender: TObject);
begin
  TrayIconDownload.Visible := False;
  Application.MainForm.Show;
  TrayIconDownload.Visible := True;
end;

procedure TFPrincipal.spbDiretorioClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    edtDiretorio.Text := OpenDialog.FileName;
end;

procedure TFPrincipal.spbFecharClick(Sender: TObject);
begin
 Close;
end;

procedure TFPrincipal.spbMinimizarClick(Sender: TObject);
begin
  TrayIconDownload.Visible := True;
  Application.MainForm.Hide;
  TrayIconDownload.BalloonHint := 'Atualizando Danf';
  TrayIconDownload.ShowBalloonHint;
  Timer.Enabled := True;
end;

procedure TFPrincipal.SpeedButton1Click(Sender: TObject);
begin
 if edtDiretorio.Text = EmptyStr then
 begin
   ShowMessage('Não foi informado o Banco de Dados!');
   exit
 end;

 atualizar;
end;

procedure TFPrincipal.TimerTimer(Sender: TObject);
begin
 atualizar;
end;

end.
