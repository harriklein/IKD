unit ufrm_PoS;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  Data.DB, FMX.DialogService, FireDAC.Comp.DataSet,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Edit, FMX.Objects, FMX.Effects,
  FMX.Controls.Presentation, FMX.ListView, FMX.TabControl, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  System.Actions, FMX.ActnList, FMX.ListBox, FMX.Colors, FMX.EditBox,    System.DateUtils,
  FMX.NumberBox, FMX.Layouts, FMX.DateTimeCtrls, FMX.Memo.Types, FMX.ScrollBox,  System.Generics.Collections,
  FMX.Memo, FMX.Calendar;

const
  POS_NONE     : TGUID  = '{00000000-0000-0000-0000-000000000000}';


type
  Tfrm_PoS = class(TFrame)
    tabCtrl_List: TTabControl;
    tabItem_PoSList: TTabItem;
    lst_PoS: TListView;
    toolBar_List: TToolBar;
    shadow_List: TShadowEffect;
    btn_PoSAdd: TSpeedButton;
    path_PoSAdd: TPath;
    tabItem_PoSEdit: TTabItem;
    toolBar_Edit: TToolBar;
    shadow_Edit: TShadowEffect;
    btn_PoSSave: TSpeedButton;
    path_PoSSave: TPath;
    btn_PoSCancel: TSpeedButton;
    path_PoSCancel: TPath;
    btn_PoSDelete: TSpeedButton;
    switch_PoSActive: TSwitch;
    lbl_PoSActive: TLabel;
    vScrollBox_Edit: TVertScrollBox;
    layoutFlow_Edit: TFlowLayout;
    layout_Edit: TLayout;
    edt_PoSName: TEdit;
    lbl_PoSName: TLabel;
    lbl_PoSID: TLabel;
    tabItem_CashRegister: TTabItem;
    vscroll_CashRegister: TVertScrollBox;
    layoutFlow_CashRegister: TFlowLayout;
    layout_CashRegister: TLayout;
    V: TRectangle;
    rect_SummaryDayCount: TRectangle;
    lbl_SummaryDayCountTitle: TLabel;
    lbl_SummaryCount: TLabel;
    ActionList1: TActionList;
    actTabChange_PoSList: TChangeTabAction;
    actTabChange_PosEdit: TChangeTabAction;
    actTabChange_CashRegister: TChangeTabAction;
    rect_SummaryDayOpen: TRectangle;
    lbl_SummaryDayOpenTitle: TLabel;
    lbl_SummaryDayOpen: TLabel;
    rect_SummaryExpenses: TRectangle;
    rect_Expenses: TRectangle;
    lbl_ExpensesTitle: TLabel;
    lbl_ExpensesRS: TLabel;
    lbl_Expenses: TLabel;
    shadow_SummaryDay: TShadowEffect;
    shadow_SummaryExpenses: TShadowEffect;
    rect_ExpensesOther: TRectangle;
    lbl_ExpensesOtherTitle: TLabel;
    lbl_ExpensesOtherRS: TLabel;
    lbl_ExpensesOther: TLabel;
    rect_ExpensesDaily: TRectangle;
    lbl_ExpensesDailyTitle: TLabel;
    lbl_ExpensesDailyRS: TLabel;
    rect_ExpensesFuel: TRectangle;
    lbl_ExpensesFuelTitle: TLabel;
    lbl_ExpensesFuelRS: TLabel;
    lbl_ExpensesFuel: TLabel;
    btn_ExpensesFuel: TCornerButton;
    btn_ExpensesDaily: TCornerButton;
    btn_ExpensesOther: TCornerButton;
    lbl_ExpensesDaily: TLabel;
    toolBar_CashRegister: TToolBar;
    lbl_CashRegisterMainTitle: TLabel;
    btn_CashRegisterBack: TSpeedButton;
    btn_PoSEdit: TSpeedButton;
    tabItem_CashRegisterOpen: TTabItem;
    toolBar_Open: TToolBar;
    shadow_CashRegisterOpen: TShadowEffect;
    btn_CashRegisterOpen: TSpeedButton;
    path_CashRegisterOpen: TPath;
    vScrollBox_Open: TVertScrollBox;
    layoutFlow_Open: TFlowLayout;
    layout_Open: TLayout;
    edt_OpenDay: TDateEdit;
    edt_OpenDayTitle: TLabel;
    btn_CashRegisterOpenBack: TSpeedButton;
    actTabChange_CashRegisterOpen: TChangeTabAction;
    rect_ExpensesMeal: TRectangle;
    btn_ExpensesMeal: TCornerButton;
    lbl_ExpensesMealTitle: TLabel;
    lbl_ExpensesMealRS: TLabel;
    lbl_ExpensesMeal: TLabel;
    tabItem_RetailList: TTabItem;
    lst_Rental: TListView;
    ToolBar1: TToolBar;
    btn_RetailListBack: TSpeedButton;
    lbl_RetailListTitlePoS: TLabel;
    ToolBar2: TToolBar;
    ShadowEffect4: TShadowEffect;
    lbl_RetailListTitleDay: TLabel;
    tabItem_Retail: TTabItem;
    VertScrollBox1: TVertScrollBox;
    FlowLayout1: TFlowLayout;
    Layout1: TLayout;
    ToolBar3: TToolBar;
    lbl_RetailTitlePoS: TLabel;
    btn_RetailBack: TSpeedButton;
    Rectangle7: TRectangle;
    Rectangle10: TRectangle;
    Label1: TLabel;
    ShadowEffect2: TShadowEffect;
    mm_DetailObs: TMemo;
    ShadowEffect6: TShadowEffect;
    ToolBar5: TToolBar;
    lbl_RetailTitleDate: TLabel;
    actTabChange_RetailList: TChangeTabAction;
    actTabChange_Retail: TChangeTabAction;
    Rectangle11: TRectangle;
    Rectangle12: TRectangle;
    Label2: TLabel;
    lbl_DetailStartDayDate: TLabel;
    Rectangle13: TRectangle;
    Label4: TLabel;
    lbl_DetailCount: TLabel;
    Rectangle14: TRectangle;
    Label6: TLabel;
    lbl_DetailBoatNumber: TLabel;
    ShadowEffect8: TShadowEffect;
    Rectangle23: TRectangle;
    Rectangle24: TRectangle;
    Label22: TLabel;
    Label23: TLabel;
    lbl_DetailPayValue: TLabel;
    Label25: TLabel;
    Rectangle25: TRectangle;
    Label26: TLabel;
    Label27: TLabel;
    lbl_DetailPayValueCard: TLabel;
    Label29: TLabel;
    Rectangle28: TRectangle;
    Label30: TLabel;
    Label31: TLabel;
    lbl_DetailPayValueOther: TLabel;
    Label33: TLabel;
    Rectangle29: TRectangle;
    Label34: TLabel;
    Label35: TLabel;
    lbl_DetailPayValuePix: TLabel;
    Label37: TLabel;
    Rectangle30: TRectangle;
    Label38: TLabel;
    Label39: TLabel;
    lbl_DetailPayValueCash: TLabel;
    Label41: TLabel;
    ShadowEffect7: TShadowEffect;
    Rectangle31: TRectangle;
    Label42: TLabel;
    lbl_DetailPayMinutes: TLabel;
    Label44: TLabel;
    Rectangle32: TRectangle;
    Rectangle33: TRectangle;
    Label45: TLabel;
    Label46: TLabel;
    lbl_DetailPayValueDiscount: TLabel;
    Label48: TLabel;
    Rectangle34: TRectangle;
    Label49: TLabel;
    Label50: TLabel;
    lbl_DetailPayValueFree: TLabel;
    Label52: TLabel;
    Rectangle36: TRectangle;
    Rectangle37: TRectangle;
    Rectangle38: TRectangle;
    Label54: TLabel;
    Label55: TLabel;
    lbl_DetailStartPayValue: TLabel;
    Label57: TLabel;
    Rectangle39: TRectangle;
    Label58: TLabel;
    Label59: TLabel;
    lbl_DetailStartPayValueCard: TLabel;
    Label61: TLabel;
    Rectangle40: TRectangle;
    Label62: TLabel;
    Label63: TLabel;
    lbl_DetailStartPayValueOther: TLabel;
    Label65: TLabel;
    Rectangle41: TRectangle;
    Label66: TLabel;
    Label67: TLabel;
    lbl_DetailStartPayValuePix: TLabel;
    Label69: TLabel;
    Rectangle42: TRectangle;
    Label70: TLabel;
    Label71: TLabel;
    lbl_DetailStartPayValueCash: TLabel;
    Label73: TLabel;
    Rectangle43: TRectangle;
    Label74: TLabel;
    lbl_DetailStartPayMinutes: TLabel;
    Label76: TLabel;
    Rectangle44: TRectangle;
    Rectangle45: TRectangle;
    Label77: TLabel;
    Label78: TLabel;
    lbl_DetailStartPayValueDiscount: TLabel;
    Label80: TLabel;
    Rectangle46: TRectangle;
    Label81: TLabel;
    Label82: TLabel;
    lbl_DetailStartPayValueFree: TLabel;
    Label84: TLabel;
    Rectangle47: TRectangle;
    Label85: TLabel;
    Rectangle48: TRectangle;
    Rectangle49: TRectangle;
    Rectangle50: TRectangle;
    Label86: TLabel;
    Label87: TLabel;
    lbl_DetailEndPayValue: TLabel;
    Label89: TLabel;
    Rectangle51: TRectangle;
    Label90: TLabel;
    Label91: TLabel;
    lbl_DetailEndPayValueCard: TLabel;
    Label93: TLabel;
    Rectangle52: TRectangle;
    Label94: TLabel;
    Label95: TLabel;
    lbl_DetailEndPayValueOther: TLabel;
    Label97: TLabel;
    Rectangle53: TRectangle;
    Label98: TLabel;
    Label99: TLabel;
    lbl_DetailEndPayValuePix: TLabel;
    Label101: TLabel;
    Rectangle54: TRectangle;
    Label102: TLabel;
    Label103: TLabel;
    lbl_DetailEndPayValueCash: TLabel;
    Label105: TLabel;
    Rectangle55: TRectangle;
    Label106: TLabel;
    lbl_DetailEndPayMinutes: TLabel;
    Label108: TLabel;
    Rectangle56: TRectangle;
    Rectangle57: TRectangle;
    Label109: TLabel;
    Label110: TLabel;
    lbl_DetailEndPayValueDiscount: TLabel;
    Label112: TLabel;
    Rectangle58: TRectangle;
    Label113: TLabel;
    Label114: TLabel;
    lbl_DetailEndPayValueFree: TLabel;
    Label116: TLabel;
    Rectangle59: TRectangle;
    Label117: TLabel;
    Rectangle19: TRectangle;
    Label8: TLabel;
    lbl_DetailStartDayTime: TLabel;
    Rectangle20: TRectangle;
    Label10: TLabel;
    lbl_DetailEndDayTime: TLabel;
    Rectangle21: TRectangle;
    Label12: TLabel;
    lbl_DetailEndDayDate: TLabel;
    Rectangle8: TRectangle;
    Label3: TLabel;
    Label5: TLabel;
    lbl_SummaryPayValue: TLabel;
    Rectangle15: TRectangle;
    Label9: TLabel;
    Label11: TLabel;
    lbl_SummaryTotal: TLabel;
    Rectangle16: TRectangle;
    Label14: TLabel;
    Label15: TLabel;
    lbl_SummaryExpenses: TLabel;
    Rectangle17: TRectangle;
    Label7: TLabel;
    Label13: TLabel;
    lbl_SummaryCash: TLabel;
    rect_Total: TRectangle;
    Rectangle1: TRectangle;
    lbl_PayValueTitle: TLabel;
    lbl_PayValueRS: TLabel;
    lbl_PayValue: TLabel;
    lbl_PayValueCent: TLabel;
    Rectangle3: TRectangle;
    lbl_PayValueCardTitle: TLabel;
    lbl_PayValueCardRS: TLabel;
    lbl_PayValueCard: TLabel;
    lbl_PayValueCardCent: TLabel;
    Rectangle4: TRectangle;
    lbl_PayValueOtherTitle: TLabel;
    lbl_PayValueOtherRS: TLabel;
    lbl_PayValueOther: TLabel;
    lbl_PayValueOtherCent: TLabel;
    Rectangle5: TRectangle;
    lbl_PayValuePixTitle: TLabel;
    lbl_PayValuePixRS: TLabel;
    lbl_PayValuePix: TLabel;
    lbl_PayValuePixCent: TLabel;
    Rectangle6: TRectangle;
    lbl_PayValueCashTitle: TLabel;
    lbl_PayValueCashRS: TLabel;
    lbl_PayValueCash: TLabel;
    lbl_PayValueCashCent: TLabel;
    ShadowEffect3: TShadowEffect;
    Rectangle2: TRectangle;
    lbl_PayMinutesTitle: TLabel;
    lbl_PayMinutes: TLabel;
    lbl_PayMinutesCent: TLabel;
    rect_SummaryDiscount: TRectangle;
    Rectangle26: TRectangle;
    lbl_PayValueDiscountTitle: TLabel;
    lbl_PayValueDiscountRS: TLabel;
    lbl_PayValueDiscount: TLabel;
    lbl_PayValueDiscountCent: TLabel;
    Rectangle27: TRectangle;
    lbl_PayValueFreeTitle: TLabel;
    lbl_PayValueFreeRS: TLabel;
    lbl_PayValueFree: TLabel;
    lbl_PayValueFreeCent: TLabel;
    rect_StartEnd: TRectangle;
    X: TRectangle;
    rect_StartPayValue: TRectangle;
    lbl_StartPayValueTitle: TLabel;
    lbl_StartPayValueRS: TLabel;
    lbl_StartPayValue: TLabel;
    lbl_StartPayValueCent: TLabel;
    rect_StartPayValueCard: TRectangle;
    lbl_StartPayValueCardTitle: TLabel;
    lbl_StartPayValueCardRS: TLabel;
    lbl_StartPayValueCard: TLabel;
    lbl_StartPayValueCardCent: TLabel;
    rect_StartPayValueOther: TRectangle;
    lbl_StartPayValueOtherTitle: TLabel;
    lbl_StartPayValueOtherRS: TLabel;
    lbl_StartPayValueOther: TLabel;
    lbl_StartPayValueOtherCent: TLabel;
    rect_StartPayValuePix: TRectangle;
    lbl_StartPayValuePixTitle: TLabel;
    lbl_StartPayValuePixRS: TLabel;
    lbl_StartPayValuePix: TLabel;
    lbl_StartPayValuePixCent: TLabel;
    rect_StartPayValueCash: TRectangle;
    lbl_StartPayValueCashTitle: TLabel;
    lbl_StartPayValueCashRS: TLabel;
    lbl_StartPayValueCash: TLabel;
    lbl_StartPayValueCashCent: TLabel;
    rect_StartPayMinutes: TRectangle;
    lbl_StartPayMinutesTitle: TLabel;
    lbl_StartPayMinutes: TLabel;
    lbl_StartPayMinutesCent: TLabel;
    rect_StartPayDiscountBorder: TRectangle;
    rect_StartPayValueDiscount: TRectangle;
    lbl_StartPayValueDiscountTitle: TLabel;
    lbl_StartPayValueDiscountRS: TLabel;
    lbl_StartPayValueDiscount: TLabel;
    lbl_StartPayValueDiscountCent: TLabel;
    rect_StartPayValueFree: TRectangle;
    lbl_StartPayValueFreeTitle: TLabel;
    lbl_StartPayValueFreeRS: TLabel;
    lbl_StartPayValueFree: TLabel;
    lbl_StartPayValueFreeCent: TLabel;
    rect_StartTitle: TRectangle;
    lbl_StartTitle: TLabel;
    Rectangle9: TRectangle;
    rect_End: TRectangle;
    rect_EndPayValue: TRectangle;
    lbl_EndPayValueTitle: TLabel;
    lbl_EndPayValueRS: TLabel;
    lbl_EndPayValue: TLabel;
    lbl_EndPayValueCent: TLabel;
    rect_EndPayValueCard: TRectangle;
    lbl_EndPayValueCardTitle: TLabel;
    lbl_EndPayValueCardRS: TLabel;
    lbl_EndPayValueCard: TLabel;
    lbl_EndPayValueCardCent: TLabel;
    rect_EndPayValueOther: TRectangle;
    lbl_EndPayValueOtherTitle: TLabel;
    lbl_EndPayValueOtherRS: TLabel;
    lbl_EndPayValueOther: TLabel;
    lbl_EndPayValueOtherCent: TLabel;
    rect_EndPayValuePix: TRectangle;
    lbl_EndPayValuePixTitle: TLabel;
    lbl_EndPayValuePixRS: TLabel;
    lbl_EndPayValuePix: TLabel;
    lbl_EndPayValuePixCent: TLabel;
    rect_EndPayValueCash: TRectangle;
    lbl_EndPayValueCashTitle: TLabel;
    lbl_EndPayValueCashRS: TLabel;
    lbl_EndPayValueCash: TLabel;
    lbl_EndPayValueCashCent: TLabel;
    rect_EndPayMinutes: TRectangle;
    lbl_EndPayMinutesTitle: TLabel;
    lbl_EndPayMinutes: TLabel;
    lbl_EndPayMinutesCent: TLabel;
    rect_EndPayValueDiscountBorder: TRectangle;
    rect_EndPayValueDiscount: TRectangle;
    lbl_EndPayValueDiscountTitle: TLabel;
    lbl_EndPayValueDiscountRS: TLabel;
    lbl_EndPayValueDiscount: TLabel;
    lbl_EndPayValueDiscountCent: TLabel;
    rect_EndPayValueFree: TRectangle;
    lbl_EndPayValueFreeTitle: TLabel;
    lbl_EndPayValueFreeRS: TLabel;
    lbl_EndPayValueFree: TLabel;
    lbl_EndPayValueFreeCent: TLabel;
    rect_EndTitle: TRectangle;
    lbl_EndTitle: TLabel;
    rect_Details: TRectangle;
    btn_ShowDetailList: TCornerButton;
    lbl_Details: TLabel;
    Rectangle18: TRectangle;
    Label17: TLabel;
    btn_CashRegisterPrint: TButton;
    Rectangle22: TRectangle;
    Label16: TLabel;
    Rectangle35: TRectangle;
    Rectangle60: TRectangle;
    Rectangle61: TRectangle;
    btn_SummaryInitialCash: TCornerButton;
    Label18: TLabel;
    Label19: TLabel;
    lbl_SummaryInitialCash: TLabel;
    btn_CashRegisterClose: TButton;
    toolBar_CashRegister2: TToolBar;
    shadow_CashRegister2: TShadowEffect;
    btn_CashRegisterPrevious: TSpeedButton;
    btn_CashRegisterNext: TSpeedButton;
    lbl_CashRegisterDate: TLabel;
    tabItem_CashRegisterList: TTabItem;
    lst_CashRegisterList: TListView;
    shadow_CashRegisterListTitle: TShadowEffect;
    toolBar_CashRegisterListTitle: TToolBar;
    lbl_CashRegisterListTitle: TLabel;
    btn_CashRegisterListBack: TSpeedButton;
    actTabChange_CashRegisterList: TChangeTabAction;
    btn_CashRegisterShowOpen: TSpeedButton;
    Path1: TPath;
    btn_CashRegisterValidate: TButton;
    btn_CashRegisterValidated: TButton;
    tabItem_CashRegisterInput: TTabItem;
    ToolBar4: TToolBar;
    ShadowEffect1: TShadowEffect;
    btn_CashRegisterInputOK: TSpeedButton;
    Path2: TPath;
    btn_CashRegisterInputBack: TSpeedButton;
    VertScrollBox2: TVertScrollBox;
    FlowLayout2: TFlowLayout;
    Layout2: TLayout;
    actTabChange_CashRegisterInput: TChangeTabAction;
    edt_CashRegisterInput: TEdit;
    lbl_CashRegisterInput: TLabel;
    lbl_CashRegisterInputRS: TLabel;
    Layout3: TLayout;
    Label20: TLabel;
    Label21: TLabel;
    Label24: TLabel;
    procedure btn_PoSAddClick(Sender: TObject);
    procedure btn_PoSSaveClick(Sender: TObject);
    procedure btn_PoSCancelClick(Sender: TObject);
    procedure lst_PoSPullRefresh(Sender: TObject);
    procedure lst_PoSItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btn_PoSDeleteClick(Sender: TObject);
    procedure tabCtrl_ListChange(Sender: TObject);
    procedure C(Sender: TObject);
    procedure btn_ExpensesMealClick(Sender: TObject);
    procedure btn_ExpensesFuelClick(Sender: TObject);
    procedure btn_ExpensesDailyClick(Sender: TObject);
    procedure btn_ExpensesOtherClick(Sender: TObject);
    procedure btn_CashRegisterBackClick(Sender: TObject);
    procedure btn_CashRegisterOpenBackClick(Sender: TObject);
    procedure btn_CashRegisterShowOpenClick(Sender: TObject);
    procedure btn_CashRegisterOpenClick(Sender: TObject);
    procedure btn_ShowDetailListClick(Sender: TObject);
    procedure lst_RentalItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btn_RetailBackClick(Sender: TObject);
    procedure btn_RetailListBackClick(Sender: TObject);
    procedure btn_CashRegisterPrintClick(Sender: TObject);
    procedure btn_SummaryInitialCashClick(Sender: TObject);
    procedure btn_CashRegisterCloseClick(Sender: TObject);
    procedure lbl_CashRegisterDateClick(Sender: TObject);
    procedure lst_CashRegisterListItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btn_CashRegisterListBackClick(Sender: TObject);
    procedure btn_CashRegisterNextClick(Sender: TObject);
    procedure btn_CashRegisterPreviousClick(Sender: TObject);
    procedure btn_CashRegisterValidateClick(Sender: TObject);
    procedure btn_CashRegisterValidatedClick(Sender: TObject);
    procedure lbl_DetailsClick(Sender: TObject);
    procedure btn_CashRegisterInputBackClick(Sender: TObject);
    procedure btn_CashRegisterInputOKClick(Sender: TObject);
  private
    { Private declarations }
    // BASIC HANDLE
    FApplyUpdatesErrorMessage: String;
    FGetErrorMessage         : String;

    FPoSID            : TGUID;
    FCashRegisterDate : TDate;
    FRentalID         : TGUID;

    procedure ShowDialogExpense(argCaption: String; argLabelExpense: Tlabel; argFieldExpense: TField);
    procedure PoSListRefresh();
    procedure CashRegisterRefresh();
    procedure CashRegisterListRefresh();
    procedure RetailListRefresh();
    procedure RetailRefresh();

    procedure PrintClose();
    function  FindCashRegister(): TDate;
    
  public
    { Public declarations }
    // BASIC HANDLE: Prepare; ApplyUpdates; Refresh
    procedure Prepare;
    procedure ApplyUpdates;
    procedure ApplyUpdateTerminated(Sender: TObject);

    procedure RefreshTerminated(Sender: TObject);

    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown (Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);

  end;



