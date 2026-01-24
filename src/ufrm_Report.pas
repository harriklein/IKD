unit ufrm_Report;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  Data.DB, FMX.DialogService, FireDAC.Comp.DataSet,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Edit, FMX.Objects, FMX.Effects,
  FMX.Controls.Presentation, FMX.ListView, FMX.TabControl, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  System.Actions, FMX.ActnList, FMX.ListBox, FMX.Colors, FMX.EditBox,
  FMX.NumberBox, FMX.Layouts, FMX.DateTimeCtrls, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo;

const
  POS_NONE     : TGUID  = '{00000000-0000-0000-0000-000000000000}';

type
  Tfrm_Report = class(TFrame)
    tabCtrl_List: TTabControl;
    tabItem_PoSList: TTabItem;
    lst_PoS: TListView;
    toolBar_List: TToolBar;
    shadow_List: TShadowEffect;
    tabItem_Edit: TTabItem;
    toolBar_Edit: TToolBar;
    shadow_Edit: TShadowEffect;
    btn_EditSave: TSpeedButton;
    path_EditSave: TPath;
    btn_EditCancel: TSpeedButton;
    path_EditCancel: TPath;
    btn_Delete: TSpeedButton;
    switch_EditActive: TSwitch;
    lbl_Active: TLabel;
    vScrollBox_Edit: TVertScrollBox;
    layoutFlow_Edit: TFlowLayout;
    layout_Edit: TLayout;
    edt_EditName: TEdit;
    lbl_EditName: TLabel;
    lbl_EditID: TLabel;
    tabItem_Summary: TTabItem;
    vscroll_Summary: TVertScrollBox;
    layoutFlow_Summary: TFlowLayout;
    layout_Summary: TLayout;
    ActionList1: TActionList;
    actTabChange_List: TChangeTabAction;
    actTabChange_Edit: TChangeTabAction;
    actTabChange_Day: TChangeTabAction;
    toolBar_Summary: TToolBar;
    shadow_Summary2: TShadowEffect;
    lbl_SummaryMainTitle: TLabel;
    btn_SummaryBack: TSpeedButton;
    tabItem_Open: TTabItem;
    toolBar_Open: TToolBar;
    ShadowEffect1: TShadowEffect;
    btn_Open: TSpeedButton;
    path_Open: TPath;
    vScrollBox_Open: TVertScrollBox;
    layoutFlow_Open: TFlowLayout;
    layout_Open: TLayout;
    edt_OpenDay: TDateEdit;
    edt_OpenDayTitle: TLabel;
    btn_OpenBack: TSpeedButton;
    actTabChange_Open: TChangeTabAction;
    tabItem_DetailList: TTabItem;
    lst_Rental: TListView;
    ToolBar1: TToolBar;
    btn_DetailListBack: TSpeedButton;
    lbl_DetailListTitlePoS: TLabel;
    ToolBar2: TToolBar;
    ShadowEffect4: TShadowEffect;
    lbl_DetailListTitleDay: TLabel;
    tabItem_Detail: TTabItem;
    VertScrollBox1: TVertScrollBox;
    FlowLayout1: TFlowLayout;
    Layout1: TLayout;
    ToolBar3: TToolBar;
    lbl_DetailTitlePoS: TLabel;
    btn_DetailBack: TSpeedButton;
    Rectangle7: TRectangle;
    Rectangle10: TRectangle;
    Label1: TLabel;
    ShadowEffect2: TShadowEffect;
    mm_DetailObs: TMemo;
    ShadowEffect6: TShadowEffect;
    ToolBar5: TToolBar;
    lbl_DetailTitleDay: TLabel;
    actTabChange_DetailList: TChangeTabAction;
    actTabChange_Detail: TChangeTabAction;
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
    toolBar_Summary2: TToolBar;
    btn_SummaryPrevious: TSpeedButton;
    btn_SummaryNext: TSpeedButton;
    rect_Summary: TRectangle;
    shadow_SummaryDay: TShadowEffect;
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
    Rectangle22: TRectangle;
    Label18: TLabel;
    lbl_SummaryCount: TLabel;
    rect_SummaryExpenses: TRectangle;
    rect_Expenses: TRectangle;
    lbl_ExpensesTitle: TLabel;
    lbl_ExpensesRS: TLabel;
    lbl_Expenses: TLabel;
    shadow_SummaryExpenses: TShadowEffect;
    rect_ExpensesOther: TRectangle;
    lbl_ExpensesOtherTitle: TLabel;
    lbl_ExpensesOtherRS: TLabel;
    lbl_ExpensesOther: TLabel;
    rect_ExpensesDaily: TRectangle;
    lbl_ExpensesDailyTitle: TLabel;
    lbl_ExpensesDailyRS: TLabel;
    lbl_ExpensesDaily: TLabel;
    rect_ExpensesFuel: TRectangle;
    lbl_ExpensesFuelTitle: TLabel;
    lbl_ExpensesFuelRS: TLabel;
    lbl_ExpensesFuel: TLabel;
    rect_ExpensesMeal: TRectangle;
    lbl_ExpensesMealTitle: TLabel;
    lbl_ExpensesMealRS: TLabel;
    lbl_ExpensesMeal: TLabel;
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
    Rectangle35: TRectangle;
    Rectangle60: TRectangle;
    Rectangle61: TRectangle;
    Label16: TLabel;
    Label19: TLabel;
    lbl_SummaryInitialCash: TLabel;
    edt_Date: TDateEdit;
    btn_SummaryDayBlock: TButton;
    btn_SummaryDayUnblock: TButton;
    procedure lst_PoSPullRefresh(Sender: TObject);
    procedure lst_PoSItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btn_SummaryBackClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btn_ShowDetailListClick(Sender: TObject);
    procedure lst_RentalItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btn_DetailBackClick(Sender: TObject);
    procedure btn_DetailListBackClick(Sender: TObject);
    procedure btn_SummaryPreviousClick(Sender: TObject);
    procedure btn_SummaryNextClick(Sender: TObject);
    procedure edt_DateChange(Sender: TObject);
    procedure btn_SummaryDayBlockClick(Sender: TObject);
    procedure btn_SummaryDayUnblockClick(Sender: TObject);
  private
    { Private declarations }
    // BASIC HANDLE
    FApplyUpdatesErrorMessage: String;
    FGetErrorMessage         : String;
    FPoSID                   : TGUID;
    FPoSName                 : String;
    FDay                     : TDate;
    FBoatID                  : TGUID;
    FBoatNumber              : String;
    FCount                   : Integer;

    procedure PoSListRefresh();
    procedure SummaryRefresh();
    procedure DetailListRefresh();
    procedure DetailRefresh(ARentalID: String);

    procedure Block(ABlock: Boolean);

  public
    { Public declarations }
    // BASIC HANDLE: Prepare; ApplyUpdates; Refresh
    procedure Prepare;

    procedure RefreshTerminated(Sender: TObject);

    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown (Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);

  end;



