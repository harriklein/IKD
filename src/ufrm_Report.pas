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
  FMX.NumberBox, FMX.DateTimeCtrls, FMX.Layouts;

type
  Tfrm_Report = class(TFrame)
    tabCtrl_List: TTabControl;
    tabItem_List: TTabItem;
    lst_Rental: TListView;
    toolBar_List: TToolBar;
    shadow_List: TShadowEffect;
    tabItem_Detail: TTabItem;
    toolBar_Detail: TToolBar;
    shadow_Detail: TShadowEffect;
    btn_CancelFinish: TSpeedButton;
    btn_DatePrevious: TSpeedButton;
    btn_DateNext: TSpeedButton;
    lbl_Date: TLabel;
    vScroll_RentFinish: TVertScrollBox;
    layout_RentFinish: TFlowLayout;
    Layout1: TLayout;
    lbl_ID: TLabel;
    Label12: TLabel;
    lbl_Number: TLabel;
    Rectangle1: TRectangle;
    layout_RentFinish1: TLayout;
    edt_RentFinishStartHour: TTimeEdit;
    edt_RentFinishStartDate: TDateEdit;
    edt_RentFinishStartMinutes: TNumberBox;
    Label1: TLabel;
    edt_RentFinishStartValue: TNumberBox;
    Label2: TLabel;
    Label3: TLabel;
    lbl_Start: TLabel;
    Rectangle2: TRectangle;
    layout_RentFinish2: TLayout;
    edt_RentFinishCalcMinutes: TNumberBox;
    Label4: TLabel;
    Label5: TLabel;
    edt_RentFinishCalcValue: TNumberBox;
    Label6: TLabel;
    lbl_Calculation: TLabel;
    Rectangle3: TRectangle;
    layout_RentFinish3: TLayout;
    edt_RentFinishMinutes: TNumberBox;
    Label7: TLabel;
    Label8: TLabel;
    edt_RentFinishValue: TNumberBox;
    Label9: TLabel;
    lbl_Finish: TLabel;
    switch_RentFinishChange: TSwitch;
    Label10: TLabel;
    lbl_PaymentType: TLabel;
    lbl_PaymentTypeValue: TLabel;
    procedure lst_RentalPullRefresh(Sender: TObject);
    procedure lst_RentalItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btn_DatePreviousClick(Sender: TObject);
    procedure btn_DateNextClick(Sender: TObject);
    procedure btn_CancelFinishClick(Sender: TObject);
  private
    { Private declarations }
    FDate                    : TDate;
    FApplyUpdatesErrorMessage: String;
    FGetErrorMessage         : String;
  public
    { Public declarations }
    // BASIC HANDLE: Prepare; ApplyUpdates; Refresh
    procedure Prepare;
    procedure ApplyUpdates;
    procedure ApplyUpdateTerminated(Sender: TObject);
    procedure Refresh(ADate: TDate);
    procedure RefreshTerminated(Sender: TObject);
  end;

const
  frm_Boat_msg_Delete_Denied  = 'Não é possivel excluir um pedalinho alugado.';
  frm_Boat_msg_Delete         = 'Excluir?';
  frm_Boat_msg_NumberRequired = 'Número requerido.';

implementation

{$R *.fmx}

uses udm_Main, ufrm_Main, ufrm_Waiting, ufrm_Boat;

//------------------------------------------------------------------------------
// BASE HANDLE
//      Prepare
//      ApplyUpdates
//      Refresh
//------------------------------------------------------------------------------

procedure Tfrm_Report.Prepare;       // Call it before open the frame
begin
  tabCtrl_List.ActiveTab := tabItem_List;
  Refresh(Now);
end;

procedure Tfrm_Report.ApplyUpdates;
begin
  if dm_Main.tb_Boat.State in dsEditModes then dm_Main.tb_Boat.Post;         // Save it


  // If it's in Offline mode, we don't need to attempt to sync, we just save to file.
  if frm_Main.Sync = ssOffline then
    begin
      dm_Main.tb_Rental.SaveToFile;
      Refresh(FDate);
      Exit;
    end;

end;

procedure Tfrm_Report.ApplyUpdateTerminated(Sender: TObject);
begin

end;

procedure Tfrm_Report.Refresh(ADate: TDate);
var
  LItem : TListViewItem;
