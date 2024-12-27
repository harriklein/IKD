unit ufrm_Rental;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects,
  Data.DB, FMX.DialogService, FireDAC.Comp.DataSet,
  FMX.Layouts, FMX.Edit, FMX.Effects, FMX.Controls.Presentation, FMX.TabControl, System.IniFiles,
  ufrm_Boat, System.Actions, FMX.ActnList, FMX.DateTimeCtrls, FMX.EditBox, FMX.NumberBox, System.DateUtils,
  FMX.ListBox, FMX.ScrollBox, FMX.Memo, System.Generics.Collections, FireDAC.Comp.Client,
  FMX.Memo.Types;

type
  Tfrm_Rental = class(TFrame)
    tabCtrl_List: TTabControl;
    tabItem_List: TTabItem;
    toolBar_List: TToolBar;
    shadow_List: TShadowEffect;
    btn_Config: TSpeedButton;
    path_Add: TPath;
    tabItem_Start: TTabItem;
    toolBar_Start: TToolBar;
    shadow_Detail: TShadowEffect;
    btn_Cancel: TSpeedButton;
    layout_Boats: TGridLayout;
    VertScrollBox1: TVertScrollBox;
    timer_UpdateSize: TTimer;
    tabItem_Finish: TTabItem;
    vScroll_Start: TVertScrollBox;
    layout_Start: TFlowLayout;
    layout_Start2: TLayout;
    btn_Start: TButton;
    ToolBar1: TToolBar;
    ShadowEffect1: TShadowEffect;
    btn_CancelFinish: TSpeedButton;
    vScroll_RentFinish: TVertScrollBox;
    layout_RentFinish: TFlowLayout;
    layout_RentFinish1: TLayout;
    edt_RentFinishStartHour: TTimeEdit;
    edt_RentFinishStartDate: TDateEdit;
    edt_RentFinishStartMinutes: TNumberBox;
    Label1: TLabel;
    edt_RentFinishStartValue: TNumberBox;
    Label2: TLabel;
    Label3: TLabel;
    lbl_Start: TLabel;
    layout_RentFinish2: TLayout;
    edt_RentFinishCalcMinutes: TNumberBox;
    Label4: TLabel;
    Label5: TLabel;
    edt_RentFinishCalcValue: TNumberBox;
    Label6: TLabel;
    lbl_Calculation: TLabel;
    layout_RentFinish3: TLayout;
    btn_RentFinish: TButton;
    edt_RentFinishMinutes: TNumberBox;
    Label7: TLabel;
    Label8: TLabel;
    edt_RentFinishValue: TNumberBox;
    Label9: TLabel;
    lbl_Finish: TLabel;
    switch_RentFinishChange: TSwitch;
    ActionList: TActionList;
    actTabChange_Start: TChangeTabAction;
    actTabChange_Finish: TChangeTabAction;
    actTabChange_List: TChangeTabAction;
    lbl_SubTitleStart: TLabel;
    lbl_SubTitleFinish: TLabel;
    Timer: TTimer;
    btn_Refresh: TSpeedButton;
    Label10: TLabel;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    tabItem_Config: TTabItem;
    ToolBar2: TToolBar;
    ShadowEffect2: TShadowEffect;
    btn_ConfigBack: TSpeedButton;
    lbl_SubTitleConfig: TLabel;
    vScrollBox_Config: TVertScrollBox;
    FlowLayout1: TFlowLayout;
    Layout1: TLayout;
    btn_ConfigSave: TButton;
    edt_ConfigSizePortrait: TNumberBox;
    lbl_ConfigSizePortrait: TLabel;
    lbl_ConfigSizePortrait1: TLabel;
    edt_ConfigSizeLandscape: TNumberBox;
    lbl_ConfigSizeLandscape: TLabel;
    lbl_ConfigSizeLandscape1: TLabel;
    actTabChange_Config: TChangeTabAction;
    path_Boat1: TPath;
    Path1: TPath;
    lbl_PaymentType: TLabel;
    lbl_PaymentTypeValue: TLabel;
    actTabChange_MultiPay: TChangeTabAction;
    edt_StartObs: TEdit;
    switch_StartPayMulti: TSwitch;
    lbl_StartPayMulti: TLabel;
    radio_StartPayCard: TRadioButton;
    lbl_StartPay: TLabel;
    rect_StartSeparator1: TRectangle;
    rect_StartPayCard: TRoundRect;
    edt_StartPayCard: TEdit;
    lbl_StartPayCardR: TLabel;
    lbl_StartPayCardC: TLabel;
    lbl_StartPayCardT: TLabel;
    rect_StartPayCash: TRoundRect;
    radio_StartPayCash: TRadioButton;
    edt_StartPayCash: TEdit;
    lbl_StartPayCashT: TLabel;
    lbl_StartPayCashC: TLabel;
    lbl_StartPayCashR: TLabel;
    rect_StartPayPix: TRoundRect;
    radio_StartPayPix: TRadioButton;
    edt_StartPayPix: TEdit;
    lbl_StartPayPixT: TLabel;
    lbl_StartPayPixC: TLabel;
    lbl_StartPayPixR: TLabel;
    rect_StartPayOther: TRoundRect;
    radio_StartPayOther: TRadioButton;
    edt_StartPayOther: TEdit;
    lbl_StartPayOtherT: TLabel;
    lbl_StartPayOtherC: TLabel;
    lbl_StartPayOtherR: TLabel;
    rect_StartPayDiscount: TRoundRect;
    radio_StartPayDiscount: TRadioButton;
    edt_StartPayDiscount: TEdit;
    lbl_StartPayDiscountT: TLabel;
    lbl_StartPayDiscountC: TLabel;
    lbl_StartPayDiscountR: TLabel;
    edt_StartValue: TEdit;
    lbl_StartValueT: TLabel;
    lbl_StartValueC: TLabel;
    lbl_StartValueR: TLabel;
    edt_StartMinutes: TEdit;
    lbl_StartMinutesT: TLabel;
    lbl_StartMinutesC: TLabel;
    rect_StartSeparator2: TRectangle;
    procedure layout_BoatsResized(Sender: TObject);
    procedure btn_ConfigClick(Sender: TObject);
    procedure timer_UpdateSizeTimer(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure btn_RentFinishClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_CancelFinishClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure switch_RentFinishChangeSwitch(Sender: TObject);
    procedure btn_ConfigSaveClick(Sender: TObject);
    procedure tabItem_FinishClick(Sender: TObject);
    procedure switch_StartPayMultiSwitch(Sender: TObject);
    procedure rect_StartPayPixClick(Sender: TObject);
    procedure edt_StartMinutesChange(Sender: TObject);
    procedure radio_StartPayChange(Sender: TObject);
    procedure edt_StartPayDiscountChange(Sender: TObject);
    procedure rect_StartPayOtherClick(Sender: TObject);
    procedure rect_StartPayOtherTap(Sender: TObject; const Point: TPointF);
    procedure rect_StartPayPixTap(Sender: TObject; const Point: TPointF);
    procedure rect_StartPayDiscountClick(Sender: TObject);
    procedure rect_StartPayDiscountTap(Sender: TObject; const Point: TPointF);
    procedure rect_StartPayCashClick(Sender: TObject);
    procedure rect_StartPayCashTap(Sender: TObject; const Point: TPointF);
    procedure rect_StartPayCardClick(Sender: TObject);
    procedure rect_StartPayCardTap(Sender: TObject; const Point: TPointF);
  private
    { Private declarations }
    FBoat                         : Tfrm_Boat;

    FBoatSizePortrait, FBoatSizeLandscape   : Integer;

    FBoatsApplyUpdatesErrorMessage: String;
    FBoatsGetErrorMessage         : String;

  public

    { Public declarations }
    // BASIC HANDLER: Prepare; ApplyUpdates; Refresh
    procedure Prepare;
    procedure BoatsRentalApplyUpdates;
    procedure BoatsRentalApplyUpdatesTerminated(Sender: TObject);
    procedure BoatsRefresh;
    procedure BoatsRefreshTerminated(Sender: TObject);
    // BASIC HANDLER COMPLEMENT: Refresh
    procedure RefreshGrid;
    procedure FixLayoutSize;
    procedure DoFixLayoutSize;
    procedure PrintReceipt;
    procedure BoatOnClick(Sender: TObject);
    procedure BoatOnTap(Sender: TObject; const Point: TPointF);
    procedure RentStart();
    procedure ShowStartPaymentMethodMulti(AShow: Boolean);
    function GetStartPaymentMethod(): String;
    procedure UpdateStartValue();
    function  CalculateStartValue(AMinutes: Integer; Discount: Integer = 0): Integer;

    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);

  end;

