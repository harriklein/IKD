unit ufrm_Boat;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.DateUtils,
  FMX.Controls.Presentation, FMX.Objects, FMX.Effects, FMX.Layouts, FMX.Colors,
  FMX.Styles.Objects;

type
  Tfrm_Boat = class(TFrame)
    Timer          : TTimer;
    rect_Background: TRectangle;
    path_Swan: TPath;
    layout_Resize: TGridPanelLayout;
    lbl_Minutes: TLabel;
    lbl_Number: TLabel;
    procedure FrameResize(Sender: TObject);
    procedure TimerTimer (Sender: TObject);
    procedure rect_BackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rect_BackgroundMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rect_BackgroundMouseLeave(Sender: TObject);
  private
    { Private declarations }


  public
    { Public declarations }
    Frm : TFmxObject;

    FNumber      : String;
    FActive      : Boolean;
    FColor       : TAlphaColor;
    FDefaultValue: Integer;
    FRented      : Boolean;
    FRentedAt    : TDateTime;
    FMinutes     : Int64;
    FWarning     : Boolean;
    FAdvancedPaymentValue   : Integer;
    FAdvancedPaymentMinutes : Integer;

    constructor Create(AOwner: TFmxObject; AFrame: TFmxObject; ANumber: String; AActive: Boolean; AColor: TAlphaColor; ADefaultValue: Integer; ARented:Boolean; ARentedAt: TDateTime; AAdvancedPaymentValue, AAdvancedPaymentMinutes: Integer); overload;
    procedure   Update(ADate: TDateTime);
  end;

const
  BoatColorNormal   : TAlphaColor = TAlphaColors.White;
  BoatColorRented   : TAlphaColor = TAlphaColors.Cornflowerblue; // Lightskyblue;
  BoatColorWarning  : TAlphaColor = TAlphaColors.Gold;
  BoatColorInactive : TAlphaColor = TAlphaColors.Lightgray;      // TAlphaColor = TAlphaColors.Lightcoral;
  BoatColorCritical : TAlphaColor = TAlphaColors.Lightcoral;

implementation

{$R *.fmx}

uses udm_Main, ufrm_Main, System.UIConsts;



constructor Tfrm_Boat.Create( AOwner: TFmxObject; AFrame: TFmxObject; ANumber: String; AActive: Boolean; AColor: TAlphaColor; ADefaultValue: Integer; ARented:Boolean; ARentedAt: TDateTime; AAdvancedPaymentValue, AAdvancedPaymentMinutes: Integer );
begin
  inherited Create(Owner);
  Parent := AOwner;
  Frm       := AFrame;
  Name      := ANumber;

  if AColor = TAlphaColors.Null then
    FColor := TAlphaColors.White
  else
    FColor := AColor;
  FNumber       := ANumber;
  FActive       := AActive;
  FDefaultValue := ADefaultValue;
  FRented       := ARented;
  FRentedAt     := ARentedAt;
  FMinutes      := 0;
  FAdvancedPaymentValue   := AAdvancedPaymentValue;
  FAdvancedPaymentMinutes := AAdvancedPaymentMinutes;

  Update(Now);

  lbl_Number.Text  := FNumber;
end;


procedure Tfrm_Boat.FrameResize(Sender: TObject);
begin
  rect_Background.Scale.X := Width  / 100;
  rect_Background.Scale.Y := Height / 100;
end;

procedure Tfrm_Boat.rect_BackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  path_Swan.Fill.Color := TAlphaColors.Gray;
end;

procedure Tfrm_Boat.rect_BackgroundMouseLeave(Sender: TObject);
begin
  path_Swan.Fill.Color := FColor;
end;

procedure Tfrm_Boat.rect_BackgroundMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  path_Swan.Fill.Color := FColor;
end;

procedure Tfrm_Boat.TimerTimer(Sender: TObject);
begin
  Update(Now);
end;

procedure Tfrm_Boat.Update(ADate: TDateTime);
var
  _Minutes  : Int64;
  _Tolerance: Integer;
begin
  FWarning  := False;
  _Tolerance := 10; // minutes of tolerance
  _Minutes   := SecondsBetween( ADate, FRentedAt );  // Change to minutes

  if FRented then
    begin
      if _Minutes > FAdvancedPaymentMinutes then
        begin
          if _Minutes > (FAdvancedPaymentMinutes + _Tolerance) then
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

  if _Minutes <> FMinutes then
    begin
      FMinutes := _Minutes;
      lbl_Minutes.Text := IntToStr(FMinutes)+ '''';
    end;

  if FRented <> lbl_Minutes.Visible then
    begin
      lbl_Minutes.Visible := FRented;
      // Timer.Enabled := False;
    end;

  path_Swan.Fill.Color := FColor;
end;

end.