implementation

{$R *.fmx}

uses udm_Main, ufrm_Main, ufrm_Waiting, unt_VSoftUUIDv7, Math, ufrm_Boat;

//------------------------------------------------------------------------------
// BASE HANDLE
//      Prepare
//      ApplyUpdates
//      Refresh
//------------------------------------------------------------------------------

procedure Tfrm_Report.Prepare();       // Call it before open the frame
begin
  if not PoSAdmin then Exit;

  dm_Main.tb_CashRegister.Active    := False;
  dm_Main.tb_PoS.Active    := False;
  dm_Main.tb_Rental.Active := False;

  dm_Main.tb_CashRegister.Filtered    := False;
  dm_Main.tb_PoS.Filtered    := False;
  dm_Main.tb_Rental.Filtered := False;

  dm_Main.tb_CashRegister.LoadFromFile();
  dm_Main.tb_PoS.LoadFromFile();
  dm_Main.tb_Rental.LoadFromFile();

  dm_Main.tb_CashRegister.Active    := True;
  dm_Main.tb_PoS.Active    := True;
  dm_Main.tb_Rental.Active := True;

  PoSListRefresh();                          // or if we are currently in offline mode

  tabCtrl_List.ActiveTab  := tabItem_PoSList;
  btn_SummaryBack.Visible := True;
end;


procedure Tfrm_Report.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  //
end;

procedure Tfrm_Report.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  //
end;

// -----------------------------------------------------------------------------

procedure Tfrm_Report.RefreshTerminated(Sender: TObject);
begin

end;

// *****************************************************************************
// POS List
// *****************************************************************************

procedure Tfrm_Report.lst_PoSPullRefresh(Sender: TObject);
begin
  PoSListRefresh();
end;

procedure Tfrm_Report.lst_PoSItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if AItem.TagString = GuidToString(GUID_NULL) then  // All PoS
    begin
      FPoSID   := GUID_NULL;
      FPoSName := 'Todos';
      FDay     := Now();
    end
  else
    begin
      // Check Integrity
      if not dm_Main.tb_PoS.Locate( 'id', AItem.TagString, [] ) then
        begin
          TDialogService.ShowMessage(UNEXPECTED_ERROR + 'Report.lst_PoSItemClick');
          Exit;
        end;

      FPoSID   := dm_Main.tb_PoS.FieldByName('id'  ).AsGuid;
      FPoSName := dm_Main.tb_PoS.FieldByName('Name').AsString;
      FDay     := Now();

    end;

  SummaryRefresh();

  actTabChange_Day.Execute();
end;

// -----------------------------------------------------------------------------

procedure Tfrm_Report.PoSListRefresh();
var
  LItem : TListViewItem;