const
  frm_Rental_dlg_SetupSize_Title     = 'Ajustes';
  frm_Rental_dlg_SetupSize_Portrait  = 'Tamanho Posição Retrato (px)';
  frm_Rental_dlg_SetupSize_Landscape = 'Tamanho Posição Panorama (px)';

var
  frm_Rental : Tfrm_Rental;

implementation

{$R *.fmx}

uses unt_DeviceUtils, unt_ResourceStrings,unt_Printer, ufrm_Waiting,
  udm_Main, ufrm_Boats, ufrm_Main, unt_VSoftUUIDv7;

//------------------------------------------------------------------------------
// BASE HANDLE
//      Prepare
//      ApplyUpdates
//      Refresh
//------------------------------------------------------------------------------

procedure Tfrm_Rental.Prepare;
var
  LIniConfig : TiniFile;
begin

  tabCtrl_List.ActiveTab := tabItem_List;
//  GetPaymentTypeList(cbBox_Payment.Items);

  LIniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
  try
    FBoatSizePortrait   := LIniConfig.ReadInteger('CLIENT', 'BoatSizePortrait'  , 100);
    FBoatSizeLandscape  := LIniConfig.ReadInteger('CLIENT', 'BoatSizeLandscape' , 100);
  finally
    LIniConfig.Free;
  end;

  dm_Main.tb_Boat.LoadFromFile();
  dm_Main.tb_Rental.LoadFromFile();

  BoatsRefresh();
end;

procedure Tfrm_Rental.BoatsRentalApplyUpdates;
var
//  ADeltaList: TFDJSONDeltas;
  LIndex       : Integer;
//  Table : TFDMemTable;
begin
  if dm_Main.tb_Boat.State   in dsEditModes then dm_Main.tb_Boat.Post;
  if dm_Main.tb_Rental.State in dsEditModes then dm_Main.tb_Rental.Post;

  if frm_Main.Sync = ssOffline then
    begin
      dm_Main.tb_Boat.SaveToFile();
      dm_Main.tb_Rental.SaveToFile();

      Exit;
    end;

  frm_Main.Sync := ssSyncInProcess;


  //dm_Main.tb_Rental2.Data := dm_Main.tb_Rental;

//  ADeltaList := TFDJSONDeltas.Create;
  //TFDJSONDeltasWriter.ListAdd(ADeltaList, 'Rental', dm_Main.tb_Rental);
  //TFDJSONDeltasWriter.ListAdd(ADeltaList, 'Boat'  , dm_Main.tb_Boat  );
//  for idx := 0 to FTableList.Count - 1 do
//    TFDJSONDeltasWriter.ListAdd(ADeltaList, FTableList.Keys.ToArray[idx], FTableList.Values.ToArray[idx]);


  FBoatsApplyUpdatesErrorMessage := '';

  with TThread.CreateAnonymousThread( procedure
    begin
//      try
//        try
//          dm_Main.CloseSession;
//          dm_Main.srvMethodsClient.updateBoatsRental(ADeltaList);
//        except
//          on E: TDSRestProtocolException do
//            HandleRestException(dm_Server.DSRestConnection, 'Apply Updates Error', E, FBoatsApplyUpdatesErrorMessage);
//          on E : Exception do
//            FBoatsApplyUpdatesErrorMessage := CONNECTION_FAILED_TXT + E.Message;
//        end;
//      finally
//        dm_Server.CloseSession;
//      end;
    end
  ) do
    begin
      onTerminate := BoatsRentalApplyUpdatesTerminated;
      Start;
    end;