implementation

{$R *.fmx}

uses udm_Main, ufrm_Main, ufrm_Waiting, unt_VSoftUUIDv7, Math, ufrm_Boat, unt_Printer;

//------------------------------------------------------------------------------
// BASE HANDLE
//      Prepare
//      ApplyUpdates
//      Refresh
//------------------------------------------------------------------------------

procedure Tfrm_PoS.Prepare;       // Call it before open the frame
begin
  FPoSID            := GUID_NULL;
  FCashRegisterDate := 0;
  FRentalID         := GUID_NULL;

  if PoSAdmin then
    begin
      PoSListRefresh();                          // or if we are currently in offline mode

      tabCtrl_List.ActiveTab  := tabItem_PoSList;
      btn_CashRegisterListBack.Visible := True;
      btn_PoSEdit.Visible     := True;
      btn_PoSAdd.Visible      := True;
    end
  else
    begin
      btn_CashRegisterListBack.Visible := False;
      btn_PoSEdit.Visible              := False;
      btn_PoSAdd.Visible               := False;

      FPoSID := GUID_NULL;

      if not dm_Main.tb_PoS.Locate('id', GuidToString(PoSID), []) then
        begin
          TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.Prepare');
          Exit;
        end;

      FPoSID            := dm_Main.tb_PoS.FieldByName('id' ).AsGuid;
      FCashRegisterDate := FindCashRegister();
      FRentalID         := GUID_NULL;

      // Safe mode
      if FPoSID = GUID_NULL then
        begin
          lst_PoS.Items.BeginUpdate;
          lst_PoS.Items.Clear;
          lst_PoS.Items.EndUpdate;

          tabCtrl_List.ActiveTab  := tabItem_PoSList;
          Exit;
        end;

      CashRegisterRefresh;
      tabCtrl_List.ActiveTab  := tabItem_CashRegister;
    end;
end;

procedure Tfrm_PoS.ApplyUpdates;
//var
//  LPoSID : TGuid;
//  LDay   : TDate;
begin

//  if dm_Main.tb_PoS.State in dsEditModes then dm_Main.tb_PoS.Post;         // Save it
//  if dm_Main.tb_CashRegister.State in dsEditModes then dm_Main.tb_CashRegister.Post;         // Save it

//  LPoSID := dm_Main.tb_PoS.FieldByName('id' ).AsGuid;
//  LDay   := dm_Main.tb_CashRegister.FieldByName('Day').AsDateTime;

  // If it's in Offline mode, we don't need to attempt to sync, we just save to file.
//  if frm_Main.Sync = ssOffline then
//    begin
//      dm_Main.tb_PoS.SaveToFile;
//      dm_Main.tb_CashRegister.SaveToFile;
//      // Refresh
//      Exit;
//    end;