begin

  lst_PoS.Items.BeginUpdate();
  try
    dm_Main.tb_PoS.First();
    lst_PoS.Items.Clear();
    LItem := lst_PoS.Items.Add();
    LItem.TagString := GUIDToString(POS_NONE);
    LItem.Objects.FindDrawable('txtName').Data := 'Todos';

    while not dm_Main.tb_PoS.Eof do
      begin
        LItem           := lst_PoS.Items.Add();
        LItem.TagString := dm_Main.tb_PoS.FieldByName('id').AsString;

        LItem.Objects.FindDrawable('txtName').Data := dm_Main.tb_PoS.FieldByName('Name').AsString;
        if dm_Main.tb_PoS.FieldByName('Active').AsBoolean then
          LItem.Objects.FindDrawable('txtActive').Data := '🔵'
        else
          LItem.Objects.FindDrawable('txtActive').Data := '⚫';

        dm_Main.tb_PoS.Next();
      end;
  finally
    lst_PoS.Items.EndUpdate();
  end;

  if frm_Main.Sync = ssOffline then       // If it is in offline mode, we dont need to sync
    begin
      Waiting_Show();
      // Something that we need to do, if it is in offline mode
      Waiting_Hide();
      Exit;
    end;
end;

// *****************************************************************************
// SUMMARY
// *****************************************************************************

procedure Tfrm_Report.btn_SummaryBackClick(Sender: TObject);
begin
  PoSListRefresh();
  actTabChange_List.Execute;
end;

procedure Tfrm_Report.btn_SummaryDayBlockClick(Sender: TObject);
begin
  TDialogService.MessageDialog( 'Deseja validar e bloquear o caixa?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  begin
                                    if AResult = mrYes then
                                      begin
                                        Block(True);
                                      end
                                  end);
end;

procedure Tfrm_Report.btn_SummaryDayUnblockClick(Sender: TObject);
begin
  TDialogService.MessageDialog( 'Deseja desbloquear o caixa?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  begin
                                    if AResult = mrYes then
                                      begin
                                        Block(False);
                                      end
                                  end);
end;

procedure Tfrm_Report.btn_SummaryNextClick(Sender: TObject);
begin
  edt_Date.Date := edt_Date.Date + 1;
end;

procedure Tfrm_Report.btn_SummaryPreviousClick(Sender: TObject);
begin
  edt_Date.Date := edt_Date.Date - 1;
end;

procedure Tfrm_Report.btn_ShowDetailListClick(Sender: TObject);
begin
  DetailListRefresh();
  actTabChange_DetailList.Execute();
end;


procedure Tfrm_Report.SpeedButton1Click(Sender: TObject);
begin

end;

// -----------------------------------------------------------------------------

procedure Tfrm_Report.SummaryRefresh();
var
  LCount    : LongWord;

  LBlocked : Boolean;
  LBlockShow: Boolean;

  LSummaryPayValue,
  LSummaryExpenses,
  LSummaryTotal,
  LSummaryCash,
  LSummaryInitialCash : Double;

  LExpenses,
  LExpensesMeal,
  LExpensesFuel,
  LExpensesDaily,
  LExpensesOther : Double;

  LPayMinutes,
  LPayValue,
  LPayValueCard,
  LPayValueCash,
  LPayValuePix,
  LPayValueOther,
  LPayValueDiscount,
  LPayValueFree,

  LStartPayMinutes,
  LStartPayValue,
  LStartPayValueCard,
  LStartPayValueCash,
  LStartPayValuePix,
  LStartPayValueOther,
  LStartPayValueDiscount,
  LStartPayValueFree,

  LEndPayMinutes,
  LEndPayValue,
  LEndPayValueCard,
  LEndPayValueCash,
  LEndPayValuePix,
  LEndPayValueOther,
  LEndPayValueDiscount,
  LEndPayValueFree : LongWord;