end;

procedure Tfrm_Rental.BoatsRentalApplyUpdatesTerminated(Sender: TObject);
//var
//  Table: TFDMemTable;
begin
//  try
//    dm_Server.CloseSession;
//
//    if not FBoatsApplyUpdatesErrorMessage.IsEmpty then
//      begin
//        if FBoatsApplyUpdatesErrorMessage.StartsWith(CONNECTION_FAILED_TXT) then
//          begin
//            // silence error
//          end
//        else
//          begin
//            TDialogService.ShowMessage(FBoatsApplyUpdatesErrorMessage);
//            dm_Server.tb_Boat.CancelUpdates; // Clear UpdatesPending????
//          end;
//      end;
//  finally
//    if FBoatsApplyUpdatesErrorMessage.IsEmpty then
//      begin
//        frm_Main.Sync := ssSyncOK;
//        dm_Server.tb_Rental.CancelUpdates; // Clear UpdatesPending
//        dm_Server.tb_Boat.CancelUpdates;   // Clear UpdatesPending
//        BoatsRefresh;
//      end
//    else
//      begin
//        //dm_Server.tb_Boat.SaveToFile;
//        //dm_Server.tb_Rental.SaveToFile;
//        for Table in FTableList.Values do
//          Table.SaveToFile;
//
//        frm_Main.Sync := ssSyncFailed;
//      end;
//  end;
end;



procedure Tfrm_Rental.BoatsRefresh;
begin
  if frm_Main.Sync = ssOffline then
    begin
      Waiting_Show;
      RefreshGrid;
      Waiting_Hide;
      Exit;
    end;

  if dm_Main.tb_Boat.UpdatesPending or dm_Main.tb_Rental.UpdatesPending  then
    begin
      RefreshGrid;
      BoatsRentalApplyUpdates;
      Exit;
    end;

  FBoatsGetErrorMessage := '';
  Waiting_Show;

  with TThread.CreateAnonymousThread( procedure
    begin
//      try
//        try
//          FBoatsDataSetList := dm_Main.srvMethodsClient.Boat;
//        except
//          on E: TDSRestProtocolException do
//            HandleRestException(dm_Server.DSRestConnection, 'Get Error', E, FBoatsGetErrorMessage);
//          on E : Exception do
//            FBoatsGetErrorMessage := E.Message;
//        end;
//      finally
//
//      end;
    end
  ) do
    begin
      onTerminate := BoatsRefreshTerminated;
      Start;
    end;
end;

procedure Tfrm_Rental.BoatsRefreshTerminated(Sender: TObject);
begin
//  try
//    if not FBoatsGetErrorMessage.IsEmpty then
//      begin
//        dm_Server.tb_Boat.LoadFromFile;
//        frm_Main.ShowAlert(udm_Server_msg_Refresh_Server_Failed);
//        //TDialogService.ShowMessage(FBoatsGetErrorMessage);
//      end
//    else
//      begin
//        try
//          Assert(TFDJSONDataSetsReader.GetListCount(FBoatsDataSetList) = 1);
//        except
//
//        end;
//        dm_Server.tb_Boat.Active  := False;
//        dm_Server.tb_Boat.AppendData(TFDJSONDataSetsReader.GetListValueByName(FBoatsDataSetList, 'Boat')); // Old method, it works without Presistent File
//        dm_Server.tb_Boat.CancelUpdates; // Clear UpdatesPending Flag
//        dm_Server.tb_Boat.SaveToFile;
//      end;
//  finally
//    dm_Server.CloseSession;
//    RefreshGrid;   // dm_Server.tb_boat.Active  := True;
//    Waiting_Hide;
//  end;
end;

//------------------------------------------------------------------------------
// BASE HANDLE COOMPLEMENT REFRESH
//    RefreshGrid
//    DoFixLayout
//    FixLayoutSize
//------------------------------------------------------------------------------

procedure Tfrm_Rental.DoFixLayoutSize;
begin
  timer_UpdateSize.Interval := 100;
  timer_UpdateSize.Enabled  := True;
end;

procedure Tfrm_Rental.edt_StartMinutesChange(Sender: TObject);
begin
  UpdateStartValue();
end;

procedure Tfrm_Rental.edt_StartPayDiscountChange(Sender: TObject);
begin
  UpdateStartValue();
end;

procedure Tfrm_Rental.timer_UpdateSizeTimer(Sender: TObject);
begin
  timer_UpdateSize.Enabled := False;
  FixLayoutSize;
end;

procedure Tfrm_Rental.layout_BoatsResized(Sender: TObject);
begin
  DoFixLayoutSize;
end;

procedure Tfrm_Rental.RefreshGrid;
begin
  layout_Boats.Controls.Clear;

  dm_Main.tb_Boat.Active  := True;
  layout_Boats.BeginUpdate;
  dm_Main.tb_Boat.First;
  while not dm_Main.tb_Boat.Eof do
    begin
      with Tfrm_Boat.Create ( layout_Boats, TFmxObject(Self)
                            ,             dm_Main.tb_Boat.FieldByName('Number'               ).AsString
                            ,             dm_Main.tb_Boat.FieldByName('Active'               ).AsBoolean
                            , TAlphaColor(dm_Main.tb_Boat.FieldByName('Color'                ).AsLongWord)
                            ,             dm_Main.tb_Boat.FieldByName('DefaultMinutes'       ).AsInteger
                            ,             dm_Main.tb_Boat.FieldByName('DefaultValue'         ).AsInteger
                            ,             dm_Main.tb_Boat.FieldByName('Rented'               ).AsBoolean
                            ,             dm_Main.tb_Boat.FieldByName('RentedAt'             ).AsDateTime
                            ,             dm_Main.tb_Boat.FieldByName('StartPayMethod'       ).AsString
                            ,             dm_Main.tb_Boat.FieldByName('StartPayMinutes'      ).AsInteger
                            ,             dm_Main.tb_Boat.FieldByName('StartPayValue'        ).AsInteger
                            ,             dm_Main.tb_Boat.FieldByName('StartPayValueCard'    ).AsInteger
                            ,             dm_Main.tb_Boat.FieldByName('StartPayValueCash'    ).AsInteger
                            ,             dm_Main.tb_Boat.FieldByName('StartPayValuePix'     ).AsInteger
                            ,             dm_Main.tb_Boat.FieldByName('StartPayValueOther'   ).AsInteger
                            ,             dm_Main.tb_Boat.FieldByName('StartPayValueDiscount').AsInteger
                            ,             dm_Main.tb_Boat.FieldByName('StartObs'             ).AsString
      ) do
        begin
          {$IFDEF MSWINDOWS}
          rect_Background.OnClick := BoatOnClick;
          {$ENDIF}
          {$IFDEF ANDROID}
          rect_Background.OnTap := BoatOnTap;
          //rect_Background.OnClick := BoatOnClick;
          {$ENDIF}
        end;
      dm_Main.tb_Boat.Next;
    end;

  FixLayoutSize;
  layout_Boats.EndUpdate;
