unit ufrm_Rental;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects,
  Data.DB, FMX.DialogService, FireDAC.Comp.DataSet,
  FMX.Layouts, FMX.Edit, FMX.Effects, FMX.Controls.Presentation, FMX.TabControl, System.IniFiles,
  ufrm_Boat, System.Actions, FMX.ActnList, FMX.DateTimeCtrls, FMX.EditBox, FMX.NumberBox, System.DateUtils,
  FMX.ListBox, FMX.ScrollBox, FMX.Memo, System.Generics.Collections, FireDAC.Comp.Client,
  FMX.Memo.Types, FMX.Styles.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  Tfrm_Rental = class(TFrame)
    tabCtrl_List: TTabControl;
    tabItem_List: TTabItem;
    toolBar_List: TToolBar;
    shadow_List: TShadowEffect;
    btn_ConfigShow: TSpeedButton;
    path_ConfigShow: TPath;
    tabItem_Start: TTabItem;
    toolBar_Start: TToolBar;
    shadow_Start: TShadowEffect;
    btn_StartBack: TSpeedButton;
    layout_List: TGridLayout;
    VertScrollBox1: TVertScrollBox;
    timer_ListUpdateSize: TTimer;
    vScroll_Start: TVertScrollBox;
    layoutFlow_Start: TFlowLayout;
    layout_Start: TLayout;
    btn_Start: TButton;
    ActionList: TActionList;
    actTabChange_Start: TChangeTabAction;
    actTabChange_Finish: TChangeTabAction;
    actTabChange_List: TChangeTabAction;
    lbl_StartSubTitle: TLabel;
    timer_List: TTimer;
    btn_ListRefresh: TSpeedButton;
    tabItem_Config: TTabItem;
    toolBar_Config: TToolBar;
    shadow_Config: TShadowEffect;
    btn_ConfigBack: TSpeedButton;
    lbl_ConfigSubTitle: TLabel;
    vScrollBox_Config: TVertScrollBox;
    layoutFlow_Config: TFlowLayout;
    layout_Config: TLayout;
    btn_ConfigSave: TButton;
    actTabChange_Config: TChangeTabAction;
    path_StartBoat: TPath;
    actTabChange_MultiPay: TChangeTabAction;
    edt_StartObs: TEdit;
    switch_StartPayMulti: TSwitch;
    lbl_StartPayMulti: TLabel;
    radio_StartPayCard: TRadioButton;
    lbl_StartPay: TLabel;
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
    rect_StartPay: TRectangle;
    tabItem_EndPay: TTabItem;
    vScroll_EndPay: TVertScrollBox;
    layoutFlow_EndPay: TFlowLayout;
    layout_EndPay: TLayout;
    btn_EndPay: TButton;
    edt_EndObs: TEdit;
    edt_EndPayValue: TEdit;
    lbl_EndPayValueT: TLabel;
    lbl_EndPayValueC: TLabel;
    lbl_EndPayValueR: TLabel;
    edt_EndPayMinutes: TEdit;
    lbl_EndPayMinutesT: TLabel;
    lbl_EndPayMinutesC: TLabel;
    rect_EndPay: TRectangle;
    lbl_EndPay: TLabel;
    switch_EndPayMulti: TSwitch;
    lbl_EndPayMulti: TLabel;
    rect_EndPayCard: TRoundRect;
    radio_EndPayCard: TRadioButton;
    edt_EndPayCard: TEdit;
    lbl_EndPayCardT: TLabel;
    lbl_EndPayCardC: TLabel;
    lbl_EndPayCardR: TLabel;
    rect_EndPayCash: TRoundRect;
    radio_EndPayCash: TRadioButton;
    edt_EndPayCash: TEdit;
    lbl_EndPayCashT: TLabel;
    lbl_EndPayCashC: TLabel;
    lbl_EndPayCashR: TLabel;
    rect_EndPayDiscount: TRoundRect;
    radio_EndPayDiscount: TRadioButton;
    edt_EndPayDiscount: TEdit;
    lbl_EndPayDiscountT: TLabel;
    lbl_EndPayDiscountC: TLabel;
    lbl_EndPayDiscountR: TLabel;
    rect_EndPayOther: TRoundRect;
    radio_EndPayOther: TRadioButton;
    edt_EndPayOther: TEdit;
    lbl_EndPayOtherT: TLabel;
    lbl_EndPayOtherC: TLabel;
    lbl_EndPayOtherR: TLabel;
    rect_EndPayPix: TRoundRect;
    radio_EndPayPix: TRadioButton;
    edt_EndPayPix: TEdit;
    lbl_EndPayPixT: TLabel;
    lbl_EndPayPixC: TLabel;
    lbl_EndPayPixR: TLabel;
    toolBar_EndPay: TToolBar;
    lbl_EndPaySubTitle: TLabel;
    path_EndPayBoat: TPath;
    btn_EndPayBack: TSpeedButton;
    shadow_EndPay: TShadowEffect;
    actTabChange_End: TChangeTabAction;
    edt_ConfigSizePortrait: TEdit;
    lbl_ConfigSizePortraitT: TLabel;
    lbl_ConfigSizePortraitC: TLabel;
    edt_ConfigSizeLandscape: TEdit;
    lbl_ConfigSizeLandscapeT: TLabel;
    lbl_ConfigSizeLandscapeC: TLabel;
    tabitem_End: TTabItem;
    vScroll_End: TVertScrollBox;
    layoutFlow_End: TFlowLayout;
    layout_End: TLayout;
    btn_End: TButton;
    edt_EndMinutes: TEdit;
    lbl_EndMinutesT: TLabel;
    lbl_EndMinutesC: TLabel;
    rect_End: TRectangle;
    toolBar_End: TToolBar;
    lbl_EndSubTitle: TLabel;
    path_EndBoat: TPath;
    btn_EndBack: TSpeedButton;
    shadow_End: TShadowEffect;
    actTabChange_EndPay: TChangeTabAction;
    btn_EndResume: TButton;
    btn_EndShowStartInfo: TButton;
    lbl_ListSubTitle: TLabel;
    tabItem_PoS: TTabItem;
    lst_PoS: TListView;
    toolBar_PoS: TToolBar;
    shadow_PoS: TShadowEffect;
    btn_PoSBack: TSpeedButton;
    lbl_PoSSubTitle: TLabel;
    actTabChange_PoS: TChangeTabAction;
    lbl_EndPoST: TLabel;
    lbl_EndSequentialT: TLabel;
    lbl_EndStartedAtT: TLabel;
    lbl_EndSequential: TLabel;
    lbl_EndPoS: TLabel;
    lbl_EndStartedAt: TLabel;
    tabItem_Receipt: TTabItem;
    toolBar_Receipt: TToolBar;
    lbl_ReceiptSubTitle: TLabel;
    path_ReceiptBoat: TPath;
    btn_ReceiptBack: TSpeedButton;
    shadow_Receipt: TShadowEffect;
    vscroll_Receipt: TVertScrollBox;
    layoutFlow_Receipt: TFlowLayout;
    layout_Receipt: TLayout;
    lbl_Receipt01: TLabel;
    lbl_Receipt02: TLabel;
    lbl_Receipt03: TLabel;
    lbl_Receipt04: TLabel;
    lbl_Receipt05: TLabel;
    lbl_Receipt06: TLabel;
    lbl_Receipt07: TLabel;
    lbl_Receipt08: TLabel;
    lbl_Receipt09: TLabel;
    btn_ReceiptPrint: TButton;
    lbl_Receipt10: TLabel;
    actTabChange_Receipt: TChangeTabAction;
    rect_Receipt: TRectangle;
    procedure layout_ListResized(Sender: TObject);
    procedure btn_ConfigShowClick(Sender: TObject);
    procedure timer_ListUpdateSizeTimer(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure timer_ListTimer(Sender: TObject);
    procedure btn_StartBackClick(Sender: TObject);
    procedure btn_ListRefreshClick(Sender: TObject);
    procedure btn_ConfigSaveClick(Sender: TObject);
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
    procedure btn_EndPayBackClick(Sender: TObject);
    procedure btn_EndBackClick(Sender: TObject);
    procedure btn_EndClick(Sender: TObject);
    procedure btn_EndPayClick(Sender: TObject);
    procedure btn_EndResumeClick(Sender: TObject);
    procedure btn_EndShowStartInfoClick(Sender: TObject);
    procedure edt_EndPayDiscountChange(Sender: TObject);
    procedure radio_EndPayChange(Sender: TObject);
    procedure edt_EndPayMinutesChange(Sender: TObject);
    procedure switch_EndPayMultiSwitch(Sender: TObject);
    procedure lbl_ListSubTitleClick(Sender: TObject);
    procedure btn_PoSBackClick(Sender: TObject);
    procedure lst_PoSItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btn_ReceiptPrintClick(Sender: TObject);
    procedure btn_ReceiptBackClick(Sender: TObject);
    procedure btn_ConfigBackClick(Sender: TObject);
  private
    { Private declarations }
    FBoat                         : Tfrm_Boat;
    FPoSID                        : TGuid;
    FPoSName                      : String;

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
    procedure PoSRefresh;
    procedure BoatsRefreshTerminated(Sender: TObject);
    // BASIC HANDLER COMPLEMENT: Refresh
    procedure ListRefresh;
    procedure ListFixLayoutSize;
    procedure ListDoFixLayoutSize;
    procedure ReceiptPrint;
    procedure ReceiptShow;
    procedure BoatOnClick(Sender: TObject);
    procedure BoatOnTap(Sender: TObject; const Point: TPointF);
    procedure RentStart();
    procedure RentEnd();
    procedure ShowStartPaymentMethodMulti(AShow: Boolean);
    procedure ShowEndPaymentMethodMulti(AShow: Boolean);
    function GetStartPaymentMethod(): String;
    function GetEndPaymentMethod(): String;
    procedure UpdateStartValue();
    procedure UpdateEndValue();
    function  CalculateStartValue(AMinutes: Integer; Discount: Integer = 0): Integer;
    function  CalculateEndValue(AMinutes: Integer; Discount: Integer = 0): Integer;

    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown (Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);

    procedure UpdateEnd();

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
  udm_Main, ufrm_Boats, ufrm_Main, unt_VSoftUUIDv7, ufrm_PoS;

//------------------------------------------------------------------------------
// BASE HANDLE
//      Prepare
//      ApplyUpdates
//      Refresh
//------------------------------------------------------------------------------

(*******************************************************************************

procedure Tfrm_Rental.CornerButton1Paint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  Canvas.Fill.Color := TAlphaColors.Cornflowerblue;
end;



procedure Tfrm_Rental.btn_CancelFinishClick(Sender: TObject);
begin
  BoatsRefresh;
  actTabChange_List.Execute;
end;


procedure Tfrm_Rental.btn_RentFinishClick(Sender: TObject);
begin
  if not getSettings_AutoTime then
    begin
      TDialogService.ShowMessage(msg_AutoTime_Off);
      Exit;
    end;

  dm_Main.tb_Boat.Active   := false;
  dm_Main.tb_Boat.Filtered := false;
  dm_Main.tb_Boat.LoadFromFile();
  dm_Main.tb_Boat.Active   := true;

  dm_Main.tb_Rental.Active   := false;
  dm_Main.tb_Rental.Filtered := false;
  dm_Main.tb_Rental.LoadFromFile();
  dm_Main.tb_Rental.Active   := true;
  try
    if not dm_Main.tb_Boat.Locate('id', GUIDToString(FBoat.FID)) then Exit;

    // Update Boat
    dm_Main.tb_Boat.Edit;
    dm_Main.tb_Boat.FieldByName('Rented'               ).AsBoolean  := False;
    dm_Main.tb_Boat.FieldByName('RentStarAt'           ).Clear;
    dm_Main.tb_Boat.FieldByName('RentEndAt'            ).Clear;
    dm_Main.tb_Boat.FieldByName('StartPayMinutes'      ).Clear;
    dm_Main.tb_Boat.FieldByName('StartPayValue'        ).Clear;
    dm_Main.tb_Boat.FieldByName('StartPayMethod'       ).Clear;
    dm_Main.tb_Boat.FieldByName('StartPayValueCard'    ).Clear;
    dm_Main.tb_Boat.FieldByName('StartPayValueCash'    ).Clear;
    dm_Main.tb_Boat.FieldByName('StartPayValuePix'     ).Clear;
    dm_Main.tb_Boat.FieldByName('StartPayValueOther'   ).Clear;
    dm_Main.tb_Boat.FieldByName('StartPayValueDiscount').Clear;
    dm_Main.tb_Boat.FieldByName('StartObs'             ).Clear;
    dm_Main.tb_Boat.Post;

    FBoat.FRented                 := dm_Main.tb_Boat.FieldByName('Rented'                ).AsBoolean;

    // Add Rental Record
    dm_Main.tb_Rental.Append;
    // dm_Main.tb_Rental.FieldByName('Boat_ID'            ).AsInteger  := FBoat.FID;
    dm_Main.tb_Rental.FieldByName('id'                    ).AsGuid     := TUUIDv7Helper.CreateV7;
    dm_Main.tb_Rental.FieldByName('BoatID'                ).AsGuid     := FBoat.FID;
    dm_Main.tb_Rental.FieldByName('BoatNumber'            ).AsString   := FBoat.FNumber;
    dm_Main.tb_Rental.FieldByName('StartAt'               ).AsDateTime := FBoat.FRentStartAt;
    dm_Main.tb_Rental.FieldByName('EndAt'                 ).AsDateTime := FBoat.FRentEndAt;

    dm_Main.tb_Rental.Post;

    // Update local variable
    dm_Main.tb_Boat.SaveToFile();
    dm_Main.tb_Rental.SaveToFile();

    FBoat.Update( Now );

    actTabChange_List.Execute;
    timer_List.Enabled := True;
  finally
    dm_Main.tb_Boat.Active     := false;
    dm_Main.tb_Rental.Active   := false;
  end;
end;

********************************************************************************)

procedure Tfrm_Rental.Prepare;
var
  LIniConfig : TiniFile;
begin
  FPoSID   := PoSID;
  FPoSName := PoSName;

  tabCtrl_List.ActiveTab := tabItem_List;

  LIniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
  try
    FBoatSizePortrait   := LIniConfig.ReadInteger(FPoSID.ToString(), 'BoatSizePortrait'  , 100);
    FBoatSizeLandscape  := LIniConfig.ReadInteger(FPoSID.ToString(), 'BoatSizeLandscape' , 100);
  finally
    LIniConfig.Free;
  end;

  BoatsRefresh();
end;


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

  if edt_EndPayCard.IsFocused     then vScroll_EndPay.ViewportPosition := TPoint.Create(0, 100);
  if edt_EndPayCash.IsFocused     then vScroll_EndPay.ViewportPosition := TPoint.Create(0, 100);
  if edt_EndPayPix.IsFocused      then vScroll_EndPay.ViewportPosition := TPoint.Create(0, 100);
  if edt_EndPayOther.IsFocused    then vScroll_EndPay.ViewportPosition := TPoint.Create(0, 100);
  if edt_EndPayDiscount.IsFocused then vScroll_EndPay.ViewportPosition := TPoint.Create(0, 100);

  if edt_EndObs.IsFocused         then vScroll_EndPay.ViewportPosition := TPoint.Create(0, 250);
end;


procedure Tfrm_Rental.BoatsRentalApplyUpdates;
var
//  ADeltaList: TFDJSONDeltas;
  LIndex       : Integer;
//  Table : TFDMemTable;
begin
//  if dm_Main.tb_Boat.State   in dsEditModes then dm_Main.tb_Boat.Post;
//  if dm_Main.tb_Rental.State in dsEditModes then dm_Main.tb_Rental.Post;
//  if dm_Main.tb_PoS.State    in dsEditModes then dm_Main.tb_PoS.Post;

  if frm_Main.Sync = ssOffline then
    begin
//      dm_Main.tb_Boat.SaveToFile();
//      dm_Main.tb_Rental.SaveToFile();
//      dm_Main.tb_PoS.SaveToFile();

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
      ListRefresh();
      Waiting_Hide;
      Exit;
    end;

  if dm_Main.tb_Boat.UpdatesPending or dm_Main.tb_Rental.UpdatesPending  then
    begin
      ListRefresh();
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

// ********************************************************************************************************************
// LIST
// ********************************************************************************************************************

procedure Tfrm_Rental.lbl_ListSubTitleClick(Sender: TObject);
begin
  if PoSAdmin then
    begin
      PoSRefresh;
      actTabChange_PoS.Execute;
    end;
end;

procedure Tfrm_Rental.btn_ListRefreshClick(Sender: TObject);
begin
  BoatsRefresh;
end;

// -----------------------------------------------------------------------------

procedure Tfrm_Rental.timer_ListTimer(Sender: TObject);
var
  LIdx  : integer;
  LDate : TDatetime;
begin
  layout_List.BeginUpdate;
  LDate := Now;
  for LIdx := 0 to layout_List.Controls.Count - 1 do
    begin
      TFrm_Boat(layout_List.Controls.Items[LIdx]).Update(LDate);
    end;

  if Assigned(FBoat) and (tabCtrl_List.ActiveTab = tabitem_End) then UpdateEnd();

  layout_List.EndUpdate;
end;

procedure Tfrm_Rental.layout_ListResized(Sender: TObject);
begin
  ListDoFixLayoutSize;
end;

procedure Tfrm_Rental.ListDoFixLayoutSize;
begin
  timer_ListUpdateSize.Interval := 100;
  timer_ListUpdateSize.Enabled  := True;
end;

procedure Tfrm_Rental.timer_ListUpdateSizeTimer(Sender: TObject);
begin
  timer_ListUpdateSize.Enabled := False;
  ListFixLayoutSize;
end;

procedure Tfrm_Rental.ListFixLayoutSize;
begin
  layout_List.OnResized := nil;

  if Width > Height then
    begin
      if layout_List.ItemHeight <> FBoatSizeLandscape then
        begin
          layout_List.BeginUpdate;
          layout_List.ItemHeight := FBoatSizeLandscape;
          layout_List.ItemWidth  := FBoatSizeLandscape;
          layout_List.EndUpdate;
          Application.ProcessMessages;
        end;
    end
  else
    begin
      if layout_List.ItemHeight <> FBoatSizePortrait then
        begin
          layout_List.BeginUpdate;
          layout_List.ItemHeight := FBoatSizePortrait;
          layout_List.ItemWidth  := FBoatSizePortrait;
          layout_List.EndUpdate;
          Application.ProcessMessages;
        end;
    end;

  if (layout_List.Controls.Count <> 0) then
    with Tfrm_Boat(layout_List.Controls.Last) do
      begin
        layout_List.Height := Trunc(Position.Y) + Trunc(Height) + layout_List.Padding.Top +  layout_List.Padding.Bottom;
      end;

  layout_List.Repaint;

  layout_List.OnResized := layout_ListResized;
end;

// -----------------------------------------------------------------------------
// LIST
// -----------------------------------------------------------------------------

procedure Tfrm_Rental.ListRefresh();
begin
  lbl_ListSubTitle.Text        := FPoSName;


  dm_Main.tb_Boat.Filtered := False;
  if FPoSID <> POS_NONE then
    begin
      dm_Main.tb_Boat.Filter   := 'posId = '+ QuotedStr(GUIDToString(FPoSID)) ;
      dm_Main.tb_Boat.Filtered := true;
    end;
  layout_List.BeginUpdate;
  try
    layout_List.Controls.Clear;
    dm_Main.tb_Boat.First;
    while not dm_Main.tb_Boat.Eof do
      begin
        var LPoSName := '';
        if dm_Main.tb_PoS.Locate('id', GuidToString(dm_Main.tb_Boat.FieldByName('posId').AsGuid)) then
          begin
            LPoSName := dm_Main.tb_PoS.FieldByName('name').AsString;
          end;

        with Tfrm_Boat.Create ( layout_List, TFmxObject(Self)
                              ,             dm_Main.tb_Boat.FieldByName('id'                    ).AsGuid
                              ,             dm_Main.tb_Boat.FieldByName('number'                ).AsString
                              ,             dm_Main.tb_Boat.FieldByName('active'                ).AsBoolean
                              , TAlphaColor(dm_Main.tb_Boat.FieldByName('color'                 ).AsLongWord)
                              ,             dm_Main.tb_Boat.FieldByName('defaultMinutes'        ).AsInteger
                              ,             dm_Main.tb_Boat.FieldByName('defaultValue'          ).AsInteger
                              ,             dm_Main.tb_Boat.FieldByName('defaultExtraMinutes'   ).AsInteger
                              ,             dm_Main.tb_Boat.FieldByName('defaultExtraValue'     ).AsInteger
                              ,             dm_Main.tb_Boat.FieldByName('posId'                 ).AsGuid
                              ,             dm_Main.tb_Boat.FieldByName('rented'                ).AsBoolean
                              ,             dm_Main.tb_Boat.FieldByName('cashRegisterId'        ).AsString
                              ,             dm_Main.tb_Boat.FieldByName('rentedSince'           ).AsDateTime
                              ,             dm_Main.tb_Boat.FieldByName('rentalPausedAt'        ).AsDateTime
                              ,             dm_Main.tb_Boat.FieldByName('rentalId'              ).AsGuid
                              ,             dm_Main.tb_Boat.FieldByName('rentalExpectedMinutes' ).AsInteger
                              ,             dm_Main.tb_Boat.FieldByName('rentalToleranceMinutes').AsInteger
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

  finally
    ListFixLayoutSize;
    layout_List.EndUpdate;
    dm_Main.tb_Boat.Filtered := False;
  end;
end;

procedure Tfrm_Rental.BoatOnTap(Sender: TObject; const Point: TPointF);
begin
  BoatOnClick(Sender);
end;

procedure Tfrm_Rental.BoatOnClick(Sender: TObject);
var
  LBoat        : Tfrm_Boat;
  LDateFinish  : TDateTime;
  LCalcMinutes,
  LCalcValue   : Integer;
  LMessage     : String;

begin
  LBoat := TFrm_Boat(TRectangle(Sender).Parent);

  if not LBoat.FActive then
    begin
      TDialogService.ShowMessage('O pedalinho não está desativado.');
      Exit;
    end;

  if not LBoat.FRented then
    begin
      dm_Main.tb_PoS.Filtered          := false;
      dm_Main.tb_CashRegister.Filtered := False;
      try
        if not dm_Main.tb_PoS.Locate('id', GUIDToString(LBoat.FPoSID)) then
         begin
           TDialogService.ShowMessage('O pedalinho não esta associado a um Ponto de Venda.');
           Exit;
         end;

        if not dm_Main.tb_PoS.FieldByName('active').AsBoolean then
          begin
            LMessage := 'O Ponto de Venda "' + dm_Main.tb_PoS.FieldByName('name').AsString + '" está inativado.';
            TDialogService.ShowMessage(LMessage);
            Exit;
          end;

        if not dm_Main.tb_CashRegister.Locate('posId;open', VarArrayOf([GUIDToString(LBoat.FPoSID), True])) then
          begin
            LMessage := 'O Ponto de Venda "' + dm_Main.tb_PoS.FieldByName('name').AsString + '" está com o caixa fechado.';
            TDialogService.ShowMessage(LMessage);
            Exit;
          end;

      finally
        dm_Main.tb_PoS.Filtered          := false;
        dm_Main.tb_CashRegister.Filtered := False;
      end;

      timer_List.Enabled               := False;
      FBoat                            := LBoat;

      edt_StartMinutes.Enabled         := true;
      edt_StartValue.Enabled           := true;
      radio_StartPayCard.Enabled       := true;
      radio_StartPayCash.Enabled       := true;
      radio_StartPayPix.Enabled        := true;
      radio_StartPayOther.Enabled      := true;
      radio_StartPayDiscount.Enabled   := true;
      switch_StartPayMulti.Enabled     := true;
      edt_StartPayCard.Enabled         := true;
      edt_StartPayCash.Enabled         := true;
      edt_StartPayPix.Enabled          := true;
      edt_StartPayOther.Enabled        := true;
      edt_StartPayDiscount.Enabled     := true;
      edt_StartObs.Enabled             := true;
      btn_Start.Text                   := 'INICIAR';

      lbl_StartSubTitle.Text           := LBoat.FNumber;
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
      lbl_EndSubTitle.Text        := LBoat.FNumber;

      if not dm_Main.tb_Boat.Locate('id', GUIDToString(LBoat.FID)) then
       begin
         TDialogService.ShowMessage(UNEXPECTED_ERROR + 'BoatOnClick.tb_Boat.Locate');
         Exit;
       end;

      if not dm_Main.tb_Rental.Locate('id', GUIDToString(LBoat.FRentalID)) then
       begin
         TDialogService.ShowMessage(UNEXPECTED_ERROR + 'BoatOnClick.tb_Rental.Locate');
         Exit;
       end;

      //Timer.Enabled := False;
      FBoat         := LBoat;
      lbl_EndSequential.Text := Format('%0.2d', [dm_Main.tb_Rental.FieldByName('cashRegisterCount').AsInteger]);
      lbl_EndPoS.Text        := dm_Main.tb_Rental.FieldByName('posName').AsString + #$D'(' + FormatDateTime( 'yyMMdd', dm_Main.tb_Rental.FieldByName('cashRegisterDate').AsDateTime ) + ')';
      lbl_EndStartedAt.Text  := FormatDateTime( 'dd/MM/yyyy HH:mm', dm_Main.tb_Rental.FieldByName('startAt').AsDateTime );

      UpdateEnd();


      actTabChange_End.Execute;
    end;

end;


procedure Tfrm_Rental.UpdateEnd;
var
  LMinutes: Integer;
begin
  if not Assigned(FBoat) then Exit;

  if not FBoat.FRented then Exit;


  LMinutes := FBoat.FRentalExpectedMinutes - FBoat.FMinutes;

  btn_EndResume.Visible := FBoat.FRentalPausedAt <> 0;

  if LMinutes > 0 then
    begin
      lbl_EndMinutesT.Text := 'Tempo Restante: ';

      // Set color to none
//      rect_End.Fill.Kind   := TBrushKind.None;
      rect_End.Fill.Color  := (FBoat.rect_Background.Fill.Color and $00FFFFFF) or $99000000;

      edt_EndMinutes.Text  := IntToStr(LMinutes);
      btn_End.Text         := 'FINALIZAR';
    end
  else
    begin
      lbl_EndMinutesT.Text := 'Tempo Excedente: ';

      // Set color using the boat background, but with alpha = 33%.333% ($55 / $FF)
//      rect_End.Fill.Kind   := TBrushKind.Solid;
      rect_End.Fill.Color  := (FBoat.rect_Background.Fill.Color and $00FFFFFF) or $99000000;

      // Use the absolute value
      LMinutes := Abs(LMinutes);
      edt_EndMinutes.Text  := IntToStr(LMinutes);

      if LMinutes < FBoat.FRentalToleranceMinutes then
        btn_End.Text         := 'FINALIZAR'
      else if FBoat.FRentalPausedAt = 0 then
        btn_End.Text         := 'FINALIZAR e PAGAR'
      else
          btn_End.Text       := 'PAGAR';
    end;
end;


// ********************************************************************************************************************
// CONFIG
// ********************************************************************************************************************

procedure Tfrm_Rental.btn_ConfigBackClick(Sender: TObject);
begin
  BoatsRefresh;
  actTabChange_List.Execute;
end;

procedure Tfrm_Rental.btn_ConfigShowClick(Sender: TObject);
begin
  edt_ConfigSizePortrait.Text  := IntToStr(FBoatSizePortrait);
  edt_ConfigSizeLandscape.Text := IntToStr(FBoatSizeLandscape);

  actTabChange_Config.Execute;
end;

procedure Tfrm_Rental.btn_ConfigSaveClick(Sender: TObject);
var
  LIniConfig : TiniFile;
begin
  LIniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
  try
    FBoatSizePortrait   := StrToIntDef(edt_ConfigSizePortrait.Text , 0);
    FBoatSizeLandscape  := StrToIntDef(edt_ConfigSizeLandscape.Text, 0);
    LIniConfig.WriteInteger (FPoSID.ToString(), 'BoatSizePortrait'  , FBoatSizePortrait   );
    LIniConfig.WriteInteger (FPoSID.ToString(), 'BoatSizeLandscape' , FBoatSizeLandscape  );
  finally
    LIniConfig.Free;
  end;

  ListDoFixLayoutSize;

  actTabChange_List.Execute;
end;

// ********************************************************************************************************************
// POS
// ********************************************************************************************************************

procedure Tfrm_Rental.btn_PoSBackClick(Sender: TObject);
begin
  BoatsRefresh;
  actTabChange_List.Execute;
end;

procedure Tfrm_Rental.PoSRefresh;
var
  LItem : TListViewItem;
begin
  dm_Main.tb_PoS.Filtered := false;
  lst_PoS.Items.BeginUpdate;
  try
    lst_PoS.Items.Clear;

    LItem           := lst_PoS.Items.Add;
    LItem.TagString := GUIDToString(POS_NONE);
    LItem.Objects.FindDrawable('txtName').Data := 'Todos';

    dm_Main.tb_PoS.First;
    while not dm_Main.tb_PoS.Eof do
      begin
        LItem           := lst_PoS.Items.Add;
        LItem.TagString := GuidToString(dm_Main.tb_PoS.FieldByName('id').AsGuid);

        LItem.Objects.FindDrawable('txtName').Data := dm_Main.tb_PoS.FieldByName('name'  ).AsString;
        if dm_Main.tb_PoS.FieldByName('active').AsBoolean then
          LItem.Objects.FindDrawable('txtActive').Data := '🔵'
        else
          LItem.Objects.FindDrawable('txtActive').Data := '⚫';

        dm_Main.tb_PoS.Next;
      end;

  finally
    lst_PoS.Items.EndUpdate;
    dm_Main.tb_PoS.Filtered := false;
  end;
end;

procedure Tfrm_Rental.lst_PoSItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LIniConfig : TiniFile;
begin
  if not PoSAdmin then Exit;

  if AItem.TagString = GUIDToString(POS_NONE) then
    begin
      FPoSID     :=  POS_NONE;
      FPoSName   := 'Todos';
    end
  else
    begin
      dm_Main.tb_PoS.Filtered := False;
      try
        if not dm_Main.tb_PoS.Locate('id', AItem.TagString) then
          begin
            TDialogService.ShowMessage(UNEXPECTED_ERROR + 'lst_PoSItemClick.tb_PoS.Locate');
            Exit;
          end;

        FPoSID     := dm_Main.tb_PoS.FieldByName('id'    ).AsGuid;
        FPoSName   := dm_Main.tb_PoS.FieldByName('name'  ).AsString;
      finally
        dm_Main.tb_PoS.Filtered := False;
      end;
    end;


  LIniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
  try
    FBoatSizePortrait   := LIniConfig.ReadInteger(FPoSID.ToString(), 'BoatSizePortrait'  , 100);
    FBoatSizeLandscape  := LIniConfig.ReadInteger(FPoSID.ToString(), 'BoatSizeLandscape' , 100);
  finally
    LIniConfig.Free;
  end;

  ListDoFixLayoutSize;

  BoatsRefresh;
  actTabChange_List.Execute;
end;

// ********************************************************************************************************************
//  RECEIPT
// ********************************************************************************************************************

procedure Tfrm_Rental.ReceiptShow;
var
  LSeq, LObs, LPoS, LDate, LValue, LMin : String;
  LRentCount       : Integer;
  LRentPoSName     : String;
  LRentDate        : TDateTime;
  LRentStartAt     : TDateTime;
  LStartPayValue   : Integer;
  LStartPayMinutes : Integer;
  LExtraValue      : Integer;
  LExtraMinutes    : Integer;

begin
  if not dm_Main.tb_Boat.Locate('id', GUIDToString(FBoat.FID)) then
   begin
     TDialogService.ShowMessage(UNEXPECTED_ERROR + 'ReceiptShow.tb_Boat.Locate');
     Exit;
   end;

  if not dm_Main.tb_Rental.Locate('id', GUIDToString(FBoat.FRentalID)) then
   begin
     TDialogService.ShowMessage(UNEXPECTED_ERROR + 'ReceiptShow.tb_Rental.Locate');
     Exit;
   end;

  LRentCount       := dm_Main.tb_Rental.FieldByName('cashRegisterCount').AsInteger;
  LRentPoSName     := dm_Main.tb_Rental.FieldByName('posName'          ).AsString;
  LRentDate        := dm_Main.tb_Rental.FieldByName('cashRegisterDate' ).AsDateTime;
  LRentStartAt     := dm_Main.tb_Rental.FieldByName('startAt'          ).AsDateTime;
  LStartPayValue   := dm_Main.tb_Rental.FieldByName('startPayValue'    ).AsInteger;
  LStartPayMinutes := dm_Main.tb_Rental.FieldByName('startPayMinutes'  ).AsInteger;
  LExtraValue      := dm_Main.tb_Rental.FieldByName('extraValue'       ).AsInteger;
  LExtraMinutes    := dm_Main.tb_Rental.FieldByName('extraMinutes'     ).AsInteger;

  LSeq   := Format('%.2d', [LRentCount]) + '     ' + FBoat.FNumber;
  LPoS   := 'Ponto : ' + LRentPoSName + ' (' + FormatDateTime( 'yyMMdd', LRentDate ) + ')';
  LDate  := 'Data  : '     + FormatDateTime( 'dd/MM/yyyy HH:mm', LRentStartAt );
  LValue := 'Valor : R$ '  +       IntToStr( LStartPayValue         ) + ',00';
  LMin   := 'Tempo : '     +       IntToStr( LStartPayMinutes       ) + ' min';
  LObs   := 'R$ ' + IntToStr(LExtraValue) + ',00 a cada ' + IntToStr(LExtraMinutes) + ' min excedente';


  lbl_ReceiptSubTitle.Text := FBoat.FNumber;

  lbl_Receipt04.Text := LSeq;
  lbl_Receipt06.Text := LPoS;
  lbl_Receipt07.Text := LDate;
  lbl_Receipt08.Text := LValue;
  lbl_Receipt09.Text := LMin;
  lbl_Receipt10.Text := LObs;

  actTabChange_Receipt.Execute;
end;

procedure Tfrm_Rental.btn_ReceiptBackClick(Sender: TObject);
begin
  actTabChange_Start.Execute;
end;

procedure Tfrm_Rental.btn_ReceiptPrintClick(Sender: TObject);
begin
  ReceiptPrint;
end;

procedure Tfrm_Rental.ReceiptPrint;
var
  LSeq, LObs, LPoS, LDate, LValue, LMin : String;
  LRentCount       : Integer;
  LRentPoSName     : String;
  LRentDate        : TDateTime;
  LRentStartAt     : TDateTime;
  LStartPayValue   : Integer;
  LStartPayMinutes : Integer;
  LExtraValue      : Integer;
  LExtraMinutes    : Integer;
begin

  if not PRINTER_ENABLE then
    Exit;

  if not dm_Main.tb_Boat.Locate('id', GUIDToString(FBoat.FID)) then
   begin
     TDialogService.ShowMessage(UNEXPECTED_ERROR + 'ReceiptPrint.tb_Boat.Locate');
     Exit;
   end;

  if not dm_Main.tb_Rental.Locate('id', GUIDToString(FBoat.FRentalID)) then
   begin
     TDialogService.ShowMessage(UNEXPECTED_ERROR + 'ReceiptPrint.tb_Rental.Locate');
     Exit;
   end;

  LRentCount       := dm_Main.tb_Rental.FieldByName('cashRegisterCount').AsInteger;
  LRentPoSName     := dm_Main.tb_Rental.FieldByName('posName'          ).AsString;
  LRentDate        := dm_Main.tb_Rental.FieldByName('cashRegisterDate' ).AsDateTime;
  LRentStartAt     := dm_Main.tb_Rental.FieldByName('startAt'          ).AsDateTime;
  LStartPayValue   := dm_Main.tb_Rental.FieldByName('startPayValue'    ).AsInteger;
  LStartPayMinutes := dm_Main.tb_Rental.FieldByName('startPayMinutes'  ).AsInteger;
  LExtraValue      := dm_Main.tb_Rental.FieldByName('extraValue'       ).AsInteger;
  LExtraMinutes    := dm_Main.tb_Rental.FieldByName('extraMinutes'     ).AsInteger;

  LSeq   := Format('%.2d', [LRentCount]) + '     ' + FBoat.FNumber;
  LPoS   := 'Ponto : ' + LRentPoSName + ' (' + FormatDateTime( 'yyMMdd', LRentDate ) + ')';
  LDate  := 'Data  : '     + FormatDateTime( 'dd/MM/yyyy HH:mm', LRentStartAt );
  LValue := 'Valor : R$ '  +       IntToStr( LStartPayValue         ) + ',00';
  LMin   := 'Tempo : '     +       IntToStr( LStartPayMinutes       ) + ' min';
  LObs   := 'R$ ' + IntToStr(LExtraValue) + ',00 a cada ' + IntToStr(LExtraMinutes) + ' min excedente';


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
//  BTSendData( 'Ponto : 1234567890123456789012345678901234567890'  + EP_PRINT );
  BTSendData( LPoS   + EP_PRINT );
  BTSendData( LDate  + EP_PRINT );
  BTSendData( LValue + EP_PRINT );
  BTSendData( LMin   + EP_PRINT );
  BTSendData( EP_LF );

  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );
//BTSendData( 'R$ 10,00 a cada 10 min excedente' + EP_PRINT );
  BTSendData( LObs + EP_PRINT );

  BTSendData(  EP_LF + EP_LF + EP_LF + EP_LF + EP_LF + EP_PRINT );
end;



// ********************************************************************************************************************
//  START
// ********************************************************************************************************************

procedure Tfrm_Rental.btn_StartClick(Sender: TObject);
begin
  if FBoat.FRented then
    ReceiptShow
  else
    RentStart();
end;

procedure Tfrm_Rental.btn_StartBackClick(Sender: TObject);
begin
  if Assigned(FBoat) and FBoat.FRented then
    begin
      actTabChange_End.Execute;
    end
  else
    begin
      BoatsRefresh;
      actTabChange_List.Execute;
    end;
end;

procedure Tfrm_Rental.switch_StartPayMultiSwitch(Sender: TObject);
begin
  ShowStartPaymentMethodMulti(switch_StartPayMulti.IsChecked);
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

procedure Tfrm_Rental.edt_StartMinutesChange(Sender: TObject);
begin
  UpdateStartValue();
end;

procedure Tfrm_Rental.edt_StartPayDiscountChange(Sender: TObject);
begin
  UpdateStartValue();
end;

procedure Tfrm_Rental.radio_StartPayChange(Sender: TObject);
begin
  UpdateStartValue();
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


function  Tfrm_Rental.CalculateStartValue(AMinutes: Integer; Discount: Integer = 0): Integer;
begin
  if not Assigned(FBoat) then Exit;

  if FBoat.FDefaultMinutes = 0 then Exit;

  Result := Round((FBoat.FDefaultValue / FBoat.FDefaultMinutes) * AMinutes) - Discount;
  if Result < 0 then
    Result := 0;
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



// ********************************************************************************************************************
//  END
// ********************************************************************************************************************

procedure Tfrm_Rental.btn_EndBackClick(Sender: TObject);
begin
  BoatsRefresh;
  actTabChange_List.Execute;
end;

procedure Tfrm_Rental.btn_EndShowStartInfoClick(Sender: TObject);
begin
  if not dm_Main.tb_Boat.Locate('id', GUIDToString(FBoat.FID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'btn_EndShowStartInfoClick.tb_Boat.Locate');
      Exit;
    end;

  if not dm_Main.tb_Rental.Locate('id', GUIDToString(FBoat.FRentalID)) then
   begin
     TDialogService.ShowMessage(UNEXPECTED_ERROR + 'btn_EndShowStartInfoClick.tb_Rental.Locate');
     Exit;
   end;

  edt_StartMinutes.Enabled         := false;
  edt_StartValue.Enabled           := false;
  radio_StartPayCard.Enabled       := false;
  radio_StartPayCash.Enabled       := false;
  radio_StartPayPix.Enabled        := false;
  radio_StartPayOther.Enabled      := false;
  radio_StartPayDiscount.Enabled   := false;
  switch_StartPayMulti.Enabled     := false;
  edt_StartPayCard.Enabled         := false;
  edt_StartPayCash.Enabled         := false;
  edt_StartPayPix.Enabled          := false;
  edt_StartPayOther.Enabled        := false;
  edt_StartPayDiscount.Enabled     := false;
  edt_StartObs.Enabled             := false;
  btn_Start.Text                   := '📄 VER RECIBO';

  ShowStartPaymentMethodMulti(dm_Main.tb_Rental.FieldByName('startPayMethod').AsString = PAYMENT_METHOD_MULTI);

  lbl_StartSubTitle.Text           := FBoat.FNumber;
  edt_StartMinutes.Text            := IntToStr(dm_Main.tb_Rental.FieldByName('startPayMinutes'      ).AsInteger);
  edt_StartValue.Text              := IntToStr(dm_Main.tb_Rental.FieldByName('startPayValue'        ).AsInteger);
  edt_StartPayCard.Text            := IntToStr(dm_Main.tb_Rental.FieldByName('startPayValueCard'    ).AsInteger);
  edt_StartPayCash.Text            := IntToStr(dm_Main.tb_Rental.FieldByName('startPayValueCash'    ).AsInteger);
  edt_StartPayPix.Text             := IntToStr(dm_Main.tb_Rental.FieldByName('startPayValuePix'     ).AsInteger);
  edt_StartPayOther.Text           := IntToStr(dm_Main.tb_Rental.FieldByName('startPayValueOther'   ).AsInteger);
  edt_StartPayDiscount.Text        := IntToStr(dm_Main.tb_Rental.FieldByName('startPayValueDiscount').AsInteger);
  edt_StartObs.Text                := dm_Main.tb_Rental.FieldByName('obs'           ).AsString;
  switch_StartPayMulti.IsChecked   := dm_Main.tb_Rental.FieldByName('startPayMethod').AsString = PAYMENT_METHOD_MULTI;
  radio_StartPayCard.IsChecked     := dm_Main.tb_Rental.FieldByName('startPayMethod').AsString = PAYMENT_METHOD_CARD;
  radio_StartPayCash.IsChecked     := dm_Main.tb_Rental.FieldByName('startPayMethod').AsString = PAYMENT_METHOD_CASH;
  radio_StartPayPix.IsChecked      := dm_Main.tb_Rental.FieldByName('startPayMethod').AsString = PAYMENT_METHOD_PIX;
  radio_StartPayOther.IsChecked    := dm_Main.tb_Rental.FieldByName('startPayMethod').AsString = PAYMENT_METHOD_OTHER;
  radio_StartPayDiscount.IsChecked := dm_Main.tb_Rental.FieldByName('startPayMethod').AsString = PAYMENT_METHOD_DISCOUNT;


  edt_StartMinutes.SetFocus;


  actTabChange_Start.Execute;
end;

procedure Tfrm_Rental.btn_EndResumeClick(Sender: TObject);
begin
  if FBoat.FRentalPausedAt = 0 then
    Exit;

  dm_Main.tb_Boat.Filtered   := false;
  dm_Main.tb_Rental.Filtered := false;

  if not dm_Main.tb_Boat.Locate('id', GUIDToString(FBoat.FID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'btn_EndResumeClick.tb_Boat.Locate');
      Exit;
    end;

  if not dm_Main.tb_Rental.Locate('id', GUIDToString(FBoat.FRentalID)) then
   begin
     TDialogService.ShowMessage(UNEXPECTED_ERROR + 'btn_EndResumeClick.tb_Rental.Locate');
     Exit;
   end;

  try
    FBoat.FRentalPausedAt := 0;

    dm_Main.tb_Boat.Edit;
    dm_Main.tb_Boat.FieldByName('rentalPausedAt').AsDateTime := FBoat.FRentalPausedAt;
    dm_Main.tb_Boat.Post;

    dm_Main.tb_Rental.SaveToFile();
    dm_Main.tb_Boat.SaveToFile();

    FBoat.Update(Now);
    UpdateEnd();
  finally

  end;
end;

procedure Tfrm_Rental.btn_EndClick(Sender: TObject);
var
  LMinutes, LValue : Integer;
begin

  dm_Main.tb_Boat.Filtered   := false;
  dm_Main.tb_Rental.Filtered := false;

  if not dm_Main.tb_Boat.Locate('id', GUIDToString(FBoat.FID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'btn_EndClick.tb_Boat.Locate');
      Exit;
    end;

  if not dm_Main.tb_Rental.Locate('id', GUIDToString(FBoat.FRentalID)) then
   begin
     TDialogService.ShowMessage(UNEXPECTED_ERROR + 'btn_EndClick.tb_Rental.Locate');
     Exit;
   end;

  if FBoat.FRentalPausedAt = 0 then
    begin
      FBoat.FRentalPausedAt := Now;

      dm_Main.tb_Boat.Edit;
      dm_Main.tb_Boat.FieldByName('rentalPausedAt').AsDateTime := FBoat.FRentalPausedAt;
      dm_Main.tb_Boat.Post;
    end;

  FBoat.FMinutes := BoatMinutesBetween(FBoat.FRentedSince, FBoat.FRentalPausedAt);
  LMinutes       := FBoat.FRentalExpectedMinutes - Integer(FBoat.FMinutes);

  // Check if there are still minutes remaining or if you are still in the grace period
  if LMinutes > -FBoat.FRentalToleranceMinutes then
    begin
      // No extra payment, only finish it
      RentEnd();
    end
  else
    begin
      // There should be an extra payment
      LMinutes := Abs(LMinutes);
      LValue   := CalculateEndValue(LMinutes);

      lbl_EndPaySubTitle.Text        := FBoat.FNumber;
      edt_EndPayMinutes.Text         := IntToStr(LMinutes);
      edt_EndPayValue.Text           := IntToStr(LValue  );
      edt_EndObs.Text                := dm_Main.tb_Rental.FieldByName('obs').AsString;
      switch_EndPayMulti.IsChecked   := False;
      edt_EndPayCard.Text            := '';
      edt_EndPayCash.Text            := '';
      edt_EndPayPix.Text             := '';
      edt_EndPayOther.Text           := '';
      edt_EndPayDiscount.Text        := '';
      radio_EndPayCard.IsChecked     := False;
      radio_EndPayCash.IsChecked     := False;
      radio_EndPayPix.IsChecked      := False;
      radio_EndPayOther.IsChecked    := False;
      radio_EndPayDiscount.IsChecked := False;

      ShowEndPaymentMethodMulti(False);

      actTabChange_EndPay.Execute;

    end;

end;


// ********************************************************************************************************************
//  END PAY
// ********************************************************************************************************************


procedure Tfrm_Rental.btn_EndPayBackClick(Sender: TObject);
begin
  actTabChange_End.Execute;
end;

procedure Tfrm_Rental.btn_EndPayClick(Sender: TObject);
begin
  RentEnd();
end;

procedure Tfrm_Rental.switch_EndPayMultiSwitch(Sender: TObject);
begin
  ShowEndPaymentMethodMulti(switch_EndPayMulti.IsChecked);
end;


procedure Tfrm_Rental.ShowEndPaymentMethodMulti(AShow: Boolean);
begin
  BeginUpdate;

  edt_EndPayCard.Visible     := AShow;
  edt_EndPayCash.Visible     := AShow;
  edt_EndPayPix.Visible      := AShow;
  edt_EndPayOther.Visible    := AShow;
  edt_EndPayDiscount.Visible := AShow;

  radio_EndPayCard.Visible     := not AShow;
  radio_EndPayCash.Visible     := not AShow;
  radio_EndPayPix.Visible      := not AShow;
  radio_EndPayOther.Visible    := not AShow;
  radio_EndPayDiscount.Visible := not AShow;

  edt_EndPayCard.Text     := '';
  edt_EndPayCash.Text     := '';
  edt_EndPayPix.Text      := '';
  edt_EndPayOther.Text    := '';
  edt_EndPayDiscount.Text := '';

  radio_EndPayCard.IsChecked     := False;
  radio_EndPayCash.IsChecked     := False;
  radio_EndPayPix.IsChecked      := False;
  radio_EndPayOther.IsChecked    := False;
  radio_EndPayDiscount.IsChecked := False;

  EndUpdate;
end;

procedure Tfrm_Rental.radio_EndPayChange(Sender: TObject);
begin
  UpdateEndValue();
end;

procedure Tfrm_Rental.edt_EndPayMinutesChange(Sender: TObject);
begin
  UpdateEndValue();
end;

procedure Tfrm_Rental.edt_EndPayDiscountChange(Sender: TObject);
begin
  UpdateEndValue();
end;

procedure Tfrm_Rental.UpdateEndValue;
var
  LValue : Integer;
begin
  if not switch_EndPayMulti.IsChecked then
    begin
      edt_EndPayCard.Text     := '';
      edt_EndPayCash.Text     := '';
      edt_EndPayPix.Text      := '';
      edt_EndPayOther.Text    := '';

      edt_EndPayDiscount.OnChange := nil;
      edt_EndPayDiscount.Text     := '';
      edt_EndPayDiscount.OnChange := edt_EndPayDiscountChange;


      if radio_EndPayDiscount.IsChecked then
        begin
          edt_EndPayDiscount.OnChange := nil;
          edt_EndPayDiscount.Text     := IntToStr(CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text, 0)));
          edt_EndPayDiscount.OnChange := edt_EndPayDiscountChange;
        end;
      if radio_EndPayCard.IsChecked     then edt_EndPayCard.Text     := IntToStr(CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text, 0)));
      if radio_EndPayCash.IsChecked     then edt_EndPayCash.Text     := IntToStr(CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text, 0)));
      if radio_EndPayOther.IsChecked    then edt_EndPayOther.Text    := IntToStr(CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text, 0)));
      if radio_EndPayPix.IsChecked      then edt_EndPayPix.Text      := IntToStr(CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text, 0)));
    end;

  edt_EndPayValue.Text :=  IntToStr(CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text, 0), StrToIntDef(edt_EndPayDiscount.Text, 0)));