begin
  FDate := ADate;

  lbl_Date.Text := FormatDateTime('dd/mm/yyyy', FDate);

  dm_Main.tb_Rental.Active   := false;
  dm_Main.tb_Rental.LoadFromFile();
  dm_Main.tb_Rental.Filtered := false;
  dm_Main.tb_Rental.Filter   := 'RentedAt >= {d ' + (FormatDateTime('yyyy-mm-dd', FDate)) + '} AND RentedAt < {d ' + (FormatDateTime('yyyy-mm-dd', FDate + 1)) + '}';
  dm_Main.tb_Rental.Filtered := true;
  dm_Main.tb_Rental.Active   := true;
  dm_Main.tb_Rental.First;

  lst_Rental.Items.BeginUpdate;
  lst_Rental.Items.Clear;
  while not dm_Main.tb_Rental.Eof do
    begin
      LItem := lst_Rental.Items.Add;
      LItem.TagString := dm_Main.tb_Rental.FieldByName('id').AsString;

      LItem.Objects.FindDrawable('txtNumber'  ).Data :=                         dm_Main.tb_Rental.FieldByName('Number'    ).AsString;
      LItem.Objects.FindDrawable('txtDateTime').Data :=                         dm_Main.tb_Rental.FieldByName('RentedAt'  ).AsString;
      LItem.Objects.FindDrawable('txtType'    ).Data := PaymentMethod_EN_to_PT3(dm_Main.tb_Rental.FieldByName('PayMethod' ).AsString);
      LItem.Objects.FindDrawable('txtTime'    ).Data :=                         dm_Main.tb_Rental.FieldByName('PayMinutes').AsString + ' min.';
      LItem.Objects.FindDrawable('txtValue'   ).Data :=                 'R$ ' + dm_Main.tb_Rental.FieldByName('PayValue'  ).AsString + ',00';

      dm_Main.tb_Rental.Next;
    end;
  lst_Rental.Items.EndUpdate;

  if frm_Main.Sync = ssOffline then       // If it is in offline mode, we dont need to sync
    begin
      Waiting_Show;
      // Something that we need to do, if it is in offline mode
      Waiting_Hide;
      Exit;
    end;
end;

procedure Tfrm_Report.RefreshTerminated(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------
// BASE HANDLE  END
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// LIST
//      Pull Refresh
//      Item Click -> Edit it
//
//------------------------------------------------------------------------------

procedure Tfrm_Report.btn_CancelFinishClick(Sender: TObject);
begin
  tabCtrl_List.Previous;
end;

procedure Tfrm_Report.btn_DateNextClick(Sender: TObject);
begin
  Refresh(FDate+1);
end;

procedure Tfrm_Report.btn_DatePreviousClick(Sender: TObject);
begin
  Refresh(FDate-1);
end;

procedure Tfrm_Report.lst_RentalPullRefresh(Sender: TObject);
begin
  Refresh(FDate);
end;

procedure Tfrm_Report.lst_RentalItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if not dm_Main.tb_Rental.Locate( 'id', AItem.TagString, [] ) then
    begin
      Exit;
    end;

  lbl_ID.Text                       := dm_Main.tb_Rental.FieldByName('id'                      ).AsString;
  lbl_Number.Text                   := dm_Main.tb_Rental.FieldByName('Number'                  ).AsString;
  edt_RentFinishStartDate.Date      := dm_Main.tb_Rental.FieldByName('RentedAt'                ).AsDateTime;
  edt_RentFinishStartHour.Date      := dm_Main.tb_Rental.FieldByName('RentedAt'                ).AsDateTime;
  edt_RentFinishStartMinutes.Value  := dm_Main.tb_Rental.FieldByName('AdvancedPaymentMinutes'  ).AsInteger;
  edt_RentFinishStartValue.Value    := dm_Main.tb_Rental.FieldByName('AdvancedPaymentValue'    ).AsInteger;
  edt_RentFinishCalcMinutes.Value   := dm_Main.tb_Rental.FieldByName('CalculedPaymentMinutes'  ).AsInteger;
  edt_RentFinishCalcValue.Value     := dm_Main.tb_Rental.FieldByName('CalculedPaymentValue'    ).AsInteger;
  edt_RentFinishMinutes.Value       := dm_Main.tb_Rental.FieldByName('PaymentMinutes'          ).AsInteger;
  edt_RentFinishValue.Value         := dm_Main.tb_Rental.FieldByName('PaymentValue'            ).AsInteger;

  lbl_PaymentTypeValue.Text         := PaymentMethod_EN_to_PT(dm_Main.tb_Rental.FieldByName('AdvancedPaymentType'    ).AsString);

  switch_RentFinishChange.IsChecked := dm_Main.tb_Rental.FieldByName('PaymentChanged'          ).AsBoolean;

  tabCtrl_List.Next;
end;

//------------------------------------------------------------------------------
// BUTTONS
//      TabControl Changed -> Handle Buttons Visibility
//      Add
//      Cancel
//      Save
//      Delete
//------------------------------------------------------------------------------

end.