end;

procedure Tfrm_Rental.RentStart;
var
  LValueCalc, LValue: Integer;
  LMessage: String;
begin
  // Check auto datetime config
  if not getSettings_AutoTime then
    begin
      TDialogService.ShowMessage(msg_AutoTime_Off);
      Exit;
    end;

  // Undefined Payment Method
  if GetStartPaymentMethod() = '' then
    begin
      TDialogService.MessageDialog('Selecione uma forma de pagamento.', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0, nil);
      Exit;
    end;

  // Check if the discount is greater than the calculated value and fix it if so.
  if StrToIntDef(edt_StartPayDiscount.Text, 0) > CalculateStartValue(StrToIntDef(edt_StartMinutes.Text    , 0)) then
    begin
      edt_StartPayDiscount.Text := IntToStr(CalculateStartValue(StrToIntDef(edt_StartMinutes.Text    , 0)));
    end;

  // Check if it is a multi-payment, but there is a value only on the card payment method.
  if not radio_StartPayCard.IsChecked and (StrToIntDef(edt_StartPayDiscount.Text, 0) = 0) and (StrToIntDef(edt_StartPayCard.Text, 0) = CalculateStartValue(StrToIntDef(edt_StartMinutes.Text    , 0))) then
    begin
      TDialogService.ShowMessage('Use a opção de Cartão para aplicar um pagamento único em cartão.');
      Exit;
    end;

  // Check if it is a multi-payment, but there is a value only on the cash payment method.
  if not radio_StartPayCash.IsChecked and (StrToIntDef(edt_StartPayDiscount.Text, 0) = 0) and  (StrToIntDef(edt_StartPayCash.Text, 0) = CalculateStartValue(StrToIntDef(edt_StartMinutes.Text    , 0))) then
    begin
      TDialogService.ShowMessage('Use a opção de Dinheiro para aplicar um pagamento único em dinheiro.');
      Exit;
    end;

  // Check if it is a multi-payment, but there is a value only on the pix payment method.
  if not radio_StartPayPix.IsChecked and (StrToIntDef(edt_StartPayDiscount.Text, 0) = 0) and  (StrToIntDef(edt_StartPayPix.Text, 0) = CalculateStartValue(StrToIntDef(edt_StartMinutes.Text    , 0))) then
    begin
      TDialogService.ShowMessage('Use a opção de Pix para aplicar um pagamento único com pix.');
      Exit;
    end;

  // Check if it is a multi-payment, but there is a value only on the other payment method.
  if not radio_StartPayOther.IsChecked and (StrToIntDef(edt_StartPayDiscount.Text, 0) = 0) and  (StrToIntDef(edt_StartPayOther.Text, 0) = CalculateStartValue(StrToIntDef(edt_StartMinutes.Text    , 0))) then
    begin
      TDialogService.ShowMessage('Use a opção de Outros para aplicar um pagamento único.');
      Exit;
    end;

  // Check if it is a multi-payment, but there is a value only on the discount.
  if not radio_StartPayDiscount.IsChecked and (StrToIntDef(edt_StartPayDiscount.Text, 0) = CalculateStartValue(StrToIntDef(edt_StartMinutes.Text    , 0))) then
    begin
      TDialogService.ShowMessage('Use a opção de Cortesia para aplicar um desconto de 100%.');
      Exit;
    end;

  // Calculate and compare the value with the sum of the payment methods.
  LValue     :=   StrToIntDef(edt_StartValue.Text      , 0);
  LValueCalc := + StrToIntDef(edt_StartPayCard.Text    , 0)
                + StrToIntDef(edt_StartPayCash.Text    , 0)
                + StrToIntDef(edt_StartPayPix.Text     , 0)
                + StrToIntDef(edt_StartPayOther.Text   , 0);

  // It must match. Otherwise, there is a misinformation.
  if LValue <> LValueCalc then
    begin
      LMessage := 'Soma dos valores no pagamento: '#$D#$A'R$ ' + IntToStr(LValueCalc) + ',00.'#$D#$A#$D#$A;
      LMessage := LMessage + 'O total esperado deve ser de '#$D#$A'R$ ' + IntToStr(LValue) + ',00.'#$D#$A#$D#$A;
      if LValue > LValueCalc then
        LMessage := LMessage + 'Faltam R$ ' + IntToStr(LValue - LValueCalc) + ',00.'
      else
        LMessage := LMessage + 'Sobram R$ ' + IntToStr(LValueCalc - LValue) + ',00.';

      TDialogService.ShowMessage(LMessage);
      Exit;
    end;

