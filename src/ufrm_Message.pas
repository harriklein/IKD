unit ufrm_Message;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Controls.Presentation, FMX.Effects, FMX.Objects;

type
  Tfrm_Message = class(TFrame)
    ballon: TRectangle;
    ShadowEffect_Ballon: TShadowEffect;
    lbl_Message: TLabel;
    aniFloat_Ballon: TFloatAnimation;
    btn_Close: TSpeedButton;
    timer_Timeout: TTimer;
    procedure ballonClick(Sender: TObject);
    procedure timer_TimeoutTimer(Sender: TObject);
  private
    { Private declarations }
    procedure ballonShow(AMsg: string);
  public
    { Public declarations }
  end;

  procedure ShowAlert(ATxt: String);
  procedure HideAlert();

var
  frm_Message : Tfrm_Message;


implementation

{$R *.fmx}

uses ufrm_Main;

procedure Tfrm_Message.ballonShow(AMsg: string);
begin
  lbl_Message.Text   := AMsg;
  Self.Position.Y       := frm_Main.Height;
  Self.Position.X       := 15;
  Self.Width            := frm_Main.Width - 45;
  ballon.Visible        := True;
  aniFloat_Ballon.StopValue  := Self.Position.Y - 180;
  aniFloat_Ballon.Start;
  timer_Timeout.Interval := 5000;
  timer_Timeout.Enabled  := True;
end;

procedure Tfrm_Message.timer_TimeoutTimer(Sender: TObject);
begin
  timer_Timeout.Enabled := False;
  Self.Visible         := False;
end;


procedure Tfrm_Message.ballonClick(Sender: TObject);
begin
  Self.Visible := False;
end;

procedure ShowAlert(ATxt: String);
begin
  HideAlert();

  frm_Message := Tfrm_Message.Create(frm_Main);
  frm_Message.Parent := frm_Main;
  frm_Message.ballonShow(ATxt);
end;


procedure HideAlert();
begin
  if Assigned(frm_Message) then
    begin
       frm_Message.Free;
       frm_Message := nil;
    end;
end;


end.