//  dm_Main.tb_PoS.Locate('id'       , GuidToString(LPoSID));
//  dm_Main.tb_CashRegister.Locate('PoSID;Day', VarArrayOf([GUIDToString(LPoSID), LDay]));
end;

procedure Tfrm_PoS.ApplyUpdateTerminated(Sender: TObject);
begin

end;

procedure Tfrm_PoS.RefreshTerminated(Sender: TObject);
begin

end;


procedure Tfrm_PoS.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  //
end;

procedure Tfrm_PoS.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  //
end;

function Tfrm_PoS.FindCashRegister: TDate;
begin
  Result := 0;

  dm_Main.tb_CashRegister.Filtered := False;
  if PoSAdmin then
    dm_Main.tb_CashRegister.Filter   := 'posId = ' + QuotedStr(GUIDTOString(FPoSID))
  else
    dm_Main.tb_CashRegister.Filter   := '(validated = FALSE OR validated IS NULL) AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
  dm_Main.tb_CashRegister.Filtered := True;
  try
    // Find the opened or the last one
    dm_Main.tb_CashRegister.First;
    while not dm_Main.tb_CashRegister.Eof do
      begin
        Result := dm_Main.tb_CashRegister.FieldByName('date').AsDateTime;

        if dm_Main.tb_CashRegister.FieldByName('open').AsBoolean then Exit;

        dm_Main.tb_CashRegister.Next;
      end;
  finally
    dm_Main.tb_CashRegister.Filtered := False;
  end;
end;


// *****************************************************************************
// POS List
// *****************************************************************************

procedure Tfrm_PoS.lst_PoSPullRefresh(Sender: TObject);
begin
  PoSListRefresh();
end;

procedure Tfrm_PoS.PoSListRefresh();
var
  LItem : TListViewItem;
begin
  lst_PoS.Items.BeginUpdate;
  try
    lst_PoS.Items.Clear;
    dm_Main.tb_PoS.First;
    while not dm_Main.tb_PoS.Eof do
      begin
        LItem           := lst_PoS.Items.Add;
        LItem.TagString := GuidToString(dm_Main.tb_PoS.FieldByName('id').AsGuid);

        LItem.Objects.FindDrawable('txtName').Data := dm_Main.tb_PoS.FieldByName('Name').AsString;
        if dm_Main.tb_PoS.FieldByName('Active').AsBoolean then
          LItem.Objects.FindDrawable('txtActive').Data := '🔵'
        else
          LItem.Objects.FindDrawable('txtActive').Data := '⚫';

        dm_Main.tb_PoS.Next;
      end;
  finally
    lst_PoS.Items.EndUpdate;
  end;

//  if frm_Main.Sync = ssOffline then       // If it is in offline mode, we dont need to sync
//    begin
//      Waiting_Show;
//      // Something that we need to do, if it is in offline mode
//      Waiting_Hide;
//      Exit;
//    end;
end;

procedure Tfrm_PoS.lst_PoSItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if not dm_Main.tb_PoS.Locate('id', AItem.TagString) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.lst_PoSItemClick');
      Exit;
    end;

  FPoSID            := dm_Main.tb_PoS.FieldByName('id').AsGuid;
  FCashRegisterDate := FindCashRegister();
  FRentalID         := GUID_NULL;

  CashRegisterRefresh();
  actTabChange_CashRegister.Execute;
end;


procedure Tfrm_PoS.lbl_CashRegisterDateClick(Sender: TObject);
begin
  CashRegisterListRefresh();
  actTabChange_CashRegisterList.Execute();
end;


procedure Tfrm_PoS.lbl_DetailsClick(Sender: TObject);
begin

end;

// *****************************************************************************
// POS EDIT
// *****************************************************************************

procedure Tfrm_PoS.btn_PoSAddClick(Sender: TObject);
begin
  FPoSID         := POS_NONE;
  lbl_PoSID.Text := GUIDToString(FPoSID);

  switch_PoSActive.IsChecked      := True;
  edt_PoSName.Text                := '';
  switch_PoSActive.SetFocus;

  actTabChange_PoSEdit.Execute;
end;