//  // Debug  ----------------------------------------------------------
//  TDialogService.ShowMessage(
//                               GetStartPaymentMethod()   + #$A#$D +
//                               edt_StartPayCard.Text     + #$A#$D +
//                               edt_StartPayCash.Text     + #$A#$D +
//                               edt_StartPayPix.Text      + #$A#$D +
//                               edt_StartPayOther.Text    + #$A#$D +
//                               edt_StartPayDiscount.Text + #$A#$D
//                             );
//  Exit;
//  // -----------------------------------------------------------------

  // We are good. So, find the current boat on the table and update it.
  if dm_Main.tb_Boat.Locate('Number', FBoat.FNumber) then
    begin

        dm_Main.tb_Boat.Edit;
        dm_Main.tb_Boat.FieldByName('Rented'               ).AsBoolean  := True;
        dm_Main.tb_Boat.FieldByName('RentedAt'             ).AsDateTime := Now;
        dm_Main.tb_Boat.FieldByName('StartPayMethod'       ).AsString   := GetStartPaymentMethod();
        dm_Main.tb_Boat.FieldByName('StartPayMinutes'      ).AsInteger  := StrToIntDef(edt_StartMinutes.Text    , 0);
        dm_Main.tb_Boat.FieldByName('StartPayValue'        ).AsInteger  := StrToIntDef(edt_StartValue.Text      , 0);
        dm_Main.tb_Boat.FieldByName('StartPayValueCard'    ).AsInteger  := StrToIntDef(edt_StartPayCard.Text    , 0);
        dm_Main.tb_Boat.FieldByName('StartPayValueCash'    ).AsInteger  := StrToIntDef(edt_StartPayCash.Text    , 0);
        dm_Main.tb_Boat.FieldByName('StartPayValuePix'     ).AsInteger  := StrToIntDef(edt_StartPayPix.Text     , 0);
        dm_Main.tb_Boat.FieldByName('StartPayValueOther'   ).AsInteger  := StrToIntDef(edt_StartPayOther.Text   , 0);
        dm_Main.tb_Boat.FieldByName('StartPayValueDiscount').AsInteger  := StrToIntDef(edt_StartPayDiscount.Text, 0);
        dm_Main.tb_Boat.FieldByName('StartObs'             ).AsString   := edt_StartObs.Text;
        dm_Main.tb_Boat.Post;

        FBoat.FRented                := dm_Main.tb_Boat.FieldByName('Rented'               ).AsBoolean;
        FBoat.FRentedAt              := dm_Main.tb_Boat.FieldByName('RentedAt'             ).AsDateTime;
        FBoat.FStartPayMethod        := dm_Main.tb_Boat.FieldByName('StartPayMethod'       ).AsString;
        FBoat.FStartPayMinutes       := dm_Main.tb_Boat.FieldByName('StartPayMinutes'      ).AsInteger;
        FBoat.FStartPayValue         := dm_Main.tb_Boat.FieldByName('StartPayValue'        ).AsInteger;
        FBoat.FStartPayValueCard     := dm_Main.tb_Boat.FieldByName('StartPayValueCard'    ).AsInteger;
        FBoat.FStartPayValueCash     := dm_Main.tb_Boat.FieldByName('StartPayValueCash'    ).AsInteger;
        FBoat.FStartPayValuePix      := dm_Main.tb_Boat.FieldByName('StartPayValuePix'     ).AsInteger;
        FBoat.FStartPayValueOther    := dm_Main.tb_Boat.FieldByName('StartPayValueOther'   ).AsInteger;
        FBoat.FStartPayValueDiscount := dm_Main.tb_Boat.FieldByName('StartPayValueDiscount').AsInteger;
        FBoat.FStartObs              := dm_Main.tb_Boat.FieldByName('StartObs'             ).AsString;

        BoatsRentalApplyUpdates;
        FBoat.Update( Now );

        actTabChange_List.Execute;
        Timer.Enabled := True;

        PrintReceipt;
    end;
end;

procedure Tfrm_Rental.ShowStartPaymentMethodMulti(AShow: Boolean);
begin
  BeginUpdate;

  edt_StartPayCard.Visible     := AShow;
  edt_StartPayCash.Visible     := AShow;
  edt_StartPayPix.Visible      := AShow;
  edt_StartPayOther.Visible    := AShow;
  edt_StartPayDiscount.Visible := AShow;

  radio_StartPayCard.Visible     := not AShow;
  radio_StartPayCash.Visible     := not AShow;
  radio_StartPayPix.Visible      := not AShow;
  radio_StartPayOther.Visible    := not AShow;
  radio_StartPayDiscount.Visible := not AShow;

  edt_StartPayCard.Text     := '';
  edt_StartPayCash.Text     := '';
  edt_StartPayPix.Text      := '';
  edt_StartPayOther.Text    := '';
  edt_StartPayDiscount.Text := '';

  radio_StartPayCard.IsChecked     := False;
  radio_StartPayCash.IsChecked     := False;
  radio_StartPayPix.IsChecked      := False;
  radio_StartPayOther.IsChecked    := False;
  radio_StartPayDiscount.IsChecked := False;

  EndUpdate;
end;

procedure Tfrm_Rental.FixLayoutSize;
begin
  layout_Boats.OnResized := nil;

  if Width > Height then
    begin
      if layout_Boats.ItemHeight <> FBoatSizeLandscape then
        begin
          layout_Boats.BeginUpdate;
          layout_Boats.ItemHeight := FBoatSizeLandscape;
          layout_Boats.ItemWidth  := FBoatSizeLandscape;
          layout_Boats.EndUpdate;
          Application.ProcessMessages;
        end;
    end
  else
    begin
      if layout_Boats.ItemHeight <> FBoatSizePortrait then
        begin
          layout_Boats.BeginUpdate;
          layout_Boats.ItemHeight := FBoatSizePortrait;
          layout_Boats.ItemWidth  := FBoatSizePortrait;
          layout_Boats.EndUpdate;
          Application.ProcessMessages;
        end;
    end;

  if (layout_Boats.Controls.Count <> 0) then
    with Tfrm_Boat(layout_Boats.Controls.Last) do
      begin
        layout_Boats.Height := Trunc(Position.Y) + Trunc(Height) + layout_Boats.Padding.Top +  layout_Boats.Padding.Bottom;
      end;

  layout_Boats.Repaint;

  layout_Boats.OnResized := layout_BoatsResized;
end;



