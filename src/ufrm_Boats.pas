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
  FMX.NumberBox, FMX.Layouts, FMX.Platform;




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
    edt_NumberT: TLabel;
    btn_Delete: TSpeedButton;
    switch_Active: TSwitch;
    lbl_Active: TLabel;
    vScrollBox_Config: TVertScrollBox;
    layoutFlow_Config: TFlowLayout;
    layout_Config: TLayout;
    edt_DefaultMinutes: TEdit;
    lbl_DefaultMinutesT: TLabel;
    lbl_DefaultMinutesC: TLabel;
    edt_DefaultValue: TEdit;
    lbl_DefaultValueT: TLabel;
    lbl_DefaultValueC: TLabel;
    lbl_DefaultValueR: TLabel;
    edt_DefaultExtraMinutes: TEdit;
    lbl_DefaultExtraMinutesT: TLabel;
    lbl_DefaultExtraMinutesC: TLabel;
    edt_DefaultExtraValue: TEdit;
    lbl_DefaultExtraValueT: TLabel;
    lbl_DefaultExtraValueC: TLabel;
    lbl_DefaultExtraValueR: TLabel;
    cb_PoS: TComboBox;
    lbl_PoS: TLabel;
    lbl_ID: TLabel;
    btn_ColorCopy: TButton;
    btn_ColorPaste: TButton;
    edt_Color: TEdit;
    Label1: TLabel;
    edt_ColorPanel: TColorPanel;
    ColorBox1: TColorBox;
    procedure btn_AddClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure lst_BoatsPullRefresh(Sender: TObject);
    procedure lst_BoatsItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btn_DeleteClick(Sender: TObject);
    procedure tabCtrl_ListChange(Sender: TObject);
    procedure btn_ColorCopyClick(Sender: TObject);
    procedure btn_ColorPasteClick(Sender: TObject);
    procedure edt_ColorPanelChange(Sender: TObject);
    procedure edt_ColorChange(Sender: TObject);
  private
    { Private declarations }
    // BASIC HANDLE
    FApplyUpdatesErrorMessage: String;
    FGetErrorMessage         : String;

    FBoatID : TGuid;
  public
    { Public declarations }
    // BASIC HANDLE: Prepare; ApplyUpdates; Refresh
    procedure Prepare;
    procedure Release;

    procedure ApplyUpdates;
    procedure ApplyUpdateTerminated(Sender: TObject);
    procedure Refresh;
    procedure RefreshTerminated(Sender: TObject);

    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown (Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);

    procedure cbPoSClear;
    destructor Destroy; override;
  end;

const
  frm_Boat_msg_Delete_Denied  = 'Não é possivel excluir um pedalinho alugado.';
  frm_Boat_msg_Delete         = 'Excluir?';
  frm_Boat_msg_NumberRequired = 'Número requerido.';

implementation

{$R *.fmx}

uses udm_Main, ufrm_Main, ufrm_Waiting, unt_VSoftUUIDv7, unt_Class, ufrm_PoS;

//------------------------------------------------------------------------------
// BASE HANDLE
//      Prepare
//      ApplyUpdates
//      Refresh
//------------------------------------------------------------------------------

procedure Tfrm_Boats.Prepare;       // Call it before open the frame
begin
  tabCtrl_List.ActiveTab := tabItem_List;
  btn_Add.Visible        := POSAdmin;
  FBoatID := GUID_NULL;

                                    // Load from file is important
  Refresh;                          // or if we are currently in offline mode
end;

procedure Tfrm_Boats.ApplyUpdates;
begin
//  if dm_Main.tb_Boat.State in dsEditModes then dm_Main.tb_Boat.Post;         // Save it
//
//
//  // If it's in Offline mode, we don't need to attempt to sync, we just save to file.
//  if frm_Main.Sync = ssOffline then
//    begin
//      dm_Main.tb_Boat.SaveToFile;
//      Refresh;
//      Exit;
//    end;

end;

procedure Tfrm_Boats.ApplyUpdateTerminated(Sender: TObject);
begin

end;

procedure Tfrm_Boats.Refresh;
var
  LItem  : TListViewItem;
  LCBPoS : TObject;
  LIndex : Integer;