procedure Tfrm_PoS.C(Sender: TObject);
begin
  if not dm_Main.tb_PoS.Locate('id', GuidToString(FPoSID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_PoSEditClick');
      Exit;
    end;

  lbl_PoSID.Text             := dm_Main.tb_PoS.FieldByName('id'    ).AsString;
  switch_PoSActive.IsChecked := dm_Main.tb_PoS.FieldByName('Active').AsBoolean;
  edt_PoSName.Text           := dm_Main.tb_PoS.FieldByName('Name'  ).AsString;

  switch_PoSActive.SetFocus;
  actTabChange_PoSEdit.Execute;
end;

procedure Tfrm_PoS.btn_PoSCancelClick(Sender: TObject);
var
  LIsInsert : Boolean;
begin
  LIsInsert := lbl_PoSID.Text = GUIDToString(POS_NONE);
  if LIsInsert then
    actTabChange_PoSList.Execute
  else
    actTabChange_CashRegister.Execute;
end;

procedure Tfrm_PoS.tabCtrl_ListChange(Sender: TObject);
var
  LIsInsert : Boolean;
begin
  LIsInsert := FPosID = GUID_NULL;
  btn_PoSDelete.Visible := not LIsInsert;
end;

procedure Tfrm_PoS.btn_PoSSaveClick(Sender: TObject);
var
  LIsInsert : Boolean;
begin
  if edt_PoSName.Text.IsEmpty then
    begin
      edt_PoSName.SetFocus;
      TDialogService.ShowMessage('Nome requerido');
      Exit;
    end;

  LIsInsert := FPoSID = GUID_NULL;
  if LIsInsert then
    begin
      dm_Main.tb_PoS.Append;
      dm_Main.tb_PoS.FieldByName('id').AsGuid  :=  TUUIDv7Helper.CreateV7;
    end
  else
    begin
      if not dm_Main.tb_PoS.Locate('id', GuidToString(FPoSID), [] ) then
        begin
          TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_PoSSaveClick');
          Exit;
        end;
      dm_Main.tb_PoS.Edit;
    end;
  dm_Main.tb_PoS.FieldByName('Active').AsBoolean := switch_PoSActive.IsChecked;
  dm_Main.tb_PoS.FieldByName('Name'  ).AsString  := edt_PoSName.Text;
  dm_Main.tb_PoS.Post;

  dm_Main.tb_PoS.SaveToFile();

  if LIsInsert then
    begin
      PoSListRefresh();
      actTabChange_PoSList.Execute;
    end
  else
    begin
      CashRegisterRefresh();
      actTabChange_CashRegister.Execute;
    end;
end;


procedure Tfrm_PoS.btn_PoSDeleteClick(Sender: TObject);
begin
  if true then
    begin
      // We must check if there is any rental at this PoS
      // or if there is any boat assigned to this PoS, before delete it.
      TDialogService.ShowMessage( 'Eliminação de um Ponto não implementada.' );
      Exit;
    end;

  TDialogService.MessageDialog( 'Excluir?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  begin
                                    if AResult = mrYes then
                                      begin
                                        if not dm_Main.tb_PoS.Locate('id', GUIDTOString(FPoSID), [] ) then
                                          begin
                                            TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_PoSDeleteClick.MessageDialog');
                                            Exit;
                                          end;

                                        dm_Main.tb_PoS.Delete;
                                        dm_Main.tb_PoS.SaveToFile();

                                        PoSListRefresh();
                                        
                                        actTabChange_PoSList.Execute();
                                      end
                                  end);
end;


// *****************************************************************************
// CASH REGISTER
// *****************************************************************************

procedure Tfrm_PoS.CashRegisterRefresh();
var
  LCount    : LongWord;

  LTotalPayValue,
  LTotalExpensesTotal,
  LTotal,
  LTotalCash,
  LTotalInitialCash : Currency;

  LExpensesTotal,
  LExpensesFuel,
  LExpensesMeal,
  LExpensesDaily,
  LExpensesOther: Currency;

  LPayMinutes,
  LEndPayMinutes,
  LStartPayMinutes : LongWord;

  LPayValue,
  LPayValueCard,
  LPayValueCash,
  LPayValuePix,
  LPayValueOther,
  LPayValueDiscount,
  LPayValueFree,

  LStartPayValue,
  LStartPayValueCard,
  LStartPayValueCash,
  LStartPayValuePix,
  LStartPayValueOther,
  LStartPayValueDiscount,
  LStartPayValueFree,

  LEndPayValue,
  LEndPayValueCard,
  LEndPayValueCash,
  LEndPayValuePix,
  LEndPayValueOther,
  LEndPayValueDiscount,
  LEndPayValueFree : Currency;

  LPoSName   : String;

  LCashRegisterCount          : LongWord;
  LCashRegisterOpenCount      : LongWord;
  LCashRegisterValidatedCount : LongWord;

  LDayOpen, LDayClose, LDayValidate, LDayValidated  : Boolean;

begin
  // Clear Vars, make sure it starts with 0
  LCount                := 0;

  LDayOpen              := False;
  LDayClose             := False;
  LDayValidate              := False;
  LDayValidated             := False;

  LCashRegisterCount          := 0;
  LCashRegisterOpenCount      := 0;
  LCashRegisterValidatedCount := 0;

  LPayMinutes           := 0;
  LStartPayMinutes      := 0;
  LEndPayMinutes        := 0;

  LPayValue             := 0.00;
  LPayValueCard         := 0.00;
  LPayValueCash         := 0.00;
  LPayValuePix          := 0.00;
  LPayValueOther        := 0.00;
  LPayValueDiscount     := 0.00;
  LPayValueFree         := 0.00;

  LStartPayValue        := 0.00;
  LStartPayValueCard    := 0.00;
  LStartPayValueCash    := 0.00;
  LStartPayValuePix     := 0.00;
  LStartPayValueOther   := 0.00;
  LStartPayValueDiscount:= 0.00;
  LStartPayValueFree    := 0.00;

  LEndPayValue          := 0.00;
  LEndPayValueCard      := 0.00;
  LEndPayValueCash      := 0.00;
  LEndPayValuePix       := 0.00;
  LEndPayValueOther     := 0.00;
  LEndPayValueDiscount  := 0.00;
  LEndPayValueFree      := 0.00;

  LExpensesTotal        := 0.00;
  LExpensesFuel         := 0.00;
  LExpensesMeal         := 0.00;
  LExpensesDaily        := 0.00;
  LExpensesOther        := 0.00;

  LTotalPayValue        := 0.00;
  LTotalExpensesTotal   := 0.00;
  LTotal                := 0.00;
  LTotalCash            := 0.00;
  LTotalInitialCash     := 0.00;

  // Rental --------
  if not dm_Main.tb_PoS.Locate('id', GUIDTOString(FPoSID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.CashRegisterRefresh.tb_PoS.Locate');
      Exit;
    end;

  LPoSName    := dm_Main.tb_PoS.FieldByName('name').AsString;

  if FCashRegisterDate <> 0 then
    begin

      // Rental --------
      dm_Main.tb_Rental.Filtered := false;
      if FPoSID = GUID_NULL then
        dm_Main.tb_Rental.Filter := 'cashRegisterDate = {d ' + (FormatDateTime('yyyy-mm-dd', FCashRegisterDate)) + '}'
      else
        dm_Main.tb_Rental.Filter := 'cashRegisterDate = {d ' + (FormatDateTime('yyyy-mm-dd', FCashRegisterDate)) + '} AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
      dm_Main.tb_Rental.Filtered := true;
      try
        dm_Main.tb_Rental.First;
        while not dm_Main.tb_Rental.Eof do
          begin
            LStartPayMinutes       := LStartPayMinutes       + dm_Main.tb_Rental.FieldByName('startPayMinutes'       ).AsInteger;
            LStartPayValue         := LStartPayValue         + dm_Main.tb_Rental.FieldByName('startPayValue'         ).AsCurrency;
            LStartPayValueCard     := LStartPayValueCard     + dm_Main.tb_Rental.FieldByName('startPayValueCard'     ).AsCurrency;
            LStartPayValueCash     := LStartPayValueCash     + dm_Main.tb_Rental.FieldByName('startPayValueCash'     ).AsCurrency;
            LStartPayValuePix      := LStartPayValuePix      + dm_Main.tb_Rental.FieldByName('startPayValuePix'      ).AsCurrency;
            LStartPayValueOther    := LStartPayValueOther    + dm_Main.tb_Rental.FieldByName('startPayValueOther'    ).AsCurrency;
            if dm_Main.tb_Rental.FieldByName('startPayValue').AsCurrency  <> 0 then
              begin
                LStartPayValueDiscount := LStartPayValueDiscount    + dm_Main.tb_Rental.FieldByName('startPayValueDiscount'    ).AsCurrency;
              end
            else
              begin
                LStartPayValueFree     := LStartPayValueFree        + dm_Main.tb_Rental.FieldByName('startPayValueDiscount'        ).AsCurrency;
              end;

            LEndPayMinutes       := LEndPayMinutes       + dm_Main.tb_Rental.FieldByName('endPayMinutes'       ).AsInteger;
            LEndPayValue         := LEndPayValue         + dm_Main.tb_Rental.FieldByName('endPayValue'         ).AsCurrency;
            LEndPayValueCard     := LEndPayValueCard     + dm_Main.tb_Rental.FieldByName('endPayValueCard'     ).AsCurrency;
            LEndPayValueCash     := LEndPayValueCash     + dm_Main.tb_Rental.FieldByName('endPayValueCash'     ).AsCurrency;
            LEndPayValuePix      := LEndPayValuePix      + dm_Main.tb_Rental.FieldByName('endPayValuePix'      ).AsCurrency;
            LEndPayValueOther    := LEndPayValueOther    + dm_Main.tb_Rental.FieldByName('endPayValueOther'    ).AsCurrency;
            if dm_Main.tb_Rental.FieldByName('endPayValue').AsCurrency  <> 0 then
              begin
                LEndPayValueDiscount := LEndPayValueDiscount    + dm_Main.tb_Rental.FieldByName('endPayValueDiscount'    ).AsCurrency;
              end
            else
              begin
                LEndPayValueFree     := LEndPayValueFree        + dm_Main.tb_Rental.FieldByName('endPayValueDiscount'        ).AsCurrency;
              end;

            LPayMinutes       := LStartPayMinutes       + LEndPayMinutes;
            LPayValue         := LStartPayValue         + LEndPayValue;
            LPayValueCard     := LStartPayValueCard     + LEndPayValueCard;
            LPayValueCash     := LStartPayValueCash     + LEndPayValueCash;
            LPayValuePix      := LStartPayValuePix      + LEndPayValuePix;
            LPayValueOther    := LStartPayValueOther    + LEndPayValueOther;
            LPayValueDiscount := LStartPayValueDiscount + LEndPayValueDiscount;
            LPayValueFree     := LStartPayValueFree     + LEndPayValueFree;

            dm_Main.tb_Rental.Next;
          end;
        LCount := LCount + dm_Main.tb_Rental.RecordCount;
      finally
        dm_Main.tb_Rental.Filtered := false;
      end;

      // Day --------
      dm_Main.tb_CashRegister.Filtered := False;
      if PoSAdmin then
        begin
          if FPoSID = GUID_NULL then
            dm_Main.tb_CashRegister.Filter := 'date = {d ' + (FormatDateTime('yyyy-mm-dd', FCashRegisterDate)) + '}'
          else
            dm_Main.tb_CashRegister.Filter := 'date = {d ' + (FormatDateTime('yyyy-mm-dd', FCashRegisterDate)) + '} AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
        end
      else
        begin
          if FPoSID = GUID_NULL then
            dm_Main.tb_CashRegister.Filter := '(validated = FALSE OR validated IS NULL) AND date = {d ' + (FormatDateTime('yyyy-mm-dd', FCashRegisterDate)) + '}'
          else
            dm_Main.tb_CashRegister.Filter := '(validated = FALSE OR validated IS NULL) AND date = {d ' + (FormatDateTime('yyyy-mm-dd', FCashRegisterDate)) + '} AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
        end;
      dm_Main.tb_CashRegister.Filtered := True;
      try
        dm_Main.tb_CashRegister.First;
        while not dm_Main.tb_CashRegister.Eof do
          begin
            LTotalInitialCash := LTotalInitialCash + dm_Main.tb_CashRegister.FieldByName('initialCash').AsCurrency;

            LExpensesTotal := LExpensesTotal + dm_Main.tb_CashRegister.FieldByName('expensesTotal').AsCurrency;
            LExpensesMeal  := LExpensesMeal  + dm_Main.tb_CashRegister.FieldByName('expensesMeal' ).AsCurrency;
            LExpensesFuel  := LExpensesFuel  + dm_Main.tb_CashRegister.FieldByName('expensesFuel' ).AsCurrency;
            LExpensesDaily := LExpensesDaily + dm_Main.tb_CashRegister.FieldByName('expensesDaily').AsCurrency;
            LExpensesOther := LExpensesOther + dm_Main.tb_CashRegister.FieldByName('expensesOther').AsCurrency;

            LCashRegisterCount := LCashRegisterCount + 1;

            if dm_Main.tb_CashRegister.FieldByName('open').AsBoolean then
              LCashRegisterOpenCount := LCashRegisterOpenCount + 1;

            if dm_Main.tb_CashRegister.FieldByName('validated').AsBoolean then
              LCashRegisterValidatedCount := LCashRegisterValidatedCount + 1;

            dm_Main.tb_CashRegister.Next;
          end;
      finally
        dm_Main.tb_CashRegister.Filtered := False;
      end;

      // SummaryValues
      LTotalPayValue      := LPayValue;
      LTotalExpensesTotal := LExpensesTotal;
      LTotal              := LTotalPayValue - LTotalExpensesTotal;
      LTotalCash          := LTotalInitialCash + LPayValueCash    - LTotalExpensesTotal;
    end;

  if LCashRegisterCount = 0 then
    begin
      lbl_SummaryDayOpen.Text  := '-----';
    end
  else if LCashRegisterCount = 1 then
    begin
      if LCashRegisterOpenCount = 0 then
        begin
          lbl_SummaryDayOpen.Text  := 'FECHADO';
          LDayClose := true;

          if LCashRegisterValidatedCount = 1 then
            begin
             lbl_SummaryDayOpen.Text  := 'VALIDADO';
             LDayValidated := (FCashRegisterDate <> 0) and PoSAdmin;
            end
          else
            begin
             LDayValidate := (FCashRegisterDate <> 0) and PoSAdmin;
            end;
        end
      else
        begin
          lbl_SummaryDayOpen.Text  := 'ABERTO';
          LDayOpen := True;
        end;



    end
  else
    begin
      if LCashRegisterValidatedCount > 0 then
        begin
         if LCashRegisterValidatedCount = LCashRegisterCount then
           lbl_SummaryDayOpen.Text  := 'VALIDADOS'
         else
           lbl_SummaryDayOpen.Text  := 'P. VALIDADOS'
        end
      else if LCashRegisterOpenCount > 0 then
        begin
         if LCashRegisterValidatedCount = LCashRegisterCount then
           lbl_SummaryDayOpen.Text  := 'ABERTOS'
         else
           lbl_SummaryDayOpen.Text  := 'P. ABERTOS'
        end
      else
         lbl_SummaryDayOpen.Text  := 'FECHADOS';
    end;

  btn_CashRegisterClose.Visible     := True;
  btn_CashRegisterPrint.Visible     := True;
  btn_CashRegisterValidate.Visible  := True;
  btn_CashRegisterValidated.Visible := True;

//  btn_SummaryDayOpen.Visible     := not LDayOpen;
  btn_CashRegisterClose.Visible  := LDayOpen;
  btn_CashRegisterPrint.Visible  := LDayClose;
  btn_CashRegisterValidate.Visible  := LDayValidate;
  btn_CashRegisterValidated.Visible := LDayValidated;
  btn_SummaryInitialCash.Enabled := LDayOpen;
  btn_ExpensesMeal.Enabled       := LDayOpen;
  btn_ExpensesFuel.Enabled       := LDayOpen;
  btn_ExpensesDaily.Enabled      := LDayOpen;
  btn_ExpensesOther.Enabled      := LDayOpen;
  btn_ShowDetailList.Enabled     := FCashRegisterDate <> 0;

  // Update Labels
  lbl_CashRegisterMainTitle.Text      := LPoSName;
  if FCashRegisterDate = 0 then
    lbl_CashRegisterDate.Text            := '--/--/----'
  else
    lbl_CashRegisterDate.Text            := FormatDateTime('dd/mm/yyyy', FCashRegisterDate);

  lbl_SummaryCount.Text          := Format('%d', [LCount                  ]);
  lbl_SummaryPayValue.Text       := FormatFloat('0.00', LTotalPayValue     );
  lbl_SummaryExpenses.Text       := FormatFloat('0.00', LTotalExpensesTotal);
  lbl_SummaryTotal.Text          := FormatFloat('0.00', LTotal             );
  lbl_SummaryInitialCash.Text    := FormatFloat('0.00', LTotalInitialCash  );
  lbl_SummaryCash.Text           := FormatFloat('0.00', LTotalCash         );

  lbl_Expenses.Text              := FormatFloat('0.00', LExpensesTotal  );
  lbl_ExpensesMeal.Text          := FormatFloat('0.00', LExpensesMeal   );
  lbl_ExpensesFuel.Text          := FormatFloat('0.00', LExpensesFuel   );
  lbl_ExpensesDaily.Text         := FormatFloat('0.00', LExpensesDaily  );
  lbl_ExpensesOther.Text         := FormatFloat('0.00', LExpensesOther  );

  lbl_PayMinutes.Text            := Format     ('%d', [LPayMinutes          ]);
  lbl_PayValue.Text              := FormatFloat('0',   LPayValue             );
  lbl_PayValueCard.Text          := FormatFloat('0',   LPayValueCard         );
  lbl_PayValueCash.Text          := FormatFloat('0',   LPayValueCash         );
  lbl_PayValuePix.Text           := FormatFloat('0',   LPayValuePix          );
  lbl_PayValueOther.Text         := FormatFloat('0',   LPayValueOther        );
  lbl_PayValueDiscount.Text      := FormatFloat('0',   LPayValueDiscount     );
  lbl_PayValueFree.Text          := FormatFloat('0',   LPayValueFree         );

  lbl_StartPayMinutes.Text       := Format     ('%d', [LStartPayMinutes     ]);
  lbl_StartPayValue.Text         := FormatFloat('0',   LStartPayValue        );
  lbl_StartPayValueCard.Text     := FormatFloat('0',   LStartPayValueCard    );
  lbl_StartPayValueCash.Text     := FormatFloat('0',   LStartPayValueCash    );
  lbl_StartPayValuePix.Text      := FormatFloat('0',   LStartPayValuePix     );
  lbl_StartPayValueOther.Text    := FormatFloat('0',   LStartPayValueOther   );
  lbl_StartPayValueDiscount.Text := FormatFloat('0',   LStartPayValueDiscount);
  lbl_StartPayValueFree.Text     := FormatFloat('0',   LStartPayValueFree    );

  lbl_EndPayMinutes.Text         := Format     ('%d', [LEndPayMinutes       ]);
  lbl_EndPayValue.Text           := FormatFloat('0',   LEndPayValue          );
  lbl_EndPayValueCard.Text       := FormatFloat('0',   LEndPayValueCard      );
  lbl_EndPayValueCash.Text       := FormatFloat('0',   LEndPayValueCash      );
  lbl_EndPayValuePix.Text        := FormatFloat('0',   LEndPayValuePix       );
  lbl_EndPayValueOther.Text      := FormatFloat('0',   LEndPayValueOther     );
  lbl_EndPayValueDiscount.Text   := FormatFloat('0',   LEndPayValueDiscount  );
  lbl_EndPayValueFree.Text       := FormatFloat('0',   LEndPayValueFree      );
end;

procedure Tfrm_PoS.btn_CashRegisterBackClick(Sender: TObject);
begin
  PoSListRefresh();
  actTabChange_PoSList.Execute;
end;

procedure Tfrm_PoS.btn_ShowDetailListClick(Sender: TObject);
begin
  RetailListRefresh();
  actTabChange_RetailList.Execute();
end;
// -----------------------------------------------------------------------------


procedure Tfrm_PoS.btn_SummaryInitialCashClick(Sender: TObject);
begin
  ShowDialogExpense('Valor em dinheiro na Abertura do Caixa:', lbl_SummaryInitialCash, dm_Main.tb_CashRegister.FieldByName('initialCash'));
end;

procedure Tfrm_PoS.btn_ExpensesMealClick(Sender: TObject);
begin
  ShowDialogExpense('Valor total dos gastos com alimentação:', lbl_ExpensesMeal, dm_Main.tb_CashRegister.FieldByName('expensesMeal'));
end;

procedure Tfrm_PoS.btn_ExpensesFuelClick(Sender: TObject);
begin
  ShowDialogExpense('Valor total dos gastos com combustível:', lbl_ExpensesFuel, dm_Main.tb_CashRegister.FieldByName('expensesFuel'));
end;

procedure Tfrm_PoS.btn_ExpensesDailyClick(Sender: TObject);
begin
  ShowDialogExpense('Valor total dos gastos com diárias:', lbl_ExpensesDaily, dm_Main.tb_CashRegister.FieldByName('expensesDaily'));
end;

procedure Tfrm_PoS.btn_ExpensesOtherClick(Sender: TObject);
begin
  ShowDialogExpense('Valor total dos outros gastos:', lbl_ExpensesOther, dm_Main.tb_CashRegister.FieldByName('expensesOther'));
end;

// -----------------------------------------------------------------------------

procedure Tfrm_PoS.btn_CashRegisterPreviousClick(Sender: TObject);
var
  LDate : TDate;
begin
  if FCashRegisterDate = 0 then Exit;

  LDate := FCashRegisterDate;

  dm_Main.tb_CashRegister.Filtered := false;
  if PosAdmin then
    begin
      if FPoSID = GUID_NULL then
        dm_Main.tb_CashRegister.Filter := ''
      else
        dm_Main.tb_CashRegister.Filter := 'posId = ' + QuotedStr(GUIDTOString(FPoSID));
    end
  else
    begin
      if FPoSID = GUID_NULL then
        dm_Main.tb_CashRegister.Filter := '(validated = FALSE OR validated IS NULL)'
      else
        dm_Main.tb_CashRegister.Filter := '(validated = FALSE OR validated IS NULL) AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
    end;
  dm_Main.tb_CashRegister.Filtered := true;
  try
    if not dm_Main.tb_CashRegister.Locate('date', VarArrayOf([FCashRegisterDate])) then Exit;

    dm_Main.tb_CashRegister.Prior;
    LDate := dm_Main.tb_CashRegister.FieldByName('date').AsDateTime;
  finally
    dm_Main.tb_CashRegister.Filtered := false;
  end;

  FCashRegisterDate := LDate;
  CashRegisterRefresh();
end;

procedure Tfrm_PoS.btn_CashRegisterPrintClick(Sender: TObject);
begin
  PrintClose();
end;


procedure Tfrm_PoS.PrintClose();
var
  LLines : TStringList;
  LIndex : Integer;
  LPayMinutes, LCount : Cardinal;
  LPayValue  : Currency;
  LLine : string;
  LPoSName : String;

begin
  if not PRINTER_ENABLE then
    Exit;

  LLines := TStringList.Create();
  try

    if not dm_Main.tb_PoS.Locate('id', GuidToString(FPoSID)) then
      begin
        TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.PrintClose.tb_PoS.Locate');
        Exit;
      end;

    if FCashRegisterDate = 0 then
      begin
        TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.PrintClose.CashRegisterDate=0');
        Exit;
      end;

    if not dm_Main.tb_CashRegister.Locate('date;posId', VarArrayOf([FCashRegisterDate, GUIDToString(FPoSID)])) then
      begin
        TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.PrintClose.tb_CashRegister.Locate');
        Exit;
      end;

    if dm_Main.tb_CashRegister.FieldByName('open').AsBoolean then
      begin
        TDialogService.ShowMessage('O caixa o Ponto de Vendas ainda está aberto.');
        Exit;
      end;

    LPoSName := dm_Main.tb_PoS.FieldByName('name').AsString;

    LLines.Add('');
    LLines.Add('PONTO: ' + LPoSName + FormatDateTime( ' (yyyyMMdd)', FCashRegisterDate ));
    LLines.Add('DATA DO CAIXA: '    + FormatDateTime( 'dd/MM/yyyy' , FCashRegisterDate ));
    LLines.Add('');
    LLines.Add('Quant. Vendas..:    ' + Format('%5s', [lbl_SummaryCount.Text   ]));
    LLines.Add('Total de Vendas: R$ ' + Format('%8s', [lbl_SummaryPayValue.Text]));
    LLines.Add('Total de Gastos: R$ ' + Format('%8s', [lbl_SummaryExpenses.Text]));
    LLines.Add('Saldo Total....: R$ ' + Format('%8s', [lbl_SummaryTotal.Text   ]));
    LLines.Add('--------------------------------');
    LLines.Add('Abertura Caixa.: R$ ' + Format('%8s', [lbl_SummaryInitialCash.Text]));
    LLines.Add('Saldo Caixa....: R$ ' + Format('%8s', [lbl_SummaryCash.Text       ]));
    LLines.Add('');
    LLines.Add('TOTAL DE GASTOS: R$ ' + Format('%8s', [lbl_Expenses.Text       ]));
    LLines.Add('Combustivel....: R$ ' + Format('%8s', [lbl_ExpensesFuel.Text   ]));
    LLines.Add('Alimentacao....: R$ ' + Format('%8s', [lbl_ExpensesMeal.Text   ]));
    LLines.Add('Diarias........: R$ ' + Format('%8s', [lbl_ExpensesDaily.Text  ]));
    LLines.Add('Outros.........: R$ ' + Format('%8s', [lbl_ExpensesOther.Text  ]));
    LLines.Add('');
    LLines.Add('TOTAL DE VENDAS');
    LLines.Add('Minutos........:    ' + Format('%5s'   , [lbl_PayMinutes.Text        ]));
    LLines.Add('Total..........: R$ ' + Format('%5s,00', [lbl_PayValue.Text          ]));
    LLines.Add('  Cartao.......: R$ ' + Format('%5s,00', [lbl_PayValueCard.Text      ]));
    LLines.Add('  Dinheiro.....: R$ ' + Format('%5s,00', [lbl_PayValueCash.Text      ]));
    LLines.Add('  Pix..........: R$ ' + Format('%5s,00', [lbl_PayValuePix.Text       ]));
    LLines.Add('  Outros.......: R$ ' + Format('%5s,00', [lbl_PayValueOther.Text     ]));
    LLines.Add('Desconto.......: R$ ' + Format('%5s,00', [lbl_PayValueDiscount.Text  ]));
    LLines.Add('Cortesia.......: R$ ' + Format('%5s,00', [lbl_PayValueFree.Text      ]));
    LLines.Add('');
    LLines.Add('-- PAGO ENTRADA ---------------');
    LLines.Add('Minutos........:    ' + Format('%5s'   , [lbl_StartPayMinutes.Text        ]));
    LLines.Add('Total..........: R$ ' + Format('%5s,00', [lbl_StartPayValue.Text          ]));
    LLines.Add('  Cartao.......: R$ ' + Format('%5s,00', [lbl_StartPayValueCard.Text      ]));
    LLines.Add('  Dinheiro.....: R$ ' + Format('%5s,00', [lbl_StartPayValueCash.Text      ]));
    LLines.Add('  Pix..........: R$ ' + Format('%5s,00', [lbl_StartPayValuePix.Text       ]));
    LLines.Add('  Outros.......: R$ ' + Format('%5s,00', [lbl_StartPayValueOther.Text     ]));
    LLines.Add('Desconto.......: R$ ' + Format('%5s,00', [lbl_StartPayValueDiscount.Text  ]));
    LLines.Add('Cortesia.......: R$ ' + Format('%5s,00', [lbl_StartPayValueFree.Text      ]));
    LLines.Add('-- PAGO SAIDA -----------------');
    LLines.Add('Min. Excedentes:    ' + Format('%5s'   , [lbl_EndPayMinutes.Text        ]));
    LLines.Add('Total..........: R$ ' + Format('%5s,00', [lbl_EndPayValue.Text          ]));
    LLines.Add('  Cartao.......: R$ ' + Format('%5s,00', [lbl_EndPayValueCard.Text      ]));
    LLines.Add('  Dinheiro.....: R$ ' + Format('%5s,00', [lbl_EndPayValueCash.Text      ]));
    LLines.Add('  Pix..........: R$ ' + Format('%5s,00', [lbl_EndPayValuePix.Text       ]));
    LLines.Add('  Outros.......: R$ ' + Format('%5s,00', [lbl_EndPayValueOther.Text     ]));
    LLines.Add('Desconto.......: R$ ' + Format('%5s,00', [lbl_EndPayValueDiscount.Text  ]));
    LLines.Add('Cortesia.......: R$ ' + Format('%5s,00', [lbl_EndPayValueFree.Text      ]));
    LLines.Add('');
    LLines.Add('Horario de Impressao:');
    LLines.Add( FormatDateTime( 'dd/MM/yyyy hh:mm:ss', Now() ));
    LLines.Add('');
    LLines.Add('................................');
    LLines.Add('');
    LLines.Add('-- DETALHAMENTO ----------------');
    LLines.Add('');
  //LLines.Add('  00 P01 23:59 000min R$12345,00');

    dm_Main.tb_Rental.Filtered := false;
    dm_Main.tb_Rental.Filter   := 'cashRegisterDate = {d ' + (FormatDateTime('yyyy-mm-dd', FCashRegisterDate)) + '} AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
    dm_Main.tb_Rental.Filtered := true;
    try
      dm_Main.tb_Rental.First;
      while not dm_Main.tb_Rental.Eof do
        begin

          LPayMinutes := dm_Main.tb_Rental.FieldByName('startPayMinutes'      ).AsInteger  + dm_Main.tb_Rental.FieldByName('endPayMinutes'      ).AsInteger;
          LPayValue   := dm_Main.tb_Rental.FieldByName('startPayValue'        ).AsCurrency + dm_Main.tb_Rental.FieldByName('endPayValue'        ).AsCurrency;

          LLine := Format('%4s %3s %s %3smin R$%8s', [ Format('%0.2d', [dm_Main.tb_Rental.FieldByName('cashRegisterCount').AsInteger])
                                                           , dm_Main.tb_Rental.FieldByName('boatNumber').AsString
                                                           , FormatDateTime('hh:mm', dm_Main.tb_Rental.FieldByName('startAt').AsDateTime)
                                                           , Format('%d', [LPayMinutes])
                                                           , FormatFloat('0.00', LPayValue)
                                                           ]);

          LLines.Add(LLine);

          dm_Main.tb_Rental.Next;
        end;
    finally
      dm_Main.tb_Rental.Filtered := false;
    end;

    BTSendData( EP_INITIALIZE_PRINTER           );
    BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );

    BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH ));
    BTSendData( 'PEDALINHOS KLEIN' + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT );

    BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));

    BTSendData( '** FECHAMENTO DE CAIXA **'                     + EP_LF );

    BTSendData( EP_SELECT_JUSTIFICATION_LEFT  );

    for LIndex := 0 to LLines.Count - 1  do
      begin
        BTSendData( LLines.Strings[LIndex] + EP_LF + EP_LF + EP_PRINT );
      end;

    BTSendData(  EP_LF + EP_LF + EP_LF + EP_LF + EP_LF + EP_PRINT );
  finally
    LLines.Clear;
    LLines.Free;
  end;