begin
  // Clear Vars, make sure it starts with 0
  LCount                := 0;

  LPayMinutes           := 0;
  LPayValue             := 0;
  LPayValueCard         := 0;
  LPayValueCash         := 0;
  LPayValuePix          := 0;
  LPayValueOther        := 0;
  LPayValueDiscount     := 0;
  LPayValueFree         := 0;

  LStartPayMinutes      := 0;
  LStartPayValue        := 0;
  LStartPayValueCard    := 0;
  LStartPayValueCash    := 0;
  LStartPayValuePix     := 0;
  LStartPayValueOther   := 0;
  LStartPayValueDiscount:= 0;
  LStartPayValueFree    := 0;

  LEndPayMinutes        := 0;
  LEndPayValue          := 0;
  LEndPayValueCard      := 0;
  LEndPayValueCash      := 0;
  LEndPayValuePix       := 0;
  LEndPayValueOther     := 0;
  LEndPayValueDiscount  := 0;
  LEndPayValueFree      := 0;

  LExpenses             := 0.00;
  LExpensesMeal         := 0.00;
  LExpensesFuel         := 0.00;
  LExpensesDaily        := 0.00;
  LExpensesOther        := 0.00;

  LSummaryPayValue      := 0.00;
  LSummaryExpenses      := 0.00;
  LSummaryTotal         := 0.00;
  LSummaryCash          := 0.00;
  LSummaryInitialCash   := 0.00;

  // Rental --------
  dm_Main.tb_Rental.Filtered := false;
  if FPoSID = GUID_NULL then  // All PoS
    begin
      // Filter only FDay
      dm_Main.tb_Rental.Filter   := 'Day = {d ' + (FormatDateTime('yyyy-mm-dd', FDay)) + '}';
    end
  else
    begin
      // Filter only FDay and FPosID
      dm_Main.tb_Rental.Filter   := 'Day = {d ' + (FormatDateTime('yyyy-mm-dd', FDay)) + '} AND PoSID = ' + QuotedStr(GUIDTOString(FPoSID));
    end;
  dm_Main.tb_Rental.Filtered := true;
  try
    dm_Main.tb_Rental.First;
    while not dm_Main.tb_Rental.Eof do
      begin

        LStartPayMinutes       := LStartPayMinutes       + dm_Main.tb_Rental.FieldByName('StartPayMinutes'       ).AsInteger;
        LStartPayValue         := LStartPayValue         + dm_Main.tb_Rental.FieldByName('StartPayValue'         ).AsInteger;
        LStartPayValueCard     := LStartPayValueCard     + dm_Main.tb_Rental.FieldByName('StartPayValueCard'     ).AsInteger;
        LStartPayValueCash     := LStartPayValueCash     + dm_Main.tb_Rental.FieldByName('StartPayValueCash'     ).AsInteger;
        LStartPayValuePix      := LStartPayValuePix      + dm_Main.tb_Rental.FieldByName('StartPayValuePix'      ).AsInteger;
        LStartPayValueOther    := LStartPayValueOther    + dm_Main.tb_Rental.FieldByName('StartPayValueOther'    ).AsInteger;
        if dm_Main.tb_Rental.FieldByName('StartPayValue').AsInteger  <> 0 then
          begin
            LStartPayValueDiscount := LStartPayValueDiscount    + dm_Main.tb_Rental.FieldByName('StartPayValueDiscount'    ).AsInteger;
          end
        else
          begin
            LStartPayValueFree     := LStartPayValueFree        + dm_Main.tb_Rental.FieldByName('StartPayValueDiscount'        ).AsInteger;
          end;

        LEndPayMinutes       := LEndPayMinutes       + dm_Main.tb_Rental.FieldByName('EndPayMinutes'       ).AsInteger;
        LEndPayValue         := LEndPayValue         + dm_Main.tb_Rental.FieldByName('EndPayValue'         ).AsInteger;
        LEndPayValueCard     := LEndPayValueCard     + dm_Main.tb_Rental.FieldByName('EndPayValueCard'     ).AsInteger;
        LEndPayValueCash     := LEndPayValueCash     + dm_Main.tb_Rental.FieldByName('EndPayValueCash'     ).AsInteger;
        LEndPayValuePix      := LEndPayValuePix      + dm_Main.tb_Rental.FieldByName('EndPayValuePix'      ).AsInteger;
        LEndPayValueOther    := LEndPayValueOther    + dm_Main.tb_Rental.FieldByName('EndPayValueOther'    ).AsInteger;
        if dm_Main.tb_Rental.FieldByName('EndPayValue').AsInteger  <> 0 then
          begin
            LEndPayValueDiscount := LEndPayValueDiscount    + dm_Main.tb_Rental.FieldByName('EndPayValueDiscount'    ).AsInteger;
          end
        else
          begin
            LEndPayValueFree     := LEndPayValueFree        + dm_Main.tb_Rental.FieldByName('EndPayValueDiscount'        ).AsInteger;
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
    LCount := dm_Main.tb_Rental.RecordCount;
  finally
    dm_Main.tb_Rental.Filtered := false;
  end;

  // Day --------
  dm_Main.tb_CashRegister.Filtered := false;
  if FPoSID = GUID_NULL then  // All PoS
    begin
      // Filter only FDay
      dm_Main.tb_CashRegister.Filter   := 'Day = {d ' + (FormatDateTime('yyyy-mm-dd', FDay)) + '}';
    end
  else
    begin
      // Filter only FDay and FPosID
      dm_Main.tb_CashRegister.Filter   := 'Day = {d ' + (FormatDateTime('yyyy-mm-dd', FDay)) + '} AND PoSID = ' + QuotedStr(GUIDTOString(FPoSID));
    end;

  dm_Main.tb_CashRegister.Filtered := true;
  try
    dm_Main.tb_CashRegister.First;
    while not dm_Main.tb_CashRegister.Eof do
      begin
        LSummaryInitialCash := LSummaryInitialCash + dm_Main.tb_CashRegister.FieldByName('InitialCash').AsFloat;

        LExpenses      := LExpenses      + dm_Main.tb_CashRegister.FieldByName('Expenses'     ).AsFloat;
        LExpensesMeal  := LExpensesMeal  + dm_Main.tb_CashRegister.FieldByName('ExpensesMeal' ).AsFloat;
        LExpensesFuel  := LExpensesFuel  + dm_Main.tb_CashRegister.FieldByName('ExpensesFuel' ).AsFloat;
        LExpensesDaily := LExpensesDaily + dm_Main.tb_CashRegister.FieldByName('ExpensesDaily').AsFloat;
        LExpensesOther := LExpensesOther + dm_Main.tb_CashRegister.FieldByName('ExpensesOther').AsFloat;

        dm_Main.tb_CashRegister.Next;
      end;

    if POSAdmin and (FPoSID <> GUID_NULL) and (dm_Main.tb_CashRegister.RecordCount = 1) then
      begin
        LBlockShow := True;
        LBlocked   := dm_Main.tb_CashRegister.FieldByName('Blocked').AsBoolean;
      end;
  finally
    dm_Main.tb_CashRegister.Filtered := False;
  end;

  // SummaryValues
  LSummaryPayValue := LPayValue;
  LSummaryExpenses := LExpenses;
  LSummaryTotal    := LSummaryPayValue - LSummaryExpenses;
  LSummaryCash     := LSummaryInitialCash + LPayValueCash    - LSummaryExpenses;

  // Update Labels
  lbl_SummaryMainTitle.Text      := FPoSName;