begin
  dm_Main.tb_Boat.Filtered := False;
  lst_Boats.Items.BeginUpdate;
  try
    dm_Main.tb_Boat.First;

    lst_Boats.Items.Clear;
    while not dm_Main.tb_Boat.Eof do
      begin
        LItem           := lst_Boats.Items.Add;
        LItem.TagString := dm_Main.tb_Boat.FieldByName('id').AsString;

        LItem.Objects.FindDrawable('txtNumber').Data := dm_Main.tb_Boat.FieldByName('number').AsString;
        if dm_Main.tb_Boat.FieldByName('active').AsBoolean then
          LItem.Objects.FindDrawable('txtActive').Data := '🔵'
        else
          LItem.Objects.FindDrawable('txtActive').Data := '⚫';

        dm_Main.tb_Boat.Next;
      end;
  finally
    lst_Boats.Items.EndUpdate;
  end;

  // PoS ---------------------------

  cbPoSClear;
  cb_PoS.Items.AddObject('Nenhum', TComboBoxItemGuid.Create(cb_PoS, POS_NONE) );
  dm_Main.tb_PoS.Filtered := False;
  try
    dm_Main.tb_PoS.First;
    while not dm_Main.tb_PoS.Eof do
      begin
        cb_PoS.Items.AddObject(dm_Main.tb_PoS.FieldByName('name').AsString, TComboBoxItemGuid.Create(cb_PoS, dm_Main.tb_PoS.FieldByName('id').AsGuid));
        dm_Main.tb_PoS.Next;
      end;
  finally
    //
  end;
  // ---------------------------------

//  if frm_Main.Sync = ssOffline then       // If it is in offline mode, we dont need to sync
//    begin
//      Waiting_Show;
//      // Something that we need to do, if it is in offline mode
//      Waiting_Hide;
//      Exit;
//    end;
end;

procedure Tfrm_Boats.RefreshTerminated(Sender: TObject);
begin

end;

procedure Tfrm_Boats.Release;
begin
  //
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
  vScrollBox_Config.ViewportPosition := TPoint.Create(0,   0);
  FBoatID := GUID_NULL;

  try
    if not dm_Main.tb_Boat.Locate('id', AItem.TagString, []) then
      begin
        TDialogService.ShowMessage(UNEXPECTED_ERROR + 'Boats.lst_BoatsItemClick.tb_Boat.Locate');
        Exit;
      end;

    FBoatID                      :=             dm_Main.tb_Boat.FieldByName('id'                 ).AsGuid;
    lbl_ID.Text                  :=             dm_Main.tb_Boat.FieldByName('id'                 ).AsString;
    edt_Number.Text              :=             dm_Main.tb_Boat.FieldByName('number'             ).AsString;
    switch_Active.IsChecked      :=             dm_Main.tb_Boat.FieldByName('active'             ).AsBoolean;
    edt_ColorPanel.Color         := TAlphaColor(dm_Main.tb_Boat.FieldByName('color'              ).AsLongWord);
    edt_DefaultMinutes.Text      :=             dm_Main.tb_Boat.FieldByName('defaultMinutes'     ).AsString;
    edt_DefaultValue.Text        :=             dm_Main.tb_Boat.FieldByName('defaultValue'       ).AsString;
    edt_DefaultExtraMinutes.Text :=             dm_Main.tb_Boat.FieldByName('defaultExtraMinutes').AsString;
    edt_DefaultExtraValue.Text   :=             dm_Main.tb_Boat.FieldByName('defaultExtraValue'  ).AsString;
    if dm_Main.tb_Boat.FieldByName('posId'  ).AsString = '' then
      cb_PoS.ItemIndex             := 0;

    for var i := cb_PoS.Items.Count-1 downto 0 do
      begin
        if cb_PoS.Items.Objects[i] <> nil then
          if TComboBoxItemGuid(cb_PoS.Items.Objects[i]).Value = dm_Main.tb_Boat.FieldByName('posId'  ).AsGuid then
            cb_PoS.ItemIndex := i;
      end;
  finally
    //
  end;

  if FBoatID = GUID_NULL then  // Safe mode
    begin
      TDialogService.ShowMessage(UNEXPECTED_ERROR + 'Boats.lst_BoatsItemClick.FBoatID=null');
      Exit;
    end;

  edt_Number.Enabled              := POSAdmin;
  edt_Color.Enabled               := POSAdmin;
  edt_DefaultMinutes.Enabled      := POSAdmin;
  edt_DefaultValue.Enabled        := POSAdmin;
  edt_DefaultExtraMinutes.Enabled := POSAdmin;
  edt_DefaultExtraValue.Enabled   := POSAdmin;
  btn_ColorPaste.Enabled          := POSAdmin;

  btn_Delete.Enabled := POSAdmin;

  switch_Active.SetFocus;

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
  FBoatID := GUID_NULL;

  lbl_ID.Text                  := GuidToString(POS_NONE);
  edt_Number.Text              := '';
  switch_Active.IsChecked      := True;
  edt_ColorPanel.Color         := TAlphaColors.White;
  edt_DefaultMinutes.Text      := '';
  edt_DefaultValue.Text        := '';
  edt_DefaultExtraMinutes.Text := '';
  edt_DefaultExtraValue.Text   := '';

  cb_PoS.ItemIndex := -1;

  switch_Active.SetFocus;

  tabCtrl_List.Next;
