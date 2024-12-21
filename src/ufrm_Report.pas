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
  FMX.NumberBox;

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
    edt_Number: TEdit;
    lbl_Number: TLabel;
    btn_CancelFinish: TSpeedButton;
    procedure btn_CancelClick(Sender: TObject);
    procedure lst_RentalPullRefresh(Sender: TObject);
    procedure lst_RentalItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    { Private declarations }
    // BASIC HANDLE
    FApplyUpdatesErrorMessage: String;
    FGetErrorMessage         : String;
  public
    { Public declarations }
    // BASIC HANDLE: Prepare; ApplyUpdates; Refresh
    procedure Prepare;
    procedure ApplyUpdates;
    procedure ApplyUpdateTerminated(Sender: TObject);
    procedure Refresh;
    procedure RefreshTerminated(Sender: TObject);
  end;

const
  frm_Boat_msg_Delete_Denied  = 'Não é possivel excluir um pedalinho alugado.';
  frm_Boat_msg_Delete         = 'Excluir?';
  frm_Boat_msg_NumberRequired = 'Número requerido.';

implementation

{$R *.fmx}

uses udm_Main, ufrm_Main, ufrm_Waiting;

//------------------------------------------------------------------------------
// BASE HANDLE
//      Prepare
//      ApplyUpdates
//      Refresh
//------------------------------------------------------------------------------

procedure Tfrm_Report.Prepare;       // Call it before open the frame
begin
  tabCtrl_List.ActiveTab := tabItem_List;
                                    // Load from file is important
  dm_Main.tb_Rental.LoadFromFile(); // to check for pending updates from the previous offline mode
  Refresh;                          // or if we are currently in offline mode
end;

procedure Tfrm_Report.ApplyUpdates;
begin
  if dm_Main.tb_Boat.State in dsEditModes then dm_Main.tb_Boat.Post;         // Save it


  // If it's in Offline mode, we don't need to attempt to sync, we just save to file.
  if frm_Main.Sync = ssOffline then
    begin
      dm_Main.tb_Rental.SaveToFile;
      Refresh;
      Exit;
    end;

end;

procedure Tfrm_Report.ApplyUpdateTerminated(Sender: TObject);
begin

end;

procedure Tfrm_Report.Refresh;
var
  Item : TListViewItem;
begin
  dm_Main.tb_Rental.Active := false;
  dm_Main.tb_Rental.LoadFromFile();
  dm_Main.tb_Rental.Active := true;
  dm_Main.tb_Rental.First;

  lst_Rental.Items.BeginUpdate;
  lst_Rental.Items.Clear;
  while not dm_Main.tb_Rental.Eof do
    begin
      Item := lst_Rental.Items.Add;
      Item.TagString := dm_Main.tb_Rental.FieldByName('id').AsString;


      Item.Objects.FindDrawable('txtNumber'  ).Data := dm_Main.tb_Rental.FieldByName('Number').AsString;
      Item.Objects.FindDrawable('txtDateTime').Data := dm_Main.tb_Rental.FieldByName('RentedAt'    ).AsString;
      Item.Objects.FindDrawable('txtType'    ).Data := 'D';
      Item.Objects.FindDrawable('txtTime'    ).Data := dm_Main.tb_Rental.FieldByName('PaymentMinutes'  ).AsString + ' min';
      Item.Objects.FindDrawable('txtValue'   ).Data := 'R$ ' + dm_Main.tb_Rental.FieldByName('PaymentValue'    ).AsString + ',00';
//      if dm_Main.tb_Rental.FieldByName('Active').AsBoolean then
//        Item.Objects.FindDrawable('txtActive').Data := '🔵'
//      else
//        Item.Objects.FindDrawable('txtActive').Data := '⚫';

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

procedure Tfrm_Report.lst_RentalPullRefresh(Sender: TObject);
begin
  Refresh;
end;

procedure Tfrm_Report.lst_RentalItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if not dm_Main.tb_Rental.Locate( 'id', AItem.TagString, [] ) then
    begin
      Exit;
    end;

  edt_Number.Text         :=             dm_Main.tb_Rental.FieldByName('id'      ).AsString;
//  switch_Active.IsChecked :=             dm_Main.tb_Rental.FieldByName('Active'      ).AsBoolean;
//  edt_Color.Color         := TAlphaColor(dm_Main.tb_Rental.FieldByName('Color'       ).AsLongWord);
//  edt_DefaultValue.Text   :=             dm_Main.tb_Rental.FieldByName('DefaultValue').AsString;

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


procedure Tfrm_Report.btn_CancelClick(Sender: TObject);
begin
  tabCtrl_List.Previous;
end;

end.