end;


function  Tfrm_Rental.CalculateEndValue(AMinutes: Integer; Discount: Integer = 0): Integer;
begin
  Result := (Trunc(AMinutes / FBoat.FDefaultExtraMinutes) * FBoat.FDefaultExtraValue) - Discount;
  if Result < 0 then
    Result := 0;
end;



// ********************************************************************************************************************
// RentStart
// ********************************************************************************************************************

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

procedure Tfrm_Rental.RentStart;
var
  LValueCalc, LValue: Integer;
  LDate   : TDate;
  LCount : Integer;
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

  dm_Main.tb_Boat.Filtered         := false;
  dm_Main.tb_PoS.Filtered          := false;
  dm_Main.tb_CashRegister.Filtered := False;
  dm_Main.tb_Rental.Filtered       := False;
  try
    if not dm_Main.tb_Boat.Locate('id', GUIDToString(FBoat.FID)) then
      begin
        TDialogService.ShowMessage(UNEXPECTED_ERROR + 'ReceiptShow.tb_Boat.Locate');
        Exit;
      end;

    if not dm_Main.tb_PoS.Locate('id', GUIDToString(FBoat.FPoSID)) then
      begin
        TDialogService.ShowMessage('O pedalinho não esta associado a um Ponto de Venda.');
        Exit;
      end;

    if not dm_Main.tb_PoS.FieldByName('active').AsBoolean then
      begin
        LMessage := 'O Ponto de Venda "' + dm_Main.tb_PoS.FieldByName('name').AsString + '" está inativado.';
        TDialogService.ShowMessage(LMessage);
        Exit;
      end;

    if not dm_Main.tb_CashRegister.Locate('posId;open', VarArrayOf([GUIDToString(FBoat.FPoSID), True])) then
      begin
        LMessage := 'O Ponto de Venda "' + dm_Main.tb_PoS.FieldByName('name').AsString + '" está com o caixa fechado.';
        TDialogService.ShowMessage(LMessage);
        Exit;
      end;

    LCount := dm_Main.tb_CashRegister.FieldByName('count').AsInteger + 1;

    dm_Main.tb_CashRegister.Edit;
    dm_Main.tb_CashRegister.FieldByName('count').AsInteger := LCount;
    dm_Main.tb_CashRegister.Post;

    dm_Main.tb_Rental.Append;
    dm_Main.tb_Rental.FieldByName('id'                    ).AsGuid     := TUUIDv7Helper.CreateV7;
    dm_Main.tb_Rental.FieldByName('boatId'                ).AsGuid     := FBoat.FID;
    dm_Main.tb_Rental.FieldByName('boatNumber'            ).AsString   := FBoat.FNumber;
    dm_Main.tb_Rental.FieldByName('posId'                 ).AsGuid     := FBoat.FPoSID;
    dm_Main.tb_Rental.FieldByName('posName'               ).AsString   := dm_Main.tb_PoS.FieldByName('name').AsString;
    dm_Main.tb_Rental.FieldByName('cashRegisterDate'      ).AsDateTime := dm_Main.tb_CashRegister.FieldByName('date' ).AsDateTime;
    dm_Main.tb_Rental.FieldByName('cashRegisterId'        ).AsString   := dm_Main.tb_CashRegister.FieldByName('id'   ).AsString;
    dm_Main.tb_Rental.FieldByName('cashRegisterCount'     ).AsInteger  := LCount;
    dm_Main.tb_Rental.FieldByName('startAt'               ).AsDateTime := Now;
    dm_Main.tb_Rental.FieldByName('startPayMinutes'       ).AsInteger  := StrToIntDef(edt_StartMinutes.Text    , 0);
    dm_Main.tb_Rental.FieldByName('startPayValue'         ).AsInteger  := StrToIntDef(edt_StartValue.Text      , 0);
    dm_Main.tb_Rental.FieldByName('startPayMethod'        ).AsString   := GetStartPaymentMethod();
    dm_Main.tb_Rental.FieldByName('startPayValueCard'     ).AsInteger  := StrToIntDef(edt_StartPayCard.Text    , 0);
    dm_Main.tb_Rental.FieldByName('startPayValueCash'     ).AsInteger  := StrToIntDef(edt_StartPayCash.Text    , 0);
    dm_Main.tb_Rental.FieldByName('startPayValuePix'      ).AsInteger  := StrToIntDef(edt_StartPayPix.Text     , 0);
    dm_Main.tb_Rental.FieldByName('startPayValueOther'    ).AsInteger  := StrToIntDef(edt_StartPayOther.Text   , 0);
    dm_Main.tb_Rental.FieldByName('startPayValueDiscount' ).AsInteger  := StrToIntDef(edt_StartPayDiscount.Text, 0);
    dm_Main.tb_Rental.FieldByName('obs'                   ).AsString   := edt_StartObs.Text;
    dm_Main.tb_Rental.FieldByName('extraMinutes'          ).AsInteger  := dm_Main.tb_Boat.FieldByName('defaultExtraMinutes').AsInteger;
    dm_Main.tb_Rental.FieldByName('extraValue'            ).AsInteger  := dm_Main.tb_Boat.FieldByName('defaultExtraValue'  ).AsInteger;
    dm_Main.tb_Rental.Post;

    dm_Main.tb_Boat.Edit;
    dm_Main.tb_Boat.FieldByName('rented'                ).AsBoolean  := True;
    dm_Main.tb_Boat.FieldByName('cashRegisterId'        ).AsString   := dm_Main.tb_Rental.FieldByName('cashRegisterId'        ).AsString;
    dm_Main.tb_Boat.FieldByName('rentedSince'           ).AsDateTime := dm_Main.tb_Rental.FieldByName('startAt'               ).AsDateTime;
    dm_Main.tb_Boat.FieldByName('rentalPausedAt'        ).Clear;
    dm_Main.tb_Boat.FieldByName('rentalId'              ).AsGuid     := dm_Main.tb_Rental.FieldByName('id'                    ).AsGuid;
    dm_Main.tb_Boat.FieldByName('rentalExpectedMinutes' ).AsInteger  := dm_Main.tb_Rental.FieldByName('startPayMinutes'       ).AsInteger;
    dm_Main.tb_Boat.FieldByName('rentalToleranceMinutes').AsInteger  := dm_Main.tb_Rental.FieldByName('extraMinutes'          ).AsInteger;
    dm_Main.tb_Boat.Post;

    FBoat.FRented                 := dm_Main.tb_Boat.FieldByName('rented'                ).AsBoolean;
    FBoat.FCashRegisterId         := dm_Main.tb_Boat.FieldByName('cashRegisterId'        ).AsString;
    FBoat.FRentedSince            := dm_Main.tb_Boat.FieldByName('rentedSince'           ).AsDateTime;
    FBoat.FRentalPausedAt         := dm_Main.tb_Boat.FieldByName('rentalPausedAt'        ).AsDateTime;
    FBoat.FRentalId               := dm_Main.tb_Boat.FieldByName('rentalId'              ).AsGuid;
    FBoat.FRentalExpectedMinutes  := dm_Main.tb_Boat.FieldByName('rentalExpectedMinutes' ).AsInteger;
    FBoat.FRentalToleranceMinutes := dm_Main.tb_Boat.FieldByName('rentalToleranceMinutes').AsInteger;

    dm_Main.tb_CashRegister.SaveToFile();
    dm_Main.tb_Rental.SaveToFile();
    dm_Main.tb_Boat.SaveToFile();

    FBoat.Update( Now );

    actTabChange_List.Execute;
    timer_List.Enabled := True;

    ReceiptPrint;

  finally

  end;