end;

procedure Tfrm_Boats.btn_CancelClick(Sender: TObject);
begin
  tabCtrl_List.Previous;
end;

procedure Tfrm_Boats.btn_ColorCopyClick(Sender: TObject);
var
  ClipboardService: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(
       IFMXClipboardService, ClipboardService) then
  begin
    ClipboardService.SetClipboard(Format('#%.6x', [edt_ColorPanel.Color and $00FFFFFF]));
  end;
end;

procedure Tfrm_Boats.btn_ColorPasteClick(Sender: TObject);
var
  ClipboardService: IFMXClipboardService;
  LText: string;
  LColor : Integer;
begin
  if POSAdmin and TPlatformServices.Current.SupportsPlatformService(
       IFMXClipboardService, ClipboardService) then
  begin
    LText := ClipboardService.GetClipboard.ToString;

    if not (Length(edt_Color.Text) = 7  ) then Exit;
    if not (edt_Color.Text[1]      = '#') then Exit;
    if not TryStrToInt('$' + Copy(LText,2,6), LColor) then Exit;

    edt_ColorPanel.Color := TAlphaColor(LColor OR $FF000000);
  end;
end;

procedure Tfrm_Boats.tabCtrl_ListChange(Sender: TObject);
var
  LInsert : Boolean;
begin
  LInsert := FBoatID = GUID_NULL;
  btn_Delete.Visible := POSAdmin and (not LInsert);
end;

procedure Tfrm_Boats.btn_SaveClick(Sender: TObject);
begin
  if edt_Number.Text.IsEmpty then
    begin
      edt_Number.SetFocus;
      TDialogService.ShowMessage(frm_Boat_msg_NumberRequired);
      Exit;
    end;

  if StrToIntDef(edt_DefaultMinutes.Text, 0) <= 0 then
    begin
      edt_DefaultMinutes.SetFocus;
      TDialogService.ShowMessage('Tempo Padrão deve ser maior que zero!');
      Exit;
    end;

  if StrToIntDef(edt_DefaultValue.Text  , 0) <= 0 then
    begin
      edt_DefaultValue.SetFocus;
      TDialogService.ShowMessage('Valor Padrão deve ser maior que zero!');
      Exit;
    end;

  if StrToIntDef(edt_DefaultExtraMinutes.Text, 0) <= 0 then
    begin
      edt_DefaultExtraMinutes.SetFocus;
      TDialogService.ShowMessage('Tempo Extra deve ser maior que zero!');
      Exit;
    end;

  if StrToIntDef(edt_DefaultExtraValue.Text  , 0) <= 0 then
    begin
      edt_DefaultExtraValue.SetFocus;
      TDialogService.ShowMessage('Valor Extra deve ser maior que zero!');
      Exit;
    end;


  if cb_PoS.ItemIndex < 0 then
    begin
      cb_PoS.SetFocus;
      TDialogService.ShowMessage('Favor selecionar um valor de Ponto.');
      Exit;
    end;

  try

    if FBoatID = GUID_NULL then
      begin
        dm_Main.tb_Boat.Append;
        dm_Main.tb_Boat.FieldByName('id'               ).AsGuid  :=  TUUIDv7Helper.CreateV7;
      end
    else
      begin
        if not dm_Main.tb_Boat.Locate('id', GUIDToString(FBoatID)) then
          begin
            TDialogService.ShowMessage(UNEXPECTED_ERROR + 'Boats.btn_SaveClick.tb_Boat.Locate');
            Exit;
          end;

        dm_Main.tb_Boat.Edit;
      end;

    dm_Main.tb_Boat.FieldByName('active'             ).AsBoolean  := switch_Active.IsChecked;
    if POSAdmin then
      begin
        dm_Main.tb_Boat.FieldByName('number'             ).AsString   := edt_Number.Text;
        dm_Main.tb_Boat.FieldByName('defaultMinutes'     ).AsInteger  := StrToIntDef(edt_DefaultMinutes.Text     , 0);
        dm_Main.tb_Boat.FieldByName('defaultValue'       ).AsInteger  := StrToIntDef(edt_DefaultValue.Text       , 0);
        dm_Main.tb_Boat.FieldByName('defaultExtraMinutes').AsInteger  := StrToIntDef(edt_DefaultExtraMinutes.Text, 0);
        dm_Main.tb_Boat.FieldByName('defaultExtraValue'  ).AsInteger  := StrToIntDef(edt_DefaultExtraValue.Text  , 0);
        dm_Main.tb_Boat.FieldByName('color'              ).AsLongWord := edt_ColorPanel.Color;
      end;
    dm_Main.tb_Boat.FieldByName('posId'              ).AsGuid := TComboBoxItemGuid(cb_PoS.Items.Objects[cb_PoS.ItemIndex]).Value;

    dm_Main.tb_Boat.Post;
    dm_Main.tb_Boat.SaveToFile();
  finally
    //
  end;

  Refresh;

  tabCtrl_List.Previous;