function Tfrm_Rental.GetStartPaymentMethod(): String;
begin
  if switch_StartPayMulti.IsChecked then
    Result := PAYMENT_METHOD_MULTI
  else
    begin
              if radio_StartPayCard.IsChecked     then Result := PAYMENT_METHOD_CARD
         else if radio_StartPayCash.IsChecked     then Result := PAYMENT_METHOD_CASH
         else if radio_StartPayPix.IsChecked      then Result := PAYMENT_METHOD_PIX
         else if radio_StartPayOther.IsChecked    then Result := PAYMENT_METHOD_OTHER
         else if radio_StartPayDiscount.IsChecked then Result := PAYMENT_METHOD_DISCOUNT
    end;
end;

//------------------------------------------------------------------------------
// BUTTONS
//      TabControl Changed -> Handle Buttons Visibility
//      Config
//      Refresh
//      Cancel
//      Boat Click
//------------------------------------------------------------------------------

procedure Tfrm_Rental.btn_ConfigClick(Sender: TObject);
begin
  edt_ConfigSizePortrait.Value  := FBoatSizePortrait;
  edt_ConfigSizeLandscape.Value := FBoatSizeLandscape;

  actTabChange_Config.Execute;
end;

procedure Tfrm_Rental.btn_ConfigSaveClick(Sender: TObject);
var
  LIniConfig : TiniFile;
begin
  LIniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
  try
    FBoatSizePortrait   := Trunc(edt_ConfigSizePortrait .Value);
    FBoatSizeLandscape  := Trunc(edt_ConfigSizeLandscape .Value);
    LIniConfig.WriteInteger ('CLIENT', 'BoatSizePortrait'  , FBoatSizePortrait   );
    LIniConfig.WriteInteger ('CLIENT', 'BoatSizeLandscape' , FBoatSizeLandscape  );
  finally
    LIniConfig.Free;
  end;

  DoFixLayoutSize;

  actTabChange_List.Execute;
end;

procedure Tfrm_Rental.btn_RefreshClick(Sender: TObject);
begin
  BoatsRefresh;
end;

procedure Tfrm_Rental.btn_CancelClick(Sender: TObject);
begin
  BoatsRefresh;
  actTabChange_List.Execute;
end;

procedure Tfrm_Rental.btn_CancelFinishClick(Sender: TObject);
begin
  BoatsRefresh;
  actTabChange_List.Execute;
end;

procedure Tfrm_Rental.BoatOnTap(Sender: TObject; const Point: TPointF);
begin
  BoatOnClick(Sender);
end;

procedure Tfrm_Rental.BoatOnClick(Sender: TObject);
var
  LBoat : Tfrm_Boat;
  LDateFinish  : TDateTime;
  LCalcMinutes, LCalcValue : Integer;

begin
  LBoat := TFrm_Boat(TRectangle(Sender).Parent);

  if not LBoat.FActive then Exit;

  if not LBoat.FRented then
    begin
      Timer.Enabled                    := False;
      FBoat                            := LBoat;
      lbl_SubTitleStart.Text           := LBoat.FNumber;
      edt_StartMinutes.Text            := IntToStr(LBoat.FDefaultMinutes);
      edt_StartValue.Text              := IntToStr(LBoat.FDefaultValue);
      switch_StartPayMulti.IsChecked   := False;
      edt_StartPayCard.Text            := '';
      edt_StartPayCash.Text            := '';
      edt_StartPayPix.Text             := '';
      edt_StartPayOther.Text           := '';
      edt_StartPayDiscount.Text        := '';
      edt_StartObs.Text                := '';
      radio_StartPayCard.IsChecked     := False;
      radio_StartPayCash.IsChecked     := False;
      radio_StartPayPix.IsChecked      := False;
      radio_StartPayOther.IsChecked    := False;
      radio_StartPayDiscount.IsChecked := False;

      ShowStartPaymentMethodMulti(False);

      edt_StartMinutes.SetFocus;
      actTabChange_Start.Execute;
    end
  else
    begin
      Timer.Enabled := False;
      FBoat         := LBoat;
      LDateFinish   := Now;
      LCalcMinutes  := SecondsBetween( LDateFinish, LBoat.FRentedAt);
      LCalcValue    := Round((LBoat.FDefaultValue / LBoat.FDefaultMinutes) * LCalcMinutes);
// TODO---
//      edt_RentFinishStartMinutes.Value := LBoat.FAdvancedPaymentMinutes;
//      edt_RentFinishStartValue.Value   := LBoat.FAdvancedPaymentValue;
//      edt_RentFinishStartDate.Date     := LBoat.FRentedAt;
//      edt_RentFinishStartHour.Time     := LBoat.FRentedAt;
//      lbl_PaymentTypeValue.Text        := GetPaymentType(LBoat.FAdvancedPaymentType);
//      edt_RentFinishCalcMinutes.Value  := LCalcMinutes;
//      edt_RentFinishCalcValue.Value    := LCalcValue;
//      edt_RentFinishMinutes.Value      := LBoat.FAdvancedPaymentMinutes;
//      edt_RentFinishValue.Value        := LBoat.FAdvancedPaymentValue;
//      switch_RentFinishChange.IsChecked := False;
//      lbl_SubTitleFinish.Text           := LBoat.FNumber;
      actTabChange_Finish.Execute;
    end;

end;

//------------------------------------------------------------------------------
// RENTAL
//    Start
//      Track Minute Change
//    Finish
//------------------------------------------------------------------------------

procedure Tfrm_Rental.btn_StartClick(Sender: TObject);
begin





  RentStart();

end;

function  Tfrm_Rental.CalculateStartValue(AMinutes: Integer; Discount: Integer = 0): Integer;
begin
  Result := Round((FBoat.FDefaultValue / FBoat.FDefaultMinutes) * AMinutes) - Discount;
  if Result < 0 then
    Result := 0;
end;

procedure Tfrm_Rental.UpdateStartValue;
var
  LValue : Integer;