end;

// ********************************************************************************************************************
// RentEnd
// ********************************************************************************************************************

function Tfrm_Rental.GetEndPaymentMethod(): String;
begin
  if switch_EndPayMulti.IsChecked then
    Result := PAYMENT_METHOD_MULTI
  else
    begin
              if radio_EndPayCard.IsChecked     then Result := PAYMENT_METHOD_CARD
         else if radio_EndPayCash.IsChecked     then Result := PAYMENT_METHOD_CASH
         else if radio_EndPayPix.IsChecked      then Result := PAYMENT_METHOD_PIX
         else if radio_EndPayOther.IsChecked    then Result := PAYMENT_METHOD_OTHER
         else if radio_EndPayDiscount.IsChecked then Result := PAYMENT_METHOD_DISCOUNT
    end;
end;

procedure Tfrm_Rental.RentEnd;
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


  // if we are in the payment page, check the info
  if tabCtrl_List.ActiveTab = tabItem_EndPay then
    begin
      // Undefined Payment Method
      if GetEndPaymentMethod() = '' then
        begin
          TDialogService.MessageDialog('Selecione uma forma de pagamento.', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0, nil);
          Exit;
        end;

      // Check if the discount is greater than the calculated value and fix it if so.
      if StrToIntDef(edt_EndPayDiscount.Text, 0) > CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text    , 0)) then
        begin
          edt_EndPayDiscount.Text := IntToStr(CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text    , 0)));
        end;

      // Check if it is a multi-payment, but there is a value only on the card payment method.
      if not radio_EndPayCard.IsChecked and (StrToIntDef(edt_EndPayDiscount.Text, 0) = 0) and (StrToIntDef(edt_EndPayCard.Text, 0) = CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text    , 0))) then
        begin
          TDialogService.ShowMessage('Use a opção de Cartão para aplicar um pagamento único em cartão.');
          Exit;
        end;

      // Check if it is a multi-payment, but there is a value only on the cash payment method.
      if not radio_EndPayCash.IsChecked and (StrToIntDef(edt_EndPayDiscount.Text, 0) = 0) and  (StrToIntDef(edt_EndPayCash.Text, 0) = CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text    , 0))) then
        begin
          TDialogService.ShowMessage('Use a opção de Dinheiro para aplicar um pagamento único em dinheiro.');
          Exit;
        end;

      // Check if it is a multi-payment, but there is a value only on the pix payment method.
      if not radio_EndPayPix.IsChecked and (StrToIntDef(edt_EndPayDiscount.Text, 0) = 0) and  (StrToIntDef(edt_EndPayPix.Text, 0) = CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text    , 0))) then
        begin
          TDialogService.ShowMessage('Use a opção de Pix para aplicar um pagamento único com pix.');
          Exit;
        end;

      // Check if it is a multi-payment, but there is a value only on the other payment method.
      if not radio_EndPayOther.IsChecked and (StrToIntDef(edt_EndPayDiscount.Text, 0) = 0) and  (StrToIntDef(edt_EndPayOther.Text, 0) = CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text    , 0))) then
        begin
          TDialogService.ShowMessage('Use a opção de Outros para aplicar um pagamento único.');
          Exit;
        end;

      // Check if it is a multi-payment, but there is a value only on the discount.
      if not radio_EndPayDiscount.IsChecked and (StrToIntDef(edt_EndPayDiscount.Text, 0) = CalculateEndValue(StrToIntDef(edt_EndPayMinutes.Text    , 0))) then
        begin
          TDialogService.ShowMessage('Use a opção de Cortesia para aplicar um desconto de 100%.');
          Exit;
        end;

      // Calculate and compare the value with the sum of the payment methods.
      LValue     :=   StrToIntDef(edt_EndPayValue.Text   , 0);
      LValueCalc := + StrToIntDef(edt_EndPayCard.Text    , 0)
                    + StrToIntDef(edt_EndPayCash.Text    , 0)
                    + StrToIntDef(edt_EndPayPix.Text     , 0)
                    + StrToIntDef(edt_EndPayOther.Text   , 0);

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

