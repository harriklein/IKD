unit ufrm_Message;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Controls.Presentation, FMX.Effects, FMX.Objects;

type
  Tfrm_Message = class(TFrame)
    ballon: TRectangle;
    ShadowEffect1: TShadowEffect;
    ballon_Message: TLabel;
    ballon_ani: TFloatAnimation;
    ballon_Close: TSpeedButton;
    ballon_Timer: TTimer;
    procedure ballonClick(Sender: TObject);
    procedure ballon_TimerTimer(Sender: TObject);
  private
    { Private declarations }
    procedure ballonShow(argMsg: string);
  public
    { Public declarations }
  end;

  procedure ShowAlert(argTxt: String);
  procedure HideAlert();

var
  frm_Message : Tfrm_Message;


implementation

{$R *.fmx}

uses ufrm_Main;

procedure Tfrm_Message.ballonShow(argMsg: string);
begin
  ballon_Message.Text   := argMsg;
  Self.Position.Y     := frm_Main.Height;
  Self.Position.X     := 15;
  Self.Width          := frm_Main.Width - 45;
  ballon.Visible        := True;
  ballon_ani.StopValue  := Self.Position.Y - 180;
  ballon_ani.Start;
  ballon_timer.Interval := 5000;
  ballon_timer.Enabled  := True;
end;

procedure Tfrm_Message.ballon_TimerTimer(Sender: TObject);
begin
  ballon_timer.Enabled := False;
  Self.Visible := False;
end;


procedure Tfrm_Message.ballonClick(Sender: TObject);
begin
  Self.Visible := False;
end;

procedure ShowAlert(argTxt: String);
begin
  HideAlert();

  frm_Message := Tfrm_Message.Create(frm_Main);
  frm_Message.Parent := frm_Main;
  frm_Message.ballonShow(argTxt);

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
