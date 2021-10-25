program DanfService;

uses
  Vcl.Forms,
  DanfSpecial in 'DanfSpecial.pas' {FPrincipal},
  DMSPecial in 'Service\DMSPecial.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
