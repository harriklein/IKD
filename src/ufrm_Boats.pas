unit ufrm_Boats;

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
  Tfrm_Boats = class(TFrame)
    tabCtrl_List: TTabControl;
    tabItem_List: TTabItem;
    lst_Boats: TListView;
    toolBar_List: TToolBar;
    shadow_List: TShadowEffect;
    btn_Add: TSpeedButton;
    path_Add: TPath;
    tabItem_Detail: TTabItem;
    toolBar_Detail: TToolBar;
    shadow_Detail: TShadowEffect;
    btn_Save: TSpeedButton;
    path_Save: TPath;
    btn_Cancel: TSpeedButton;
    path_Cancel: TPath;
    edt_Number: TEdit;
    lbl_Number: TLabel;
    btn_Delete: TSpeedButton;
    switch_Active: TSwitch;
    lbl_Active: TLabel;
    lbl_Color: TLabel;
    edt_Color: TColorComboBox;
    edt_DefaultValue: TNumberBox;
    lbl_DefaultValue: TLabel;
    lbl_DefaultValueDec: TLabel;
    lbl_DefaultValueRS: TLabel;
    procedure btn_AddClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure lst_BoatsPullRefresh(Sender: TObject);
    procedure lst_BoatsItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btn_DeleteClick(Sender: TObject);
    procedure tabCtrl_ListChange(Sender: TObject);
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

procedure Tfrm_Boats.Prepare;       // Call it before open the frame
begin
  tabCtrl_List.ActiveTab := tabItem_List;
                                    // Load from file is important
  dm_Main.tb_Boat.LoadFromFile(); // to check for pending updates from the previous offline mode
  Refresh;                          // or if we are currently in offline mode
end;

procedure Tfrm_Boats.ApplyUpdates;
begin
  if dm_Main.tb_Boat.State in dsEditModes then dm_Main.tb_Boat.Post;         // Save it


  // If it's in Offline mode, we don't need to attempt to sync, we just save to file.
  if frm_Main.Sync = ssOffline then
    begin
      dm_Main.tb_Boat.SaveToFile;
      Refresh;
      Exit;
    end;

end;

procedure Tfrm_Boats.ApplyUpdateTerminated(Sender: TObject);
begin

end;

procedure Tfrm_Boats.Refresh;
var
  Item : TListViewItem;
begin
  dm_Main.tb_Boat.Active := false;
  dm_Main.tb_Boat.LoadFromFile();
  dm_Main.tb_Boat.Active := true;
  dm_Main.tb_Boat.First;

  lst_Boats.Items.BeginUpdate;
  lst_Boats.Items.Clear;
  while not dm_Main.tb_Boat.Eof do
    begin
      Item := lst_Boats.Items.Add;
      Item.TagString := dm_Main.tb_Boat.FieldByName('Number').AsString;


//      Item.Objects.FindDrawable('txtId'    ).Data := dm_Main.tb_Boat.FieldByName('id'    ).AsString;
      Item.Objects.FindDrawable('txtNumber').Data := dm_Main.tb_Boat.FieldByName('Number').AsString;
      if dm_Main.tb_Boat.FieldByName('Active').AsBoolean then
        Item.Objects.FindDrawable('txtActive').Data := '🔵'
      else
        Item.Objects.FindDrawable('txtActive').Data := '⚫';

      dm_Main.tb_Boat.Next;
    end;
  lst_Boats.Items.EndUpdate;

  if frm_Main.Sync = ssOffline then       // If it is in offline mode, we dont need to sync
    begin
      Waiting_Show;
      // Something that we need to do, if it is in offline mode
      Waiting_Hide;
      Exit;
    end;
end;

procedure Tfrm_Boats.RefreshTerminated(Sender: TObject);
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

procedure Tfrm_Boats.lst_BoatsPullRefresh(Sender: TObject);
begin
  Refresh;
end;

procedure Tfrm_Boats.lst_BoatsItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  if not dm_Main.tb_Boat.Locate( 'Number', AItem.TagString, [] ) then
    begin
      Exit;
    end;

  dm_Main.tb_Boat.Edit;
  edt_Number.Text         :=             dm_Main.tb_Boat.FieldByName('Number'      ).AsString;
  switch_Active.IsChecked :=             dm_Main.tb_Boat.FieldByName('Active'      ).AsBoolean;
  edt_Color.Color         := TAlphaColor(dm_Main.tb_Boat.FieldByName('Color'       ).AsLongWord);
  edt_DefaultValue.Text   :=             dm_Main.tb_Boat.FieldByName('DefaultValue').AsString;

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


procedure Tfrm_Boats.btn_AddClick(Sender: TObject);
begin
  if not dm_Main.tb_Boat.Active then
    begin
      dm_Main.tb_Boat.Active := true;
    end;

  dm_Main.tb_Boat.Append;
  edt_Number.Text         :=        dm_Main.tb_Boat.FieldByName('Number'      ).AsString;
  switch_Active.IsChecked :=        dm_Main.tb_Boat.FieldByName('Active'      ).AsBoolean;
  edt_Color.Color         := TColor(dm_Main.tb_Boat.FieldByName('Color'       ).AsLongWord);
  edt_DefaultValue.Value  :=        dm_Main.tb_Boat.FieldByName('DefaultValue').AsInteger;

  tabCtrl_List.Next;
end;

procedure Tfrm_Boats.btn_CancelClick(Sender: TObject);
begin
  dm_Main.tb_Boat.Cancel;
  tabCtrl_List.Previous;
end;

procedure Tfrm_Boats.tabCtrl_ListChange(Sender: TObject);
begin
  btn_Delete.Visible := not (dm_Main.tb_Boat.State in [dsInsert]);
end;

procedure Tfrm_Boats.btn_SaveClick(Sender: TObject);
begin
  if not(dm_Main.tb_Boat.State in [dsInsert, dsEdit]) then
    begin
      Exit;
    end;

  if edt_DefaultValue.IsFocused then
    edt_Number.SetFocus;

  dm_Main.tb_Boat.FieldByName('Number'      ).AsString   := edt_Number.Text;
  dm_Main.tb_Boat.FieldByName('Active'      ).AsBoolean  := switch_Active.IsChecked;
  dm_Main.tb_Boat.FieldByName('Color'       ).AsLongWord := edt_Color.Color ;
  dm_Main.tb_Boat.FieldByName('DefaultValue').AsInteger  := Trunc(edt_DefaultValue.Value);

  if dm_Main.tb_Boat.FieldByName('Number').AsString.IsEmpty then
    begin
      TDialogService.ShowMessage(frm_Boat_msg_NumberRequired);
      Exit;
    end;

  dm_Main.tb_Boat.Post;

  ApplyUpdates;
  tabCtrl_List.Previous;
end;


procedure Tfrm_Boats.btn_DeleteClick(Sender: TObject);
begin
  if dm_Main.tb_Boat.FieldByName('Rented').AsBoolean then
    begin
      TDialogService.ShowMessage( frm_Boat_msg_Delete_Denied );
      Exit;
    end;

  TDialogService.MessageDialog( frm_Boat_msg_Delete, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  begin
                                    if AResult = mrYes then
                                      begin
                                        dm_Main.tb_Boat.Delete;
                                        ApplyUpdates;
                                        tabCtrl_List.Previous;
                                      end
                                  end);
end;

end.
