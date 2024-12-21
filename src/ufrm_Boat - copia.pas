unit ufrm_Boat;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.DateUtils,
  FMX.Controls.Presentation, FMX.Objects, FMX.Effects, FMX.Layouts;

type
  Tfrm_Boat = class(TFrame)
    Timer          : TTimer;
    path_Swan      : TPath;
    lbl_Number     : TLabel;
    lbl_Minutes    : TLabel;
    rect_Background: TRectangle;
    layout_Resize  : TGridPanelLayout;
    btn: TSpeedButton;
    procedure FrameResize(Sender: TObject);
    procedure TimerTimer (Sender: TObject);
  private
    { Private declarations }


  public
    { Public declarations }
    Frm : TFmxObject;

    FID       : Integer;
    FNumber   : String;
    FActive   : Boolean;
    FRented   : Boolean;
    FRentedAt : TDateTime;
    FMinutes  : Int64;
    FWarning  : Boolean;
    FAdvancedPaymentValue   : Integer;
    FAdvancedPaymentMinutes : Integer;

    constructor Create( AOwner: TFmxObject; AFrame: TFmxObject; ID: Integer; Number: String; Active, Rented:Boolean; RentedAt: TDateTime; AdvancedPaymentValue, AdvancedPaymentMinutes: Integer ); overload;
    procedure   Update( ADate: TDateTime );
  end;

const
  BoatColorNormal   : TAlphaColor = TAlphaColors.White;
  BoatColorRented   : TAlphaColor = TAlphaColors.Cornflowerblue; // Lightskyblue;
  BoatColorWarning  : TAlphaColor = TAlphaColors.Gold;
  BoatColorInactive : TAlphaColor = TAlphaColors.Lightgray;      // TAlphaColor = TAlphaColors.Lightcoral;
  BoatColorCritical : TAlphaColor = TAlphaColors.Lightcoral;

implementation

{$R *.fmx}



constructor Tfrm_Boat.Create( AOwner: TFmxObject; AFrame: TFmxObject; ID: Integer; Number: String;  Active, Rented:Boolean; RentedAt: TDateTime; AdvancedPaymentValue, AdvancedPaymentMinutes: Integer );
begin
  inherited Create( Owner );
  Parent := AOwner;
  Frm       := AFrame;

  if ID >= 0 then
    Name      := 'Boat' + IntToStr(ID)
  else
    Name      := 'Boat_' + IntToStr(Abs(ID));

  FID       := ID;
  FActive   := Active;
  FNumber   := Number;
  FRented   := Rented;
  FRentedAt := RentedAt;
  FAdvancedPaymentValue   := AdvancedPaymentValue;
  FAdvancedPaymentMinutes := AdvancedPaymentMinutes;

  FMinutes  := 0;

  Update( Now );

  lbl_Number.Text  := FNumber;
end;

procedure Tfrm_Boat.FrameResize(Sender: TObject);
begin
  rect_Background.Scale.X := Width  / 100;
  rect_Background.Scale.Y := Height / 100;
end;

procedure Tfrm_Boat.TimerTimer(Sender: TObject);
begin
  Update( Now );
end;

procedure Tfrm_Boat.Update( ADate: TDateTime );
var
  _minutes: Int64;
  _tolerance: Integer;
begin
  FWarning  := False;
  _tolerance := 10; // minutes of tolerance
  _minutes   := SecondsBetween( ADate, FRentedAt );  // Change to minutes

  if FRented then
    begin
      if _minutes > FAdvancedPaymentMinutes then
        begin
          if _minutes > (FAdvancedPaymentMinutes + _tolerance) then
            begin
              FWarning := True;
              if rect_Background.Fill.Color <> BoatColorCritical then
                rect_Background.Fill.Color := BoatColorCritical;
            end
          else
            begin
              FWarning := True;
              if rect_Background.Fill.Color <> BoatColorWarning then
                rect_Background.Fill.Color := BoatColorWarning;
            end;
        end
      else
        begin
          if rect_Background.Fill.Color <> BoatColorRented then
            rect_Background.Fill.Color := BoatColorRented;
        end;
    end
  else
    begin
      if FActive then
        begin
          if rect_Background.Fill.Color <> BoatColorNormal then
            rect_Background.Fill.Color := BoatColorNormal;
        end
      else
        begin
          if rect_Background.Fill.Color <> BoatColorInactive then
            rect_Background.Fill.Color := BoatColorInactive;
        end;
    end;

  if _minutes <> FMinutes then
    begin
      FMinutes := _minutes;
      lbl_Minutes.Text := IntToStr(FMinutes)+ '''';
    end;

  if FRented <> lbl_Minutes.Visible then
    begin
      lbl_Minutes.Visible := FRented;
      // Timer.Enabled := False;
    end;
end;

end.