//  lbl_SummarySubTitle.Text       := FormatDateTime('dd/mm/yyyy', FDay);
  if FDay <> edt_Date.Date then
    begin
      edt_Date.OnChange := nil;
      edt_Date.Date     := FDay;
      edt_Date.OnChange := edt_DateChange;
    end;

  btn_SummaryDayBlock.Visible    := False;
  btn_SummaryDayUnBlock.Visible  := False;

  if LBlockShow then
    begin
      btn_SummaryDayBlock.Visible    := not LBlocked;
      btn_SummaryDayUnBlock.Visible  := LBlocked;
    end;

  lbl_SummaryCount.Text          := Format('%d', [LCount                  ]);
  lbl_SummaryPayValue.Text       := FormatFloat('0.00', LSummaryPayValue   );
  lbl_SummaryExpenses.Text       := FormatFloat('0.00', LSummaryExpenses   );
  lbl_SummaryTotal.Text          := FormatFloat('0.00', LSummaryTotal      );
  lbl_SummaryInitialCash.Text    := FormatFloat('0.00', LSummaryInitialCash);
  lbl_SummaryCash.Text           := FormatFloat('0.00', LSummaryCash       );

  lbl_Expenses.Text              := FormatFloat('0.00', LExpenses       );
  lbl_ExpensesMeal.Text          := FormatFloat('0.00', LExpensesMeal   );
  lbl_ExpensesFuel.Text          := FormatFloat('0.00', LExpensesFuel   );
  lbl_ExpensesDaily.Text         := FormatFloat('0.00', LExpensesDaily  );
  lbl_ExpensesOther.Text         := FormatFloat('0.00', LExpensesOther  );

  lbl_PayMinutes.Text            := Format('%d', [LPayMinutes           ]);
  lbl_PayValue.Text              := Format('%d', [LPayValue             ]);
  lbl_PayValueCard.Text          := Format('%d', [LPayValueCard         ]);
  lbl_PayValueCash.Text          := Format('%d', [LPayValueCash         ]);
  lbl_PayValuePix.Text           := Format('%d', [LPayValuePix          ]);
  lbl_PayValueOther.Text         := Format('%d', [LPayValueOther        ]);
  lbl_PayValueDiscount.Text      := Format('%d', [LPayValueDiscount     ]);
  lbl_PayValueFree.Text          := Format('%d', [LPayValueFree         ]);

  lbl_StartPayMinutes.Text       := Format('%d', [LStartPayMinutes      ]);
  lbl_StartPayValue.Text         := Format('%d', [LStartPayValue        ]);
  lbl_StartPayValueCard.Text     := Format('%d', [LStartPayValueCard    ]);
  lbl_StartPayValueCash.Text     := Format('%d', [LStartPayValueCash    ]);
  lbl_StartPayValuePix.Text      := Format('%d', [LStartPayValuePix     ]);
  lbl_StartPayValueOther.Text    := Format('%d', [LStartPayValueOther   ]);
  lbl_StartPayValueDiscount.Text := Format('%d', [LStartPayValueDiscount]);
  lbl_StartPayValueFree.Text     := Format('%d', [LStartPayValueFree    ]);

  lbl_EndPayMinutes.Text         := Format('%d', [LEndPayMinutes        ]);
  lbl_EndPayValue.Text           := Format('%d', [LEndPayValue          ]);
  lbl_EndPayValueCard.Text       := Format('%d', [LEndPayValueCard      ]);
  lbl_EndPayValueCash.Text       := Format('%d', [LEndPayValueCash      ]);
  lbl_EndPayValuePix.Text        := Format('%d', [LEndPayValuePix       ]);
  lbl_EndPayValueOther.Text      := Format('%d', [LEndPayValueOther     ]);
  lbl_EndPayValueDiscount.Text   := Format('%d', [LEndPayValueDiscount  ]);
  lbl_EndPayValueFree.Text       := Format('%d', [LEndPayValueFree      ]);
end;

// *****************************************************************************
// DETAIL LIST
// *****************************************************************************

procedure Tfrm_Report.btn_DetailListBackClick(Sender: TObject);
begin
  actTabChange_Day.Execute();