end;


procedure Tfrm_Boats.cbPoSClear;
begin
  // Release all object before clear
  for var i := cb_PoS.Items.Count-1 downto 0 do
    begin
      if cb_PoS.Items.Objects[i] <> nil  then
        cb_PoS.Items.Objects[i].Free;
    end;
  cb_PoS.Clear;
end;

procedure Tfrm_Boats.edt_ColorPanelChange(Sender: TObject);
begin
  edt_Color.OnChange := nil;
  edt_Color.Text     := Format('#%.6x', [edt_ColorPanel.Color and $00FFFFFF]);
  edt_Color.OnChange := edt_ColorChange;
end;

procedure Tfrm_Boats.edt_ColorChange(Sender: TObject);
var
  LColor : Integer;
begin
  if not (Length(edt_Color.Text) = 7  ) then Exit;
  if not (edt_Color.Text[1]      = '#') then Exit;
  if not TryStrToInt('$' + Copy(edt_Color.Text,2,6), LColor) then Exit;

  edt_ColorPanel.Color := LColor OR $FF000000;
end;


destructor Tfrm_Boats.Destroy;
begin
  // Make sure to release all objects to avoid memory leak
  cbPoSClear;
  inherited Destroy;
end;


procedure Tfrm_Boats.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  //
end;

procedure Tfrm_Boats.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  if edt_Number.IsFocused               then vScrollBox_Config.ViewportPosition := TPoint.Create(0,   0);
  if edt_DefaultMinutes.IsFocused       then vScrollBox_Config.ViewportPosition := TPoint.Create(0, 100);
  if edt_DefaultValue.IsFocused         then vScrollBox_Config.ViewportPosition := TPoint.Create(0, 100);
  if edt_DefaultExtraMinutes.IsFocused  then vScrollBox_Config.ViewportPosition := TPoint.Create(0, 100);
  if edt_DefaultExtraValue.IsFocused    then vScrollBox_Config.ViewportPosition := TPoint.Create(0, 100);
  if cb_PoS.IsFocused                   then vScrollBox_Config.ViewportPosition := TPoint.Create(0, 100);

end;

procedure Tfrm_Boats.btn_DeleteClick(Sender: TObject);
begin


  TDialogService.MessageDialog( frm_Boat_msg_Delete, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  begin
                                    if AResult = mrYes then
                                      begin

                                        try
                                          if not dm_Main.tb_Boat.Locate('id', GUIDToString(FBoatID)) then
                                            begin
                                              TDialogService.ShowMessage(UNEXPECTED_ERROR + 'Boats.btn_DeleteClick.MessageDialog.tb_Boat.Locate');
                                              Exit;
                                            end;

                                          if dm_Main.tb_Boat.FieldByName('rented').AsBoolean then
                                            begin
                                              TDialogService.ShowMessage( frm_Boat_msg_Delete_Denied );
                                              Exit;
                                            end;

                                          dm_Main.tb_Boat.Delete;
                                          dm_Main.tb_Boat.SaveToFile();
                                        finally

                                        end;

                                        Refresh;
                                        tabCtrl_List.Previous;
                                      end
                                  end);
end;

end.
