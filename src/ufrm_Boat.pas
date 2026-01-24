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
    lbl_Info: TLabel;
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

    FMinutes                : Int64;

    FID                     : TGuid;
    FNumber                 : String;
    FActive                 : Boolean;
    FColor                  : TAlphaColor;
    FDefaultMinutes         : Integer;
    FDefaultValue           : Integer;
    FDefaultExtraMinutes    : Integer;
    FDefaultExtraValue      : Integer;
    FPoSID                  : TGuid;

    FRented                 : Boolean;
    FCashRegisterID         : String;
    FRentedSince            : TDateTime;
    FRentalPausedAt         : TDateTime;
    FRentalId               : TGuid;
    FRentalExpectedMinutes  : Int64;
    FRentalToleranceMinutes : Int64;

    FWarning       : Boolean;

    constructor Create( AOwner                  : TFmxObject;
                        AFrame                  : TFmxObject;
                        AID                     : TGuid;
                        ANumber                 : String;
                        AActive                 : Boolean;
                        AColor                  : TAlphaColor;
                        ADefaultMinutes         : Integer;
                        ADefaultValue           : Integer;
                        ADefaultExtraMinutes    : Integer;
                        ADefaultExtraValue      : Integer;
                        APoSID                  : TGuid;
                        ARented                 : Boolean;
                        ACashRegisterID         : String;
                        ARentedSince            : TDateTime;
                        ARentalPausedAt         : TDateTime;
                        ARentalId               : TGuid;
                        ARentalExpectedMinutes  : Int64;
                        ARentalToleranceMinutes : Int64
                      ); overload;
    procedure   Update(ADate: TDateTime);

    procedure   ResetRent;
  end;


const
  BoatColorNormal   : TAlphaColor = TAlphaColors.White;
  BoatColorRented   : TAlphaColor = TAlphaColors.Cornflowerblue; // Lightskyblue;
  BoatColorWarning  : TAlphaColor = TAlphaColors.Gold;
  BoatColorInactive : TAlphaColor = TAlphaColors.Lightgray;      // TAlphaColor = TAlphaColors.Lightcoral;
  BoatColorCritical : TAlphaColor = TAlphaColors.Lightcoral;

  PAYMENT_METHOD_MULTI    = 'MULTI';
  PAYMENT_METHOD_CARD     = 'CARD';
  PAYMENT_METHOD_CASH     = 'CASH';
  PAYMENT_METHOD_PIX      = 'PIX';
  PAYMENT_METHOD_OTHER    = 'OTHER';
  PAYMENT_METHOD_DISCOUNT = 'DISCOUNT';

//  BOAT_EXTRA_MINUTES = 10;
//  BOAT_EXTRA_VALUE   = 10;


function PaymentMethod_PT_to_EN(AText: String): String;
function PaymentMethod_EN_to_PT(AText: String): String;
function PaymentMethod_EN_to_PT3(AText: String): String;
function BoatMinutesBetween(AStart, AEnd: TDateTime): Int64;


implementation

{$R *.fmx}

uses udm_Main, ufrm_Main, System.UIConsts;

function PaymentMethod_PT_to_EN(AText: String): String;
begin
       if AText = 'CARTÃO'         then Result := PAYMENT_METHOD_CARD
  else if AText = 'DINHEIRO'       then Result := PAYMENT_METHOD_CASH
  else if AText = 'PIX'            then Result := PAYMENT_METHOD_PIX
  else if AText = 'OUTRO'          then Result := PAYMENT_METHOD_OTHER
  else if AText = 'CORTESIA'       then Result := PAYMENT_METHOD_DISCOUNT
  else if AText = 'DIVIDIDO'       then Result := PAYMENT_METHOD_MULTI;
end;

function PaymentMethod_EN_to_PT(AText: String): String;
begin
       if AText = PAYMENT_METHOD_CARD      then Result := 'CARTÃO'
  else if AText = PAYMENT_METHOD_CASH      then Result := 'DINHEIRO'
  else if AText = PAYMENT_METHOD_PIX       then Result := 'PIX'
  else if AText = PAYMENT_METHOD_OTHER     then Result := 'OUTRO'
  else if AText = PAYMENT_METHOD_DISCOUNT  then Result := 'CORTESIA'
  else if AText = PAYMENT_METHOD_MULTI     then Result := 'DIVIDIDO';