end;

procedure Tfrm_Report.lst_RentalItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  if not dm_Main.tb_Rental.Locate( 'id', AItem.TagString, [] ) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'Report.lst_RentalItemClick');
      Exit;
    end;
  DetailRefresh(AItem.TagString);

  actTabChange_Detail.Execute();
end;

procedure Tfrm_Report.edt_DateChange(Sender: TObject);
begin
  FDay := edt_Date.Date;
  SummaryRefresh();
end;

procedure Tfrm_Report.DetailListRefresh();
var
  LItem : TListViewItem;
  LPayMinutes, LPayValue : Cardinal;
begin

  lbl_DetailListTitlePoS.Text := FPoSName;
  lbl_DetailListTitleDay.Text := FormatDateTime('dd/mm/yyyy', FDay);

  dm_Main.tb_Rental.Filtered := false;
  if FPoSID = GUID_NULL then  // All PoS
    begin
      // Filter only FDay
      dm_Main.tb_Rental.Filter   := 'Day = {d ' + (FormatDateTime('yyyy-mm-dd', FDay)) + '}';
    end
  else
    begin
      // Filter only FDay and FPosID
      dm_Main.tb_Rental.Filter   := 'Day = {d ' + (FormatDateTime('yyyy-mm-dd', FDay)) + '} AND PoSID = ' + QuotedStr(GUIDTOString(FPoSID));
    end;
  dm_Main.tb_Rental.Filtered := true;
  lst_Rental.Items.BeginUpdate;
  try
    dm_Main.tb_Rental.First;
    lst_Rental.Items.Clear;
    while not dm_Main.tb_Rental.Eof do
      begin
        LItem := lst_Rental.Items.Add;
        LItem.TagString := dm_Main.tb_Rental.FieldByName('id').AsString;

        LPayMinutes := dm_Main.tb_Rental.FieldByName('StartPayMinutes'      ).AsInteger + dm_Main.tb_Rental.FieldByName('EndPayMinutes'      ).AsInteger;
        LPayValue   := dm_Main.tb_Rental.FieldByName('StartPayValue'        ).AsInteger + dm_Main.tb_Rental.FieldByName('EndPayValue'        ).AsInteger;

        LItem.Objects.FindDrawable('txtCount'   ).Data :=       Format('%0.2d',[dm_Main.tb_Rental.FieldByName('Count'              ).AsInteger]);
        LItem.Objects.FindDrawable('txtNumber'  ).Data :=                       dm_Main.tb_Rental.FieldByName('BoatNumber'           ).AsString;
        LItem.Objects.FindDrawable('txtDateTime').Data :=       FormatDateTime('dd/mm/yyyy hh:mm:ss', dm_Main.tb_Rental.FieldByName('StartAt'          ).AsDateTime);
        LItem.Objects.FindDrawable('txtTime'    ).Data :=                         Format('%d', [LPayMinutes      ]) + ' min.';
        LItem.Objects.FindDrawable('txtValue'   ).Data :=                 'R$ ' + Format('%d', [LPayValue        ]) + ',00';

        dm_Main.tb_Rental.Next;
      end;
  finally
    lst_Rental.Items.EndUpdate;
    dm_Main.tb_Rental.Filtered := False;
  end;

  if frm_Main.Sync = ssOffline then       // If it is in offline mode, we dont need to sync
    begin
      Waiting_Show;
      // Something that we need to do, if it is in offline mode
      Waiting_Hide;
      Exit;
    end;
end;

procedure Tfrm_Report.Block(ABlock: Boolean);
begin
  if FPoSID = GUID_NULL then
    begin
      TDialogService.ShowMessage('Favor selecionar um Ponto de Vendas');
      Exit;
    end;

  // Day --------
  dm_Main.tb_PoS.Filtered := false;
  if not dm_Main.tb_PoS.Locate('id', GUIDTOString(FPoSID)) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'Report.Block');
      Exit;
    end;

  if dm_Main.tb_PoS.FieldByName('DayOpen').AsBoolean and (dm_Main.tb_PoS.FieldByName('Day').AsDateTime = FDay) then
    begin
      TDialogService.ShowMessage('O Caixa para o dia ' + FormatDateTime('dd/mm/yyyy', FDay) + ' do Ponto de Serviço '+ lbl_SummaryMainTitle.Text + ' está aberto e não pode ser bloqueado.');
      Exit;
    end;

  // Day --------
  dm_Main.tb_CashRegister.Filtered := false;
  dm_Main.tb_CashRegister.Filter   := 'Day = {d ' + (FormatDateTime('yyyy-mm-dd', FDay)) + '} AND PoSID = ' + QuotedStr(GUIDTOString(FPoSID));
  dm_Main.tb_CashRegister.Filtered := true;
  try
    if dm_Main.tb_CashRegister.IsEmpty then
      begin
        TDialogService.ShowMessage('Caixa não encontrado para o dia ' + FormatDateTime('dd/mm/yyyy', FDay) + ' do Ponto de Serviço '+ lbl_SummaryMainTitle.Text);
        Exit;
      end;

    if dm_Main.tb_CashRegister.RecordCount > 1 then
      begin
        TDialogService.ShowMessage('Erro inesperado na busca do caixa do dia ' + FormatDateTime('dd/mm/yyyy', FDay) + ' do Ponto de Serviço '+ lbl_SummaryMainTitle.Text + ': multiplos registos encontrados ('+ IntToStr(dm_Main.tb_CashRegister.RecordCount)+')');
        Exit;
      end;

    dm_Main.tb_CashRegister.Edit;
    dm_Main.tb_CashRegister.FieldByName('Blocked').AsBoolean := ABlock;
    dm_Main.tb_CashRegister.Post;
    dm_Main.tb_CashRegister.SaveToFile();
  finally
    dm_Main.tb_CashRegister.Filtered := False;
  end;

  SummaryRefresh();