begin
  if not switch_StartPayMulti.IsChecked then
    begin
      edt_StartPayCard.Text     := '';
      edt_StartPayCash.Text     := '';
      edt_StartPayPix.Text      := '';
      edt_StartPayOther.Text    := '';

      edt_StartPayDiscount.OnChange := nil;
      edt_StartPayDiscount.Text := '';
      edt_StartPayDiscount.OnChange := edt_StartPayDiscountChange;


      if radio_StartPayDiscount.IsChecked then
        begin
          edt_StartPayDiscount.OnChange := nil;
          edt_StartPayDiscount.Text := IntToStr(CalculateStartValue(StrToIntDef(edt_StartMinutes.Text, 0)));
          edt_StartPayDiscount.OnChange := edt_StartPayDiscountChange;
        end;
      if radio_StartPayCard.IsChecked     then edt_StartPayCard.Text     := IntToStr(CalculateStartValue(StrToIntDef(edt_StartMinutes.Text, 0)));
      if radio_StartPayCash.IsChecked     then edt_StartPayCash.Text     := IntToStr(CalculateStartValue(StrToIntDef(edt_StartMinutes.Text, 0)));
      if radio_StartPayOther.IsChecked    then edt_StartPayOther.Text    := IntToStr(CalculateStartValue(StrToIntDef(edt_StartMinutes.Text, 0)));
      if radio_StartPayPix.IsChecked      then edt_StartPayPix.Text      := IntToStr(CalculateStartValue(StrToIntDef(edt_StartMinutes.Text, 0)));
    end;

  edt_StartValue.Text :=  IntToStr(CalculateStartValue(StrToIntDef(edt_StartMinutes.Text, 0), StrToIntDef(edt_StartPayDiscount.Text, 0)));
end;

procedure Tfrm_Rental.btn_RentFinishClick(Sender: TObject);
begin
  if not getSettings_AutoTime then
    begin
      TDialogService.ShowMessage(msg_AutoTime_Off);
      Exit;
    end;

  if dm_Main.tb_Boat.Locate('Number', FBoat.FNumber) then
    begin
        // Update Boat
        dm_Main.tb_Boat.Edit;
        dm_Main.tb_Boat.FieldByName('Rented'               ).AsBoolean  := False;
        dm_Main.tb_Boat.FieldByName('RentedAt'             ).Clear;
        dm_Main.tb_Boat.FieldByName('StartPayMethod'       ).Clear;
        dm_Main.tb_Boat.FieldByName('StartPayMinutes'     ).Clear;
        dm_Main.tb_Boat.FieldByName('StartPayValue'        ).Clear;
        dm_Main.tb_Boat.FieldByName('StartPayValueCard'    ).Clear;
        dm_Main.tb_Boat.FieldByName('StartPayValueCash'    ).Clear;
        dm_Main.tb_Boat.FieldByName('StartPayValuePix'     ).Clear;
        dm_Main.tb_Boat.FieldByName('StartPayValueOther'   ).Clear;
        dm_Main.tb_Boat.FieldByName('StartPayValueDiscount').Clear;
        dm_Main.tb_Boat.Post;

        // Add Rental Record
        dm_Main.tb_Rental.Open;
        dm_Main.tb_Rental.Append;
        // dm_Main.tb_Rental.FieldByName('Boat_ID'            ).AsInteger  := FBoat.FID;
        dm_Main.tb_Rental.FieldByName('id'                    ).AsGuid     := TUUIDv7Helper.CreateV7;
        dm_Main.tb_Rental.FieldByName('Number'                ).AsString   := FBoat.FNumber;
        dm_Main.tb_Rental.FieldByName('RentedAt'              ).AsDateTime := FBoat.FRentedAt;
        dm_Main.tb_Rental.FieldByName('RentFinishedAt'        ).AsDateTime := Now;
        // TODO ----
//        dm_Main.tb_Rental.FieldByName('AdvancedPaymentValue'  ).AsInteger  := Trunc(edt_RentFinishStartValue.Value);
//        dm_Main.tb_Rental.FieldByName('AdvancedPaymentMinutes').AsInteger  := Trunc(edt_RentFinishStartMinutes.Value);
//        dm_Main.tb_Rental.FieldByName('AdvancedPaymentType'   ).AsString   := SetPaymentType(lbl_PaymentTypeValue.Text);
//        dm_Main.tb_Rental.FieldByName('CalculedPaymentValue'  ).AsInteger  := Trunc(edt_RentFinishCalcValue.Value);
//        dm_Main.tb_Rental.FieldByName('CalculedPaymentMinutes').AsInteger  := Trunc(edt_RentFinishCalcMinutes.Value);
//        dm_Main.tb_Rental.FieldByName('PaymentChanged'        ).AsBoolean  := switch_RentFinishChange.IsChecked;
//        dm_Main.tb_Rental.FieldByName('PaymentValue'          ).AsInteger  := Trunc(edt_RentFinishValue.Value);
//        dm_Main.tb_Rental.FieldByName('PaymentMinutes'        ).AsInteger  := Trunc(edt_RentFinishMinutes.Value);
        dm_Main.tb_Rental.Post;

        // Update local variable
        FBoat.FRented                 := dm_Main.tb_Boat.FieldByName('Rented'                ).AsBoolean;
        //FBoat.FRentedAt               := Now; // Keep last Rent
//        FBoat.FAdvancedPaymentValue   := 0;
//        FBoat.FAdvancedPaymentMinutes := 0;

        // Save to Server
        BoatsRentalApplyUpdates;
        FBoat.Update( Now );

        actTabChange_List.Execute;
        Timer.Enabled := True;
    end;
end;

//------------------------------------------------------------------------------
// GRID SETUP SIZE
//------------------------------------------------------------------------------

procedure Tfrm_Rental.switch_StartPayMultiSwitch(Sender: TObject);
begin
  ShowStartPaymentMethodMulti(switch_StartPayMulti.IsChecked);
end;

procedure Tfrm_Rental.switch_RentFinishChangeSwitch(Sender: TObject);
begin
  edt_RentFinishMinutes.Enabled := switch_RentFinishChange.isChecked;
  edt_RentFinishValue.Enabled   := switch_RentFinishChange.isChecked;

  if switch_RentFinishChange.isChecked then
    begin
      edt_RentFinishMinutes.Text := edt_RentFinishCalcMinutes.Text;
      edt_RentFinishValue.Text   := edt_RentFinishCalcValue.Text;
    end
  else
    begin
      edt_RentFinishMinutes.Text := edt_RentFinishStartMinutes.Text;
      edt_RentFinishValue.Text   := edt_RentFinishStartValue.Text;
    end;
