program IKD;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrm_Main in 'src\ufrm_Main.pas' {frm_Main},
  ufrm_Login in 'src\ufrm_Login.pas' {frm_Login: TFrame},
  ufrm_Default in 'src\ufrm_Default.pas' {frm_Default: TFrame},
  ufrm_Config in 'src\ufrm_Config.pas' {frm_Config: TFrame},
  ufrm_Message in 'src\ufrm_Message.pas' {frm_Message: TFrame},
  udm_Main in 'src\udm_Main.pas' {dm_Main: TDataModule},
  unt_Printer in 'src\unt_Printer.pas',
  unt_DeviceUtils in 'src\unt_DeviceUtils.pas',
  ufrm_Waiting in 'src\ufrm_Waiting.pas' {frm_Waiting: TFrame},
  ufrm_Boats in 'src\ufrm_Boats.pas' {frm_Boats: TFrame};

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.CreateForm(Tfrm_Main, frm_Main);
  Application.CreateForm(Tdm_Main, dm_Main);
  Application.Run;
end.