end;

function PaymentMethod_EN_to_PT3(AText: String): String;
begin
       if AText = PAYMENT_METHOD_CARD      then Result := 'CAR'
  else if AText = PAYMENT_METHOD_CASH      then Result := 'DIN'
  else if AText = PAYMENT_METHOD_PIX       then Result := 'PIX'
  else if AText = PAYMENT_METHOD_OTHER     then Result := 'OUT'
  else if AText = PAYMENT_METHOD_DISCOUNT  then Result := 'COR'
  else if AText = PAYMENT_METHOD_MULTI     then Result := 'DIV';
end;

function BoatMinutesBetween(AStart, AEnd: TDateTime): Int64;
begin
  if CLOCK_IN_SECONDS then
    begin
      Result := SecondsBetween(AEnd, AStart);       // Change to minutes
    end
  else
    begin
      Result := MinutesBetween(AEnd, AStart);
    end;
end;

constructor Tfrm_Boat.Create(
                        AOwner                  : TFmxObject;
                        AFrame                  : TFmxObject;
                        AID                     : TGuid;
                        ANumber                 : String;
                        AActive                 : Boolean;
                        AColor                  : TAlphaColor;
                        ADefaultMinutes         : Integer;
                        ADefaultValue           : Integer;
                        ADefaultExtraMinutes    : Integer;
                        ADefaultExtraValue      : Integer;
                        APoSID                  : TGuid;
                        ARented                 : Boolean;
                        ACashRegisterID         : String;
                        ARentedSince            : TDateTime;
                        ARentalPausedAt         : TDateTime;
                        ARentalId               : TGuid;
                        ARentalExpectedMinutes  : Int64;
                        ARentalToleranceMinutes : Int64
                      );
begin
  inherited Create(Owner);
  Name      := 'Boat' + ANumber;
  Parent    := AOwner;
  Frm       := AFrame;

  FMinutes  := 0;

  FID                  := AID;
  FNumber              := ANumber;
  FActive              := AActive;
  FColor               := AColor; if AColor = TAlphaColors.Null then FColor := TAlphaColors.White;
  FDefaultMinutes      := ADefaultMinutes;
  FDefaultValue        := ADefaultValue;
  FDefaultExtraMinutes := ADefaultExtraMinutes;
  FDefaultExtraValue   := ADefaultExtraValue;
  FPoSID               := APoSID;

  FRented                 := ARented;
  FCashRegisterID         := ACashRegisterID;
  FRentedSince            := ARentedSince;
  FRentalPausedAt         := ARentalPausedAt;
  FRentalId               := ARentalId;
  FRentalExpectedMinutes  := ARentalExpectedMinutes;
  FRentalToleranceMinutes := ARentalToleranceMinutes;

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


procedure Tfrm_Boat.ResetRent;
begin
  FRented                 := false;
  FCashRegisterID         := '';
  FRentedSince            := 0;
  FRentalPausedAt         := 0;
  FRentalId               := GUID_NULL;
  FRentalExpectedMinutes  := 0;
  FRentalToleranceMinutes := 0;
  FWarning                := false;
end;

procedure Tfrm_Boat.TimerTimer(Sender: TObject);
begin
  Update(Now);
end;

procedure Tfrm_Boat.Update(ADate: TDateTime);
var
  LMinutes  : Int64;
  LTolerance: Integer;
begin
  FWarning  := False;

  if FRentalPausedAt = 0 then
    begin
      if lbl_Info.Text <> '' then lbl_Info.Text := '';
    end
  else
    begin
      if lbl_Info.Text <> '⛔' then lbl_Info.Text := '⛔';
      ADate := FRentalPausedAt;
    end;

  LMinutes   := BoatMinutesBetween(FRentedSince, ADate);

  if FRented then
    begin
      if LMinutes >= FRentalExpectedMinutes then
        begin
          if LMinutes >= (FRentalExpectedMinutes + FRentalToleranceMinutes) then
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

  if LMinutes <> FMinutes then
    begin
      FMinutes := LMinutes;
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