end;

procedure Tfrm_Rental.tabItem_FinishClick(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------
// PRINT
//------------------------------------------------------------------------------

procedure Tfrm_Rental.PrintReceipt;
var
  LSeq, LObs, LDate, LValue, LMin : String;
begin

  if not PRINTER_ENABLE then
    Exit;

  LSeq   := '00' + '     ' + FBoat.FNumber;
  LDate  := 'Data  : '     + FormatDateTime( 'dd/MM/yyyy HH:mm', FBoat.FRentedAt );
  LValue := 'Valor : R$ '  +       IntToStr( FBoat.FStartPayValue         ) + ',00';
  LMin   := 'Tempo : '     +       IntToStr( FBoat.FStartPayMinutes       ) + ' min';
  LObs   := 'R$ 10,00 a cada 10 min excedente';



  BTSendData( EP_INITIALIZE_PRINTER           );
  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH ));
  BTSendData( 'PEDALINHOS KLEIN' + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));
  BTSendData( 'RECIBO' + EP_LF + EP_LF );
  BTSendData( '   Senha     Pedalinho/Boat' + EP_PRINT );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH OR EP_MODE_DOUBLE_HEIGHT OR EP_MODE_EMPHASIZED ));
//BTSendData( '01     G01' + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT  );
  BTSendData( LSeq + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT  );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));
  BTSendData( EP_SELECT_JUSTIFICATION_LEFT  );

  BTSendData( EP_LF );
//BTSendData( 'Data  : 01/01/2019 13:00' + EP_PRINT );
//BTSendData( 'Valor : R$ 30,00'         + EP_PRINT );
//BTSendData( 'Tempo : 30 min'           + EP_PRINT );
  BTSendData( LDate  + EP_PRINT );
  BTSendData( LValue + EP_PRINT );
  BTSendData( LMin   + EP_PRINT );
  BTSendData( EP_LF );

  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );
//BTSendData( 'R$ 10,00 a cada 10 min excedente' + EP_PRINT );
  BTSendData( LObs + EP_PRINT );

  BTSendData(  EP_LF + EP_LF + EP_LF + EP_LF + EP_LF + EP_PRINT );
end;

procedure Tfrm_Rental.radio_StartPayChange(Sender: TObject);
begin
  UpdateStartValue();
end;





//------------------------------------------------------------------------------
// TIMER
//------------------------------------------------------------------------------

procedure Tfrm_Rental.TimerTimer(Sender: TObject);
var
  LIdx  : integer;
  LDate : TDatetime;
begin
  layout_Boats.BeginUpdate;
  LDate := Now;
  for LIdx := 0 to layout_Boats.Controls.Count - 1 do
    begin
      TFrm_Boat(layout_Boats.Controls.Items[LIdx]).Update(LDate);
    end;
  layout_Boats.EndUpdate;
end;

//------------------------------------------------------------------------------
// DESIGN
//------------------------------------------------------------------------------

procedure Tfrm_Rental.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  //
end;

procedure Tfrm_Rental.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  if edt_StartPayCard.IsFocused     then vScroll_Start.ViewportPosition := TPoint.Create(0, 100);
  if edt_StartPayCash.IsFocused     then vScroll_Start.ViewportPosition := TPoint.Create(0, 100);
  if edt_StartPayPix.IsFocused      then vScroll_Start.ViewportPosition := TPoint.Create(0, 100);
  if edt_StartPayOther.IsFocused    then vScroll_Start.ViewportPosition := TPoint.Create(0, 100);
  if edt_StartPayDiscount.IsFocused then vScroll_Start.ViewportPosition := TPoint.Create(0, 100);

  if edt_StartObs.IsFocused         then vScroll_Start.ViewportPosition := TPoint.Create(0, 250);
end;

procedure Tfrm_Rental.rect_StartPayCardClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if switch_StartPayMulti.IsChecked then edt_StartPayCard.SetFocus;
  {$ENDIF}
end;

procedure Tfrm_Rental.rect_StartPayCashClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if switch_StartPayMulti.IsChecked then edt_StartPayCash.SetFocus;
  {$ENDIF}
end;

procedure Tfrm_Rental.rect_StartPayPixClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if switch_StartPayMulti.IsChecked then edt_StartPayPix.SetFocus;
  {$ENDIF}
end;

procedure Tfrm_Rental.rect_StartPayOtherClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if switch_StartPayMulti.IsChecked then edt_StartPayOther.SetFocus;
  {$ENDIF}
end;

procedure Tfrm_Rental.rect_StartPayDiscountClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if switch_StartPayMulti.IsChecked then edt_StartPayDiscount.SetFocus;
  {$ENDIF}
end;


procedure Tfrm_Rental.rect_StartPayCardTap(Sender: TObject;
  const Point: TPointF);
begin
  {$IFDEF ANDROID}
  if switch_StartPayMulti.IsChecked  then edt_StartPayCard.SetFocus;
  {$ENDIF}
end;

procedure Tfrm_Rental.rect_StartPayCashTap(Sender: TObject;
  const Point: TPointF);
begin
  {$IFDEF ANDROID}
  if switch_StartPayMulti.IsChecked  then edt_StartPayCash.SetFocus;
  {$ENDIF}
end;

procedure Tfrm_Rental.rect_StartPayPixTap(Sender: TObject;
  const Point: TPointF);
begin
  {$IFDEF ANDROID}
  if switch_StartPayMulti.IsChecked  then edt_StartPayPix.SetFocus;
  {$ENDIF}
end;

procedure Tfrm_Rental.rect_StartPayOtherTap(Sender: TObject;
  const Point: TPointF);
begin
  {$IFDEF ANDROID}
  if switch_StartPayMulti.IsChecked then edt_StartPayOther.SetFocus;
  {$ENDIF}
end;

procedure Tfrm_Rental.rect_StartPayDiscountTap(Sender: TObject;
  const Point: TPointF);
begin
  {$IFDEF ANDROID}
  if switch_StartPayMulti.IsChecked then edt_StartPayDiscount.SetFocus;
  {$ENDIF}
end;


end.