end;


// *****************************************************************************
// RETAIL LIST
// *****************************************************************************

procedure Tfrm_PoS.btn_RetailListBackClick(Sender: TObject);
begin
  FRentalID := GUID_NULL;
  actTabChange_CashRegister.Execute();
end;

procedure Tfrm_PoS.lst_RentalItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  try
    FRentalID := StringToGUID(AItem.TagString);
    RetailRefresh();
    actTabChange_Retail.Execute();
  except
    on E: Exception do
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'lst_RentalItemClick - ' + E.Message);
    end;
  end;
end;


procedure Tfrm_PoS.RetailListRefresh();
var
  LItem :                 TListViewItem;
  LPayMinutes: Cardinal;
  LPayValue  : Currency;
  LPoSName : String;
  LDate    : TDate;
begin

  if not dm_Main.tb_PoS.Locate('id', GuidToString(FPoSID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.RetailListRefresh.tb_PoS.Locate');
      Exit;
    end;

  if FCashRegisterDate = 0 then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.RetailListRefresh.CashRegisterDate=0');
      Exit;
    end;

  LPoSName := dm_Main.tb_PoS.FieldByName('Name').AsString;
  LDate     := FCashRegisterDate;


  lbl_RetailListTitlePoS.Text := LPoSName;
  lbl_RetailListTitleDay.Text := FormatDateTime('dd/mm/yyyy', LDate);

  dm_Main.tb_Rental.Filtered := false;
  dm_Main.tb_Rental.Filter   := 'cashRegisterDate = {d ' + (FormatDateTime('yyyy-mm-dd', LDate)) + '} AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
  dm_Main.tb_Rental.Filtered := true;
  lst_Rental.Items.BeginUpdate;
  try
    dm_Main.tb_Rental.First;

    lst_Rental.Items.Clear;
    while not dm_Main.tb_Rental.Eof do
      begin
        LItem           := lst_Rental.Items.Add;
        LItem.TagString := dm_Main.tb_Rental.FieldByName('id').AsString;

        LPayMinutes := dm_Main.tb_Rental.FieldByName('startPayMinutes'      ).AsInteger  + dm_Main.tb_Rental.FieldByName('endPayMinutes'      ).AsInteger;
        LPayValue   := dm_Main.tb_Rental.FieldByName('startPayValue'        ).AsCurrency + dm_Main.tb_Rental.FieldByName('endPayValue'        ).AsCurrency;

        LItem.Objects.FindDrawable('txtCount'   ).Data := Format('%0.2d',[dm_Main.tb_Rental.FieldByName('cashRegisterCount').AsInteger]);
        LItem.Objects.FindDrawable('txtNumber'  ).Data :=                 dm_Main.tb_Rental.FieldByName('boatNumber'       ).AsString;
        LItem.Objects.FindDrawable('txtDateTime').Data := FormatDateTime('dd/mm/yyyy hh:mm:ss',
                                                                          dm_Main.tb_Rental.FieldByName('startAt'   ).AsDateTime);
        LItem.Objects.FindDrawable('txtTime'    ).Data :=         Format     ('%d'  , [LPayMinutes      ]) + ' min.';
        LItem.Objects.FindDrawable('txtValue'   ).Data := 'R$ ' + FormatFloat('0.00',  LPayValue         );

        dm_Main.tb_Rental.Next;
      end;
  finally
    lst_Rental.Items.EndUpdate;
    dm_Main.tb_Rental.Filtered := False;
  end;

//  if frm_Main.Sync = ssOffline then       // If it is in offline mode, we dont need to sync
//    begin
//      Waiting_Show;
//      // Something that we need to do, if it is in offline mode
//      Waiting_Hide;
//      Exit;
//    end;
end;


// *****************************************************************************
// RETAIL
// *****************************************************************************

procedure Tfrm_PoS.btn_RetailBackClick(Sender: TObject);
begin
  actTabChange_RetailList.Execute();
end;

procedure Tfrm_PoS.RetailRefresh();
var
  LPayMinutes,
  LStartPayMinutes,
  LEndPayMinutes: LongWord;

  LPayValue,
  LPayValueCard,
  LPayValueCash,
  LPayValuePix,
  LPayValueOther,
  LPayValueDiscount,
  LPayValueFree,

  LStartPayValue,
  LStartPayValueCard,
  LStartPayValueCash,
  LStartPayValuePix,
  LStartPayValueOther,
  LStartPayValueDiscount,
  LStartPayValueFree,

  LEndPayValue,
  LEndPayValueCard,
  LEndPayValueCash,
  LEndPayValuePix,
  LEndPayValueOther,
  LEndPayValueDiscount,
  LEndPayValueFree : Currency;

  LObs: String;

  LPoSName: String;
  LDate   : TDate;

begin
  LPayMinutes           := 0;
  LPayValue             := 0.00;
  LPayValueCard         := 0.00;
  LPayValueCash         := 0.00;
  LPayValuePix          := 0.00;
  LPayValueOther        := 0.00;
  LPayValueDiscount     := 0.00;
  LPayValueFree         := 0.00;

  LStartPayMinutes      := 0;
  LStartPayValue        := 0.00;
  LStartPayValueCard    := 0.00;
  LStartPayValueCash    := 0.00;
  LStartPayValuePix     := 0.00;
  LStartPayValueOther   := 0.00;
  LStartPayValueDiscount:= 0.00;
  LStartPayValueFree    := 0.00;

  LEndPayMinutes        := 0;
  LEndPayValue          := 0.00;
  LEndPayValueCard      := 0.00;
  LEndPayValueCash      := 0.00;
  LEndPayValuePix       := 0.00;
  LEndPayValueOther     := 0.00;
  LEndPayValueDiscount  := 0.00;
  LEndPayValueFree      := 0.00;

  LObs                  := '';

  LPoSName := 'Error';
  LDate    := 0;

  if not dm_Main.tb_PoS.Locate('id', GuidToString(FPoSID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.RetailRefresh.tb_PoS.Locate');
      Exit;
    end;

  if FCashRegisterDate = 0 then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.DetailRefresh.CashRegisterDate=0');
      Exit;
    end;

  if not dm_Main.tb_Rental.Locate('id', GuidToString(FRentalID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.DetailRefresh.tb_Rental.Locate');
      Exit;
    end;

  LPoSName := dm_Main.tb_PoS.FieldByName('name').AsString;
  LDate    := FCashRegisterDate;

  LStartPayMinutes       := dm_Main.tb_Rental.FieldByName('startPayMinutes'       ).AsInteger;
  LStartPayValue         := dm_Main.tb_Rental.FieldByName('startPayValue'         ).AsCurrency;
  LStartPayValueCard     := dm_Main.tb_Rental.FieldByName('startPayValueCard'     ).AsCurrency;
  LStartPayValueCash     := dm_Main.tb_Rental.FieldByName('startPayValueCash'     ).AsCurrency;
  LStartPayValuePix      := dm_Main.tb_Rental.FieldByName('startPayValuePix'      ).AsCurrency;
  LStartPayValueOther    := dm_Main.tb_Rental.FieldByName('startPayValueOther'    ).AsCurrency;
  if dm_Main.tb_Rental.FieldByName('startPayValue').AsCurrency  <> 0 then
    begin
      LStartPayValueDiscount := dm_Main.tb_Rental.FieldByName('startPayValueDiscount'    ).AsCurrency;
    end
  else
    begin
      LStartPayValueFree     := dm_Main.tb_Rental.FieldByName('startPayValueDiscount'        ).AsCurrency;
    end;

  LEndPayMinutes       := dm_Main.tb_Rental.FieldByName('endPayMinutes'       ).AsInteger;
  LEndPayValue         := dm_Main.tb_Rental.FieldByName('endPayValue'         ).AsCurrency;
  LEndPayValueCard     := dm_Main.tb_Rental.FieldByName('endPayValueCard'     ).AsCurrency;
  LEndPayValueCash     := dm_Main.tb_Rental.FieldByName('endPayValueCash'     ).AsCurrency;
  LEndPayValuePix      := dm_Main.tb_Rental.FieldByName('endPayValuePix'      ).AsCurrency;
  LEndPayValueOther    := dm_Main.tb_Rental.FieldByName('endPayValueOther'    ).AsCurrency;
  if dm_Main.tb_Rental.FieldByName('endPayValue').AsCurrency  <> 0 then
    begin
      LEndPayValueDiscount := dm_Main.tb_Rental.FieldByName('endPayValueDiscount'    ).AsCurrency;
    end
  else
    begin
      LEndPayValueFree     := dm_Main.tb_Rental.FieldByName('endPayValueDiscount'        ).AsCurrency;
    end;
  LObs           := dm_Main.tb_Rental.FieldByName('obs'    ).AsString;

  LPayMinutes       := LStartPayMinutes       + LEndPayMinutes;
  LPayValue         := LStartPayValue         + LEndPayValue;
  LPayValueCard     := LStartPayValueCard     + LEndPayValueCard;
  LPayValueCash     := LStartPayValueCash     + LEndPayValueCash;
  LPayValuePix      := LStartPayValuePix      + LEndPayValuePix;
  LPayValueOther    := LStartPayValueOther    + LEndPayValueOther;
  LPayValueDiscount := LStartPayValueDiscount + LEndPayValueDiscount;
  LPayValueFree     := LStartPayValueFree     + LEndPayValueFree;

  lbl_RetailTitlePoS.Text              := LPoSName;
  lbl_RetailTitleDate.Text             := FormatDateTime('dd/mm/yyyy', LDate);

  lbl_DetailCount.Text                 := Format        ('%0.2d'     ,[dm_Main.tb_Rental.FieldByName('cashRegisterCount').AsInteger]);
  lbl_DetailBoatNumber.Text            :=                              dm_Main.tb_Rental.FieldByName('boatNumber'       ).AsString;
  lbl_DetailStartDayDate.Text          := FormatDateTime('dd/mm/yyyy', dm_Main.tb_Rental.FieldByName('startAt'          ).AsDateTime);
  lbl_DetailStartDayTime.Text          := FormatDateTime('hh:mm:ss'  , dm_Main.tb_Rental.FieldByName('startAt'          ).AsDateTime);
  lbl_DetailEndDayDate.Text            := FormatDateTime('dd/mm/yyyy', dm_Main.tb_Rental.FieldByName('endAt'            ).AsDateTime);
  lbl_DetailEndDayTime.Text            := FormatDateTime('hh:mm:ss'  , dm_Main.tb_Rental.FieldByName('endAt'            ).AsDateTime);

  lbl_DetailPayMinutes.Text            := Format     ('%d'  , [LPayMinutes      ]);
  lbl_DetailPayValue.Text              := FormatFloat('0.00',  LPayValue         );
  lbl_DetailPayValueCard.Text          := FormatFloat('0.00',  LPayValueCard     );
  lbl_DetailPayValueCash.Text          := FormatFloat('0.00',  LPayValueCash     );
  lbl_DetailPayValuePix.Text           := FormatFloat('0.00',  LPayValuePix      );
  lbl_DetailPayValueOther.Text         := FormatFloat('0.00',  LPayValueOther    );
  lbl_DetailPayValueDiscount.Text      := FormatFloat('0.00',  LPayValueDiscount );
  lbl_DetailPayValueFree.Text          := FormatFloat('0.00',  LPayValueFree     );

  lbl_DetailStartPayMinutes.Text       := Format     ('%d'  , [LStartPayMinutes     ]);
  lbl_DetailStartPayValue.Text         := FormatFloat('0.00',  LStartPayValue        );
  lbl_DetailStartPayValueCard.Text     := FormatFloat('0.00',  LStartPayValueCard    );
  lbl_DetailStartPayValueCash.Text     := FormatFloat('0.00',  LStartPayValueCash    );
  lbl_DetailStartPayValuePix.Text      := FormatFloat('0.00',  LStartPayValuePix     );
  lbl_DetailStartPayValueOther.Text    := FormatFloat('0.00',  LStartPayValueOther   );
  lbl_DetailStartPayValueDiscount.Text := FormatFloat('0.00',  LStartPayValueDiscount);
  lbl_DetailStartPayValueFree.Text     := FormatFloat('0.00',  LStartPayValueFree    );

  lbl_DetailEndPayMinutes.Text         := Format     ('%d'  , [LEndPayMinutes      ]);
  lbl_DetailEndPayValue.Text           := FormatFloat('0.00',  LEndPayValue         );
  lbl_DetailEndPayValueCard.Text       := FormatFloat('0.00',  LEndPayValueCard     );
  lbl_DetailEndPayValueCash.Text       := FormatFloat('0.00',  LEndPayValueCash     );
  lbl_DetailEndPayValuePix.Text        := FormatFloat('0.00',  LEndPayValuePix      );
  lbl_DetailEndPayValueOther.Text      := FormatFloat('0.00',  LEndPayValueOther    );
  lbl_DetailEndPayValueDiscount.Text   := FormatFloat('0.00',  LEndPayValueDiscount );
  lbl_DetailEndPayValueFree.Text       := FormatFloat('0.00',  LEndPayValueFree     );

  mm_DetailObs.Text                    := LObs;
end;


// *****************************************************************************
// CASH REGISTER
// *****************************************************************************

procedure Tfrm_PoS.btn_CashRegisterCloseClick(Sender: TObject);
begin
  if FPoSID = GUID_NULL then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterCloseClick.FPoSID');
      Exit;
    end;


  TDialogService.MessageDialog( 'Confirmar fechamento de caixa?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  var
                                    LDay : TDate;
                                  begin
                                    if AResult = mrYes then
                                      begin

                                        if not dm_Main.tb_PoS.Locate('id', GuidToString(FPoSID)) then
                                          begin
                                            TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterCloseClick.tb_PoS.Locate');
                                            Exit;
                                          end;


                                        if FCashRegisterDate = 0 then
                                          begin
                                            TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterCloseClick.FCashRegisterDate');
                                            Exit;
                                          end;

                                        if not dm_Main.tb_CashRegister.Locate('date;posId', VarArrayOf([FCashRegisterDate, GUIDToString(FPoSID)])) then
                                          begin
                                            TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterCloseClick.tb_CashRegister.Locate');
                                            Exit;
                                          end;


                                        dm_Main.tb_CashRegister.Edit;
                                        dm_Main.tb_CashRegister.FieldByName('open' ).AsBoolean := False;
                                        dm_Main.tb_CashRegister.Post;
                                        dm_Main.tb_CashRegister.SaveToFile();

                                        CashRegisterRefresh();

                                      end;
                                  end);

end;


procedure Tfrm_PoS.btn_CashRegisterShowOpenClick(Sender: TObject);
begin
  edt_OpenDay.Date := Now();
//  edt_OpenDay.Enabled := PoSAdmin;
  actTabChange_CashRegisterOpen.Execute;
  edt_OpenDay.SetFocus;
end;

procedure Tfrm_PoS.btn_CashRegisterValidateClick(Sender: TObject);
begin
  if not dm_Main.tb_PoS.Locate('id', GuidToString(FPoSID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterValidateClick.tb_PoS.Locate');
      Exit;
    end;

  if FCashRegisterDate = 0 then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterValidateClick.CashRegisterDate=0');
      Exit;
    end;

  if not dm_Main.tb_CashRegister.Locate('date;posId', VarArrayOf([FCashRegisterDate, GUIDToString(FPoSID)])) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterValidateClick.tb_CashRegister.Locate');
      Exit;
    end;

  if dm_Main.tb_CashRegister.FieldByName('open').AsBoolean then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterValidateClick.tb_CashRegister.open');
      Exit;
    end;

  if dm_Main.tb_CashRegister.FieldByName('validated').AsBoolean then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterValidateClick.tb_CashRegister.validated');
      Exit;
    end;

  dm_Main.tb_CashRegister.Edit;
  dm_Main.tb_CashRegister.FieldByName('validated').AsBoolean := true;
  dm_Main.tb_CashRegister.FieldByName('validatedAt').AsDateTime := Now;
  dm_Main.tb_CashRegister.Post;
  dm_Main.tb_CashRegister.SaveToFile();

  CashRegisterRefresh();
end;

procedure Tfrm_PoS.btn_CashRegisterValidatedClick(Sender: TObject);
begin
 if not dm_Main.tb_PoS.Locate('id', GuidToString(FPoSID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterValidatedClick.tb_PoS.Locate');
      Exit;
    end;

  if FCashRegisterDate = 0 then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterValidatedClick.CashRegisterDate=0');
      Exit;
    end;

  if not dm_Main.tb_CashRegister.Locate('date;posId', VarArrayOf([FCashRegisterDate, GUIDToString(FPoSID)])) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterValidatedClick.tb_CashRegister.Locate');
      Exit;
    end;

  if dm_Main.tb_CashRegister.FieldByName('open').AsBoolean then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterValidatedClick.tb_CashRegister.open');
      Exit;
    end;

  if not dm_Main.tb_CashRegister.FieldByName('validated').AsBoolean then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterValidatedClick.tb_CashRegister.validated');
      Exit;
    end;

  dm_Main.tb_CashRegister.Edit;
  dm_Main.tb_CashRegister.FieldByName('validated').AsBoolean := false;
  dm_Main.tb_CashRegister.FieldByName('validatedAt').Clear;
  dm_Main.tb_CashRegister.Post;
  dm_Main.tb_CashRegister.SaveToFile();

  CashRegisterRefresh();
end;

procedure Tfrm_PoS.btn_CashRegisterOpenBackClick(Sender: TObject);
begin
  actTabChange_CashRegisterList.Execute;
end;

procedure Tfrm_PoS.btn_CashRegisterOpenClick(Sender: TObject);
var
  _id    : TGUID;
  LDay   : TDate;
  LInitialCash : Double;
begin
  LDay   := edt_OpenDay.Date;

  if FPoSID = GUID_NULL then
    begin
      Exit;
    end;

  if dm_Main.tb_CashRegister.Locate('posId;open', VarArrayOf([GUIDToString(FPoSID), True])) then
    begin
      TDialogService.ShowMessage('O Ponto de Serviço já tem um caixa aberto no dia ' + FormatDateTime('dd/mm/yyyy', dm_Main.tb_CashRegister.FieldByName('date').AsDateTime));
      Exit;
    end;


  if dm_Main.tb_CashRegister.Locate('posId;date', VarArrayOf([GUIDToString(FPoSID), LDay])) then
    begin
      TDialogService.MessageDialog( 'Deseja reabrir o caixa do dia ' + FormatDateTime('dd/mm/yyyy', LDay) + '?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                    procedure(const AResult: TModalResult)
                                      begin
                                        if AResult = mrYes then
                                          begin
                                            if LDay > Now().GetDate then
                                              begin
                                                TDialogService.ShowMessage('Não é permitido abrir um Ponto de Venda com data futura.');
                                                Exit;
                                              end;

                                            if not dm_Main.tb_PoS.Locate('id', GUIDToString(FPoSID)) then
                                              begin
                                                TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterOpenClick.MessageDialog.tb_PoS.Locate');
                                                Exit;
                                              end;

                                            if dm_Main.tb_CashRegister.Locate('posId;open', VarArrayOf([GUIDToString(FPoSID), True])) then
                                              begin
                                                TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterOpenClick.MessageDialog.tb_CashRegister.Locate.open');
                                                Exit;
                                              end;


                                            if not dm_Main.tb_CashRegister.Locate('posId;date', VarArrayOf([GUIDToString(FPoSID), LDay])) then
                                              begin
                                                TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterOpenClick.MessageDialog.tb_CashRegister.Locate.date');
                                                Exit;
                                              end;

                                            if dm_Main.tb_CashRegister.FieldByName('validated').AsBoolean then
                                              begin
                                                TDialogService.ShowMessage('O caixa do dia ' + FormatDateTime('dd/mm/yyyy', LDay)+ ' já foi validado e bloqueado.');
                                                Exit;
                                              end;

                                            dm_Main.tb_CashRegister.Edit;
                                            dm_Main.tb_CashRegister.FieldByName('open').AsBoolean := True;
                                            dm_Main.tb_CashRegister.Post;
                                            dm_Main.tb_CashRegister.SaveToFile();

                                            CashRegisterRefresh();

                                            actTabChange_CashRegister.Execute();
                                          end
                                      end);
      Exit;
    end;

  if not PoSAdmin then
    begin
      if LDay > Now().GetDate then
        begin
          TDialogService.ShowMessage('Não é permitido abrir um Ponto de Venda com data futura.');
          Exit;
        end;

      if LDay < Now().GetDate then
        begin
          TDialogService.ShowMessage('Não é permitido abrir um Ponto de Venda com data passada.');
          Exit;
        end;
    end;

  if not dm_Main.tb_PoS.Locate('id', GUIDToString(FPoSID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterOpenClick.tb_PoS.Locate');
      Exit;
    end;

  dm_Main.tb_CashRegister.Append;
  dm_Main.tb_CashRegister.FieldByName('id'   ).AsString   := FormatDateTime('yyyymmdd', LDay) + '_' + GuidToString(FPoSID).Replace('{','').Replace('}','');
  dm_Main.tb_CashRegister.FieldByName('posId').AsGuid     := FPoSID;
  dm_Main.tb_CashRegister.FieldByName('date' ).AsDateTime := LDay;
  dm_Main.tb_CashRegister.FieldByName('open' ).AsBoolean  := True;
  dm_Main.tb_CashRegister.Post;
  dm_Main.tb_CashRegister.SaveToFile();

  FCashRegisterDate := LDay;

  CashRegisterRefresh();

  actTabChange_CashRegister.Execute();
end;

// *****************************************************************************
// CASH REGISTER LIST
// *****************************************************************************

procedure Tfrm_PoS.btn_CashRegisterListBackClick(Sender: TObject);
begin
  CashRegisterRefresh();
  actTabChange_CashRegister.Execute();
end;

procedure Tfrm_PoS.btn_CashRegisterNextClick(Sender: TObject);
var
  LDate : TDate;
begin
  if FCashRegisterDate = 0 then Exit;

  LDate := FCashRegisterDate;

  dm_Main.tb_CashRegister.Filtered := false;
  if PosAdmin then
    begin
      if FPoSID = GUID_NULL then
        dm_Main.tb_CashRegister.Filter := ''
      else
        dm_Main.tb_CashRegister.Filter := 'posId = ' + QuotedStr(GUIDTOString(FPoSID));
    end
  else
    begin
      if FPoSID = GUID_NULL then
        dm_Main.tb_CashRegister.Filter := '(validated = FALSE OR validated IS NULL)'
      else
        dm_Main.tb_CashRegister.Filter := '(validated = FALSE OR validated IS NULL) AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
    end;
  dm_Main.tb_CashRegister.Filtered := true;
  try
    if not dm_Main.tb_CashRegister.Locate('date', VarArrayOf([FCashRegisterDate])) then Exit;

    dm_Main.tb_CashRegister.Next;
    LDate := dm_Main.tb_CashRegister.FieldByName('date').AsDateTime;
  finally
    dm_Main.tb_CashRegister.Filtered := false;
  end;

  FCashRegisterDate := LDate;
  CashRegisterRefresh();
end;

procedure Tfrm_PoS.lst_CashRegisterListItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  LDate : TDateTime;
begin
  if not TryISO8601ToDate(AItem.TagString, LDate) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.lst_CashRegisterListItemClick');
      Exit;
    end;

  FCashRegisterDate := LDate;
  CashRegisterRefresh;
  actTabChange_CashRegister.Execute;
end;

procedure Tfrm_PoS.CashRegisterListRefresh;
var
  LCount    : LongWord;

  LTotalPayValue,
  LTotalExpensesTotal,
  LTotal,
  LTotalInitialCash,
  LTotalCash           : Currency;

  LExpensesTotal,
  LExpensesFuel,
  LExpensesMeal,
  LExpensesDaily,
  LExpensesOther: Currency;

  LPayMinutes,
  LStartPayMinutes,
  LEndPayMinutes : LongWord;

  LPayValue,
  LPayValueCard,
  LPayValueCash,
  LPayValuePix,
  LPayValueOther,
  LPayValueDiscount,
  LPayValueFree,

  LStartPayValue,
  LStartPayValueCard,
  LStartPayValueCash,
  LStartPayValuePix,
  LStartPayValueOther,
  LStartPayValueDiscount,
  LStartPayValueFree,

  LEndPayValue,
  LEndPayValueCard,
  LEndPayValueCash,
  LEndPayValuePix,
  LEndPayValueOther,
  LEndPayValueDiscount,
  LEndPayValueFree : Currency;

  LPoSName   : String;
  LDayIsNull : Boolean;
  LDay       : TDate;
  LDayOpen   : Boolean;
  LDayBlockes: Boolean;
  LFlags     : String;

  LCashRegisterCount          : LongWord;
  LCashRegisterOpenCount      : LongWord;
  LCashRegisterValidatedCount : LongWord;

  LItem : TListViewItem;

  LDateList :TList<TDate>;
  LDate : TDate;

begin

  // ---------------------------------------------------------------------------
  // POS
  // ---------------------------------------------------------------------------
  if not dm_Main.tb_PoS.Locate('id', GUIDTOString(FPoSID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.CashRegisterListRefresh.tb_PoS');
      Exit;
    end;

  lbl_CashRegisterListTitle.Text := dm_Main.tb_PoS.FieldByName('Name').AsString;

  // ---------------------------------------------------------------------------


  LDateList := TList<TDate>.Create;
  lst_CashRegisterList.Items.BeginUpdate;
  try
    lst_CashRegisterList.Items.Clear;

    // Populate DateList -------------------------------------------------------
    dm_Main.tb_CashRegister.Filtered := false;
    if PosAdmin then
      begin
        if FPoSID = GUID_NULL then
          dm_Main.tb_CashRegister.Filter := ''
        else
          dm_Main.tb_CashRegister.Filter := 'posId = ' + QuotedStr(GUIDTOString(FPoSID));
      end
    else
      begin
        if FPoSID = GUID_NULL then
          dm_Main.tb_CashRegister.Filter := '(validated = FALSE OR validated IS NULL)'
        else
          dm_Main.tb_CashRegister.Filter := '(validated = FALSE OR validated IS NULL) AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
      end;
    dm_Main.tb_CashRegister.Filtered := true;
    try
      dm_Main.tb_CashRegister.First;
      while not dm_Main.tb_CashRegister.Eof do
        begin
          if not LDateList.Contains(dm_Main.tb_CashRegister.FieldByName('date').AsDateTime) then
            LDateList.Add(dm_Main.tb_CashRegister.FieldByName('date').AsDateTime);

          dm_Main.tb_CashRegister.Next;
        end;
    finally
      dm_Main.tb_CashRegister.Filtered := false;
    end;
    // -------------------------------------------------------------------------

//    LItem           := lst_CashRegisterList.Items.Add;
//    LItem.Purpose   := TListItemPurpose.Header;
//    LItem.Text      := 'Data';
//    LItem.Objects.FindDrawable('txtDateTime' ).Data := 'Data';
//    LItem.Objects.FindDrawable('txtCount'    ).Data := 'Quant.';
//    LItem.Objects.FindDrawable('txtValue'    ).Data := 'Total';
//    LItem.Objects.FindDrawable('txtValue2'   ).Data := 'Caixa';

    for LDate in LDateList do
      begin
        LCount                := 0;
        LFlags                := '';

        LPayValue             := 0;
        LPayValueCard         := 0;
        LPayValueCash         := 0;
        LPayValuePix          := 0;
        LPayValueOther        := 0;
        LPayValueDiscount     := 0;
        LPayValueFree         := 0;

        LPayMinutes           := 0;
        LStartPayMinutes      := 0;
        LEndPayMinutes        := 0;

        LStartPayValue        := 0.00;
        LStartPayValueCard    := 0.00;
        LStartPayValueCash    := 0.00;
        LStartPayValuePix     := 0.00;
        LStartPayValueOther   := 0.00;
        LStartPayValueDiscount:= 0.00;
        LStartPayValueFree    := 0.00;

        LEndPayValue          := 0.00;
        LEndPayValueCard      := 0.00;
        LEndPayValueCash      := 0.00;
        LEndPayValuePix       := 0.00;
        LEndPayValueOther     := 0.00;
        LEndPayValueDiscount  := 0.00;
        LEndPayValueFree      := 0.00;

        LExpensesTotal        := 0.00;
        LExpensesFuel         := 0.00;
        LExpensesMeal         := 0.00;
        LExpensesDaily        := 0.00;
        LExpensesOther        := 0.00;

        LTotalPayValue        := 0.00;
        LTotalExpensesTotal   := 0.00;
        LTotal                := 0.00;
        LTotalInitialCash     := 0.00;
        LTotalCash            := 0.00;

        LCashRegisterCount          := 0;
        LCashRegisterOpenCount      := 0;
        LCashRegisterValidatedCount := 0;

        // ---------------------------------------------------------------------------
        // Day
        // ---------------------------------------------------------------------------
        dm_Main.tb_CashRegister.Filtered := false;
        if FPoSID = GUID_NULL then
          dm_Main.tb_CashRegister.Filter := 'date = {d ' + (FormatDateTime('yyyy-mm-dd', LDate)) + '}'
        else
          dm_Main.tb_CashRegister.Filter := 'date = {d ' + (FormatDateTime('yyyy-mm-dd', LDate)) + '} AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
        dm_Main.tb_CashRegister.Filtered := true;
        try
          dm_Main.tb_CashRegister.First;
          while not dm_Main.tb_CashRegister.Eof do
            begin
              LTotalInitialCash := LTotalInitialCash + dm_Main.tb_CashRegister.FieldByName('initialCash').AsCurrency;

              LExpensesTotal := LExpensesTotal + dm_Main.tb_CashRegister.FieldByName('expensesTotal').AsCurrency;
              LExpensesMeal  := LExpensesMeal  + dm_Main.tb_CashRegister.FieldByName('expensesMeal' ).AsCurrency;
              LExpensesFuel  := LExpensesFuel  + dm_Main.tb_CashRegister.FieldByName('expensesFuel' ).AsCurrency;
              LExpensesDaily := LExpensesDaily + dm_Main.tb_CashRegister.FieldByName('expensesDaily').AsCurrency;
              LExpensesOther := LExpensesOther + dm_Main.tb_CashRegister.FieldByName('expensesOther').AsCurrency;

              LCashRegisterCount := LCashRegisterCount + 1;

              if dm_Main.tb_CashRegister.FieldByName('open').AsBoolean then
                LCashRegisterOpenCount := LCashRegisterOpenCount + 1;

              if dm_Main.tb_CashRegister.FieldByName('validated').AsBoolean then
                LCashRegisterValidatedCount := LCashRegisterValidatedCount + 1;

              dm_Main.tb_CashRegister.Next;
            end
        finally
          dm_Main.tb_CashRegister.Filtered := False;
        end;
        // ---------------------------------------------------------------------

        // ---------------------------------------------------------------------
        // RENTAL
        // ---------------------------------------------------------------------
        dm_Main.tb_Rental.Filtered := false;
        if FPoSID = GUID_NULL then
          dm_Main.tb_Rental.Filter := 'cashRegisterDate = {d ' + (FormatDateTime('yyyy-mm-dd', LDate)) + '}'
        else
          dm_Main.tb_Rental.Filter := 'cashRegisterDate = {d ' + (FormatDateTime('yyyy-mm-dd', LDate)) + '} AND posId = ' + QuotedStr(GUIDTOString(FPoSID));
        dm_Main.tb_Rental.Filtered := true;
        try
          dm_Main.tb_Rental.First;
          while not dm_Main.tb_Rental.Eof do
            begin
              LStartPayMinutes       := LStartPayMinutes       + dm_Main.tb_Rental.FieldByName('startPayMinutes'       ).AsInteger;
              LStartPayValue         := LStartPayValue         + dm_Main.tb_Rental.FieldByName('startPayValue'         ).AsCurrency;
              LStartPayValueCard     := LStartPayValueCard     + dm_Main.tb_Rental.FieldByName('startPayValueCard'     ).AsCurrency;
              LStartPayValueCash     := LStartPayValueCash     + dm_Main.tb_Rental.FieldByName('startPayValueCash'     ).AsCurrency;
              LStartPayValuePix      := LStartPayValuePix      + dm_Main.tb_Rental.FieldByName('startPayValuePix'      ).AsCurrency;
              LStartPayValueOther    := LStartPayValueOther    + dm_Main.tb_Rental.FieldByName('startPayValueOther'    ).AsCurrency;
              if dm_Main.tb_Rental.FieldByName('startPayValue').AsCurrency  <> 0 then
                begin
                  LStartPayValueDiscount := LStartPayValueDiscount    + dm_Main.tb_Rental.FieldByName('startPayValueDiscount'    ).AsCurrency;
                end
              else
                begin
                  LStartPayValueFree     := LStartPayValueFree        + dm_Main.tb_Rental.FieldByName('startPayValueDiscount'        ).AsCurrency;
                end;

              LEndPayMinutes       := LEndPayMinutes       + dm_Main.tb_Rental.FieldByName('endPayMinutes'       ).AsInteger;
              LEndPayValue         := LEndPayValue         + dm_Main.tb_Rental.FieldByName('endPayValue'         ).AsCurrency;
              LEndPayValueCard     := LEndPayValueCard     + dm_Main.tb_Rental.FieldByName('endPayValueCard'     ).AsCurrency;
              LEndPayValueCash     := LEndPayValueCash     + dm_Main.tb_Rental.FieldByName('endPayValueCash'     ).AsCurrency;
              LEndPayValuePix      := LEndPayValuePix      + dm_Main.tb_Rental.FieldByName('endPayValuePix'      ).AsCurrency;
              LEndPayValueOther    := LEndPayValueOther    + dm_Main.tb_Rental.FieldByName('endPayValueOther'    ).AsCurrency;
              if dm_Main.tb_Rental.FieldByName('endPayValue').AsCurrency  <> 0 then
                begin
                  LEndPayValueDiscount := LEndPayValueDiscount    + dm_Main.tb_Rental.FieldByName('endPayValueDiscount'    ).AsCurrency;
                end
              else
                begin
                  LEndPayValueFree     := LEndPayValueFree        + dm_Main.tb_Rental.FieldByName('endPayValueDiscount'        ).AsCurrency;
                end;

              LPayMinutes       := LStartPayMinutes       + LEndPayMinutes;
              LPayValue         := LStartPayValue         + LEndPayValue;
              LPayValueCard     := LStartPayValueCard     + LEndPayValueCard;
              LPayValueCash     := LStartPayValueCash     + LEndPayValueCash;
              LPayValuePix      := LStartPayValuePix      + LEndPayValuePix;
              LPayValueOther    := LStartPayValueOther    + LEndPayValueOther;
              LPayValueDiscount := LStartPayValueDiscount + LEndPayValueDiscount;
              LPayValueFree     := LStartPayValueFree     + LEndPayValueFree;

              dm_Main.tb_Rental.Next;
            end;
          LCount := LCount + dm_Main.tb_Rental.RecordCount;
        finally
          dm_Main.tb_Rental.Filtered := false;
        end;
        // ---------------------------------------------------------------------

        // SummaryValues  ------------------
        LTotalPayValue      := LPayValue;
        LTotalExpensesTotal := LExpensesTotal;
        LTotal              := LTotalPayValue - LTotalExpensesTotal;
        LTotalCash          := LTotalInitialCash + LPayValueCash - LTotalExpensesTotal;


        // Update List ------------------
        LItem           := lst_CashRegisterList.Items.Add;
        LItem.TagString := FormatDatetime('yyyy-mm-dd', dm_Main.tb_CashRegister.FieldByName('date').AsDateTime);

//        LItem.Objects.FindDrawable('txtDateTime' ).Data :=  dm_Main.tb_CashRegister.FieldByName('id').AsString;
        LItem.Objects.FindDrawable('txtDateTime' ).Data := FormatDatetime('dd/mm/yyyy', dm_Main.tb_CashRegister.FieldByName('date').AsDateTime);
        LItem.Objects.FindDrawable('txtCount'    ).Data := Format('%0.2d', [LCount]);
        LItem.Objects.FindDrawable('txtValue'    ).Data := FormatFloat('0.00', LTotal    );
        LItem.Objects.FindDrawable('txtValue2'   ).Data := FormatFloat('0.00', LTotalCash);

        if LCashRegisterCount > 0 then
          begin
            if LCashRegisterValidatedCount = 0 then
              LFlags := LFlags + '🔲'
            else if LCashRegisterValidatedCount < LCashRegisterCount then
              LFlags := LFlags + '🔳'
            else
              LFlags := LFlags + '✅';

            if LCashRegisterOpenCount = 0 then
              LFlags := LFlags + '⚪'
            else if LCashRegisterOpenCount < LCashRegisterCount then
              LFlags := LFlags + '⚫'
            else
              LFlags := LFlags + '🔵';
          end
        else
          begin
            LFlags := '🔲🔵';
          end;

        LItem.Objects.FindDrawable('txtFlags').Data := LFlags;

        dm_Main.tb_CashRegister.Next;

      end;
  finally
    lst_CashRegisterList.Items.EndUpdate;
    LDateList.Free;
  end;
  // ---------------------------------------------------------------------------

end;

// ------------------------------------------------------------------------------------------------
// Cash Register Input
// ------------------------------------------------------------------------------------------------

procedure Tfrm_PoS.btn_CashRegisterInputBackClick(Sender: TObject);
begin
  actTabChange_CashRegister.Execute;
end;


procedure Tfrm_PoS.btn_CashRegisterInputOKClick(Sender: TObject);
var
  LValue: Double;
  LFieldExpense: TField;
begin
  if not (edt_CashRegisterInput.TagObject is TField) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterInputOKClick.TagObject');
      Exit;
    end;

  if not TryStrToFloat(edt_CashRegisterInput.Text, LValue) then
    begin
      TDialogService.ShowMessage('Valor inválido.'#$d#$a'Formato: 0,00');
      Exit;
    end;

  LValue        := RoundTo(LValue, -2);
  LFieldExpense := edt_CashRegisterInput.TagObject as TField;

  if not dm_Main.tb_PoS.Locate('id', GuidToString(FPoSID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterInputOKClick.tb_PoS.Locate');
      Exit;
    end;

  if FCashRegisterDate = 0 then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterInputOKClick.CashRegisterDate=0');
      Exit;
    end;

  if not dm_Main.tb_CashRegister.Locate('date;posId', VarArrayOf([FCashRegisterDate, GUIDToString(FPoSID)])) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.btn_CashRegisterInputOKClick.tb_CashRegister.Locate');
      Exit;
    end;

  if not dm_Main.tb_CashRegister.FieldByName('open').AsBoolean then
    begin
      TDialogService.ShowMessage('O caixa o Ponto de Vendas não esta aberto.');
      Exit;
    end;



  dm_Main.tb_CashRegister.Edit;
  LFieldExpense.AsCurrency := LValue;
  dm_Main.tb_CashRegister.Post;
  dm_Main.tb_CashRegister.SaveToFile();

  CashRegisterRefresh();
  actTabChange_CashRegister.Execute;
end;

procedure Tfrm_PoS.ShowDialogExpense(argCaption: String;
  argLabelExpense: Tlabel; argFieldExpense: TField);
begin
  lbl_CashRegisterInput.Text      := argCaption;
  edt_CashRegisterInput.Text      := argLabelExpense.Text;
  edt_CashRegisterInput.TagObject := argFieldExpense;
  actTabChange_CashRegisterInput.Execute;
  edt_CashRegisterInput.SetFocus;
end;


//
//procedure Tfrm_PoS.ShowDialogExpense(argCaption: String;
//  argLabelExpense: Tlabel; argFieldExpense: TField);
//begin
//  TDialogService.InputQuery(argCaption, [''], [argLabelExpense.Text],
//    procedure(const AResult: TModalResult; const AValues: array of string)
//    var
//      LValue: Double;
//    begin
//      frm_Main.Padding.Bottom := 0;
//      if AResult = mrOK then
//        begin
//          if TryStrToFloat(AValues[0], LValue) then
//            begin
//              LValue := RoundTo(LValue, -2);
//
//              if not dm_Main.tb_PoS.Locate('id', GuidToString(FPoSID)) then
//                begin
//                  TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.ShowDialogExpense.InputQuery.tb_PoS.Locate');
//                  Exit;
//                end;
//
//              if FCashRegisterDate = 0 then
//                begin
//                  TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.ShowDialogExpense.InputQuery.CashRegisterDate=0');
//                  Exit;
//                end;
//
//              if not dm_Main.tb_CashRegister.Locate('date;posId', VarArrayOf([FCashRegisterDate, GUIDToString(FPoSID)])) then
//                begin
//                  TDialogService.ShowMessage(UNEXPECTED_ERROR + 'PoS.ShowDialogExpense.InputQuery.tb_CashRegister.Locate');
//                  Exit;
//                end;
//
//              if not dm_Main.tb_CashRegister.FieldByName('open').AsBoolean then
//                begin
//                  TDialogService.ShowMessage('O caixa o Ponto de Vendas não esta aberto.');
//                  Exit;
//                end;
//
//              dm_Main.tb_CashRegister.Edit;
//              argFieldExpense.AsCurrency := LValue;
//              dm_Main.tb_CashRegister.Post;
//              dm_Main.tb_CashRegister.SaveToFile();
//
//              CashRegisterRefresh();
//            end
//          else
//            begin
//              ShowMessage('Valor inválido.'#$d#$a'Formato: 0,00');
//              ShowDialogExpense(argCaption, argLabelExpense, argFieldExpense);
//            end;
//        end;
//    end);
//end;

end.
