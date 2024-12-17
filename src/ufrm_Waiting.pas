unit ufrm_Waiting;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects,
  FMX.Controls.Presentation;

type
  Tfrm_Waiting = class(TFrame)
    rect_Background: TRectangle;
    ani_Indicator: TAniIndicator;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure Waiting_Show;
procedure Waiting_Hide;

var
  frm_Waiting : Tfrm_Waiting = nil;

implementation

{$R *.fmx}

uses ufrm_Main;

procedure Waiting_Show;
begin
  if not Assigned(frm_Waiting) then
    begin
      frm_Waiting := Tfrm_Waiting.Create(frm_Main);
      frm_Waiting.Parent := frm_Main;
    end;
end;

procedure Waiting_Hide;
begin
  if Assigned(frm_Waiting) then
    begin
      frm_Waiting.DisposeOf;
      frm_Waiting := nil;
    end;
end;

end.