//      // Debug  ----------------------------------------------------------
//      TDialogService.ShowMessage(
//                                   GetEndPaymentMethod()   + #$A#$D +
//                                   edt_EndPayCard.Text     + #$A#$D +
//                                   edt_EndPayCash.Text     + #$A#$D +
//                                   edt_EndPayPix.Text      + #$A#$D +
//                                   edt_EndPayOther.Text    + #$A#$D +
//                                   edt_EndPayDiscount.Text + #$A#$D
//                                 );
//      // -----------------------------------------------------------------
  end;

  // We are good. So, find the current boat on the table and update it.
  dm_Main.tb_Boat.Filtered   := false;
  dm_Main.tb_Rental.Filtered := false;

  if not dm_Main.tb_Boat.Locate('id', GUIDToString(FBoat.FID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'btn_EndClick.tb_Boat.Locate');
      Exit;
    end;

  if not dm_Main.tb_Rental.Locate('id', GUIDToString(FBoat.FRentalID)) then
   begin
     TDialogService.ShowMessage(UNEXPECTED_ERROR + 'btn_EndClick.tb_Rental.Locate');
     Exit;
   end;

  try
    dm_Main.tb_Rental.Edit;
    dm_Main.tb_Rental.FieldByName('endAt').AsDateTime := FBoat.FRentalPausedAt;
    if tabCtrl_List.ActiveTab = tabItem_EndPay then
      begin
        dm_Main.tb_Rental.FieldByName('endPayMinutes'       ).AsInteger  := StrToIntDef(edt_EndPayMinutes.Text , 0);
        dm_Main.tb_Rental.FieldByName('endPayValue'         ).AsInteger  := StrToIntDef(edt_EndPayValue.Text   , 0);
        dm_Main.tb_Rental.FieldByName('endPayMethod'        ).AsString   := GetEndPaymentMethod();
        dm_Main.tb_Rental.FieldByName('endPayValueCash'     ).AsInteger  := StrToIntDef(edt_EndPayCash.Text    , 0);
        dm_Main.tb_Rental.FieldByName('endPayValueCard'     ).AsInteger  := StrToIntDef(edt_EndPayCard.Text    , 0);
        dm_Main.tb_Rental.FieldByName('endPayValuePix'      ).AsInteger  := StrToIntDef(edt_EndPayPix.Text     , 0);
        dm_Main.tb_Rental.FieldByName('endPayValueOther'    ).AsInteger  := StrToIntDef(edt_EndPayOther.Text   , 0);
        dm_Main.tb_Rental.FieldByName('endPayValueDiscount' ).AsInteger  := StrToIntDef(edt_EndPayDiscount.Text, 0);
        dm_Main.tb_Rental.FieldByName('obs'                 ).AsString   := edt_EndObs.Text;
      end;
    dm_Main.tb_Rental.Post;

    // Update Boat
    dm_Main.tb_Boat.Edit;
    dm_Main.tb_Boat.FieldByName('rented'                ).AsBoolean  := False;
    dm_Main.tb_Boat.FieldByName('cashRegisterId'        ).Clear;
    dm_Main.tb_Boat.FieldByName('rentedSince'           ).Clear;
    dm_Main.tb_Boat.FieldByName('rentalPausedAt'        ).Clear;
    dm_Main.tb_Boat.FieldByName('rentalId'              ).Clear;
    dm_Main.tb_Boat.FieldByName('rentalExpectedMinutes' ).Clear;
    dm_Main.tb_Boat.FieldByName('rentaltoleranceMinutes').Clear;
    dm_Main.tb_Boat.Post;

    if not dm_Main.tb_Boat.FieldByName('rented').AsBoolean then FBoat.ResetRent();

    dm_Main.tb_Rental.SaveToFile();
    dm_Main.tb_Boat.SaveToFile();
  finally

  end;

  FBoat.Update( Now );
  actTabChange_List.Execute;
  timer_List.Enabled := True;
end;

// ********************************************************************************************************************
//
// ********************************************************************************************************************



end.