end;

// *****************************************************************************
// DETAIL
// *****************************************************************************

procedure Tfrm_Report.btn_DetailBackClick(Sender: TObject);
begin
  actTabChange_DetailList.Execute();
end;

procedure Tfrm_Report.DetailRefresh(ARentalID: String);
var
  LPayMinutes,
  LPayValue,
  LPayValueCard,
  LPayValueCash,
  LPayValuePix,
  LPayValueOther,
  LPayValueDiscount,
  LPayValueFree,

  LStartPayMinutes,
  LStartPayValue,
  LStartPayValueCard,
  LStartPayValueCash,
  LStartPayValuePix,
  LStartPayValueOther,
  LStartPayValueDiscount,
  LStartPayValueFree,

  LEndPayMinutes,
  LEndPayValue,
  LEndPayValueCard,
  LEndPayValueCash,
  LEndPayValuePix,
  LEndPayValueOther,
  LEndPayValueDiscount,
  LEndPayValueFree : LongWord;

  LStartObs,
  LEndObs,
  LObs: String;

begin
  LPayMinutes           := 0;
  LPayValue             := 0;
  LPayValueCard         := 0;
  LPayValueCash         := 0;
  LPayValuePix          := 0;
  LPayValueOther        := 0;
  LPayValueDiscount     := 0;
  LPayValueFree         := 0;

  LStartPayMinutes      := 0;
  LStartPayValue        := 0;
  LStartPayValueCard    := 0;
  LStartPayValueCash    := 0;
  LStartPayValuePix     := 0;
  LStartPayValueOther   := 0;
  LStartPayValueDiscount:= 0;
  LStartPayValueFree    := 0;

  LEndPayMinutes        := 0;
  LEndPayValue          := 0;
  LEndPayValueCard      := 0;
  LEndPayValueCash      := 0;
  LEndPayValuePix       := 0;
  LEndPayValueOther     := 0;
  LEndPayValueDiscount  := 0;
  LEndPayValueFree      := 0;

  LStartObs             := '';
  LEndObs               := '';
  LObs                  := '';

  if not dm_Main.tb_Rental.Locate( 'id', ARentalID, [] ) then
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'Report.DetailRefresh');
      Exit;
    end;

  LStartPayMinutes       := dm_Main.tb_Rental.FieldByName('StartPayMinutes'       ).AsInteger;
  LStartPayValue         := dm_Main.tb_Rental.FieldByName('StartPayValue'         ).AsInteger;
  LStartPayValueCard     := dm_Main.tb_Rental.FieldByName('StartPayValueCard'     ).AsInteger;
  LStartPayValueCash     := dm_Main.tb_Rental.FieldByName('StartPayValueCash'     ).AsInteger;
  LStartPayValuePix      := dm_Main.tb_Rental.FieldByName('StartPayValuePix'      ).AsInteger;
  LStartPayValueOther    := dm_Main.tb_Rental.FieldByName('StartPayValueOther'    ).AsInteger;
  if dm_Main.tb_Rental.FieldByName('StartPayValue').AsInteger  <> 0 then
    begin
      LStartPayValueDiscount := dm_Main.tb_Rental.FieldByName('StartPayValueDiscount'    ).AsInteger;
    end
  else
    begin
      LStartPayValueFree     := dm_Main.tb_Rental.FieldByName('StartPayValueDiscount'        ).AsInteger;
    end;
  LStartObs            := dm_Main.tb_Rental.FieldByName('StartObs'    ).AsString;

  LEndPayMinutes       := dm_Main.tb_Rental.FieldByName('EndPayMinutes'       ).AsInteger;
  LEndPayValue         := dm_Main.tb_Rental.FieldByName('EndPayValue'         ).AsInteger;
  LEndPayValueCard     := dm_Main.tb_Rental.FieldByName('EndPayValueCard'     ).AsInteger;
  LEndPayValueCash     := dm_Main.tb_Rental.FieldByName('EndPayValueCash'     ).AsInteger;
  LEndPayValuePix      := dm_Main.tb_Rental.FieldByName('EndPayValuePix'      ).AsInteger;
  LEndPayValueOther    := dm_Main.tb_Rental.FieldByName('EndPayValueOther'    ).AsInteger;
  if dm_Main.tb_Rental.FieldByName('EndPayValue').AsInteger  <> 0 then
    begin
      LEndPayValueDiscount := dm_Main.tb_Rental.FieldByName('EndPayValueDiscount'    ).AsInteger;
    end
  else
    begin
      LEndPayValueFree     := dm_Main.tb_Rental.FieldByName('EndPayValueDiscount'        ).AsInteger;
    end;
  LEndObs           := dm_Main.tb_Rental.FieldByName('EndObs'    ).AsString;

  LPayMinutes       := LStartPayMinutes       + LEndPayMinutes;
  LPayValue         := LStartPayValue         + LEndPayValue;
  LPayValueCard     := LStartPayValueCard     + LEndPayValueCard;
  LPayValueCash     := LStartPayValueCash     + LEndPayValueCash;
  LPayValuePix      := LStartPayValuePix      + LEndPayValuePix;
  LPayValueOther    := LStartPayValueOther    + LEndPayValueOther;
  LPayValueDiscount := LStartPayValueDiscount + LEndPayValueDiscount;
  LPayValueFree     := LStartPayValueFree     + LEndPayValueFree;
  LObs              := 'Inicio: ' + LStartObs + #$A#$D + 'Fim: ' + LEndObs;

  lbl_DetailTitlePoS.Text              := FPoSName;
  lbl_DetailTitleDay.Text              := FormatDateTime('dd/mm/yyyy', FDay);

  lbl_DetailCount.Text                 := Format        ('%0.2d'     ,[dm_Main.tb_Rental.FieldByName('Count'          ).AsInteger]);
  lbl_DetailBoatNumber.Text            :=                              dm_Main.tb_Rental.FieldByName('BoatNumber'     ).AsString;
  lbl_DetailStartDayDate.Text          := FormatDateTime('dd/mm/yyyy', dm_Main.tb_Rental.FieldByName('StartAt'        ).AsDateTime);
  lbl_DetailStartDayTime.Text          := FormatDateTime('hh:mm:ss'  , dm_Main.tb_Rental.FieldByName('StartAt'        ).AsDateTime);
  lbl_DetailEndDayDate.Text            := FormatDateTime('dd/mm/yyyy', dm_Main.tb_Rental.FieldByName('EndAt'          ).AsDateTime);
  lbl_DetailEndDayTime.Text            := FormatDateTime('hh:mm:ss'  , dm_Main.tb_Rental.FieldByName('EndAt'          ).AsDateTime);

  lbl_DetailPayMinutes.Text            := Format('%d', [LPayMinutes      ]);
  lbl_DetailPayValue.Text              := Format('%d', [LPayValue        ]);
  lbl_DetailPayValueCard.Text          := Format('%d', [LPayValueCard    ]);
  lbl_DetailPayValueCash.Text          := Format('%d', [LPayValueCash    ]);
  lbl_DetailPayValuePix.Text           := Format('%d', [LPayValuePix     ]);
  lbl_DetailPayValueOther.Text         := Format('%d', [LPayValueOther   ]);
  lbl_DetailPayValueDiscount.Text      := Format('%d', [LPayValueDiscount]);
  lbl_DetailPayValueFree.Text          := Format('%d', [LPayValueFree    ]);

  lbl_DetailStartPayMinutes.Text       := Format('%d', [LStartPayMinutes      ]);
  lbl_DetailStartPayValue.Text         := Format('%d', [LStartPayValue        ]);
  lbl_DetailStartPayValueCard.Text     := Format('%d', [LStartPayValueCard    ]);
  lbl_DetailStartPayValueCash.Text     := Format('%d', [LStartPayValueCash    ]);
  lbl_DetailStartPayValuePix.Text      := Format('%d', [LStartPayValuePix     ]);
  lbl_DetailStartPayValueOther.Text    := Format('%d', [LStartPayValueOther   ]);
  lbl_DetailStartPayValueDiscount.Text := Format('%d', [LStartPayValueDiscount]);
  lbl_DetailStartPayValueFree.Text     := Format('%d', [LStartPayValueFree    ]);

  lbl_DetailEndPayMinutes.Text         := Format('%d', [LEndPayMinutes      ]);
  lbl_DetailEndPayValue.Text           := Format('%d', [LEndPayValue        ]);
  lbl_DetailEndPayValueCard.Text       := Format('%d', [LEndPayValueCard    ]);
  lbl_DetailEndPayValueCash.Text       := Format('%d', [LEndPayValueCash    ]);
  lbl_DetailEndPayValuePix.Text        := Format('%d', [LEndPayValuePix     ]);
  lbl_DetailEndPayValueOther.Text      := Format('%d', [LEndPayValueOther   ]);
  lbl_DetailEndPayValueDiscount.Text   := Format('%d', [LEndPayValueDiscount]);
  lbl_DetailEndPayValueFree.Text       := Format('%d', [LEndPayValueFree    ]);

  mm_DetailObs.Text                    := LObs;
end;



end.
