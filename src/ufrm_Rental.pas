unit ufrm_Rental;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects,
  Data.DB, FMX.DialogService, FireDAC.Comp.DataSet,
  FMX.Layouts, FMX.Edit, FMX.Effects, FMX.Controls.Presentation, FMX.TabControl, System.IniFiles,
  ufrm_Boat, System.Actions, FMX.ActnList, FMX.DateTimeCtrls, FMX.EditBox, FMX.NumberBox, System.DateUtils,
  FMX.ListBox, FMX.ScrollBox, FMX.Memo, System.Generics.Collections, FireDAC.Comp.Client;

type
  Tfrm_Rental = class(TFrame)
    tabCtrl_List: TTabControl;
    tabItem_List: TTabItem;
    toolBar_List: TToolBar;
    shadow_List: TShadowEffect;
    btn_Config: TSpeedButton;
    path_Add: TPath;
    tabItem_Start: TTabItem;
    toolBar_Detail: TToolBar;
    shadow_Detail: TShadowEffect;
    btn_Cancel: TSpeedButton;
    layout_Boats: TGridLayout;
    VertScrollBox1: TVertScrollBox;
    timer_UpdateSize: TTimer;
    tabItem_Finish: TTabItem;
    vScroll_RentStart: TVertScrollBox;
    layout_RentStart: TFlowLayout;
    layout_RentStart1: TLayout;
    trackBar_RentStartMinutes: TTrackBar;
    edit_RentStartMinutes: TNumberBox;
    lbl_RentStartMinutesMin: TLabel;
    edit_RentStartValue: TNumberBox;
    lbl_RentStartValueCurrency: TLabel;
    lbl_RentStartValueCents: TLabel;
    btn_RentStart: TButton;
    ToolBar1: TToolBar;
    ShadowEffect1: TShadowEffect;
    btn_CancelFinish: TSpeedButton;
    vScroll_RentFinish: TVertScrollBox;
    layout_RentFinish: TFlowLayout;
    layout_RentFinish1: TLayout;
    edit_RentFinishStartHour: TTimeEdit;
    edit_RentFinishStartDate: TDateEdit;
    edit_RentFinishStartMinutes: TNumberBox;
    Label1: TLabel;
    edit_RentFinishStartValue: TNumberBox;
    Label2: TLabel;
    Label3: TLabel;
    lbl_Start: TLabel;
    layout_RentFinish2: TLayout;
    edit_RentFinishCalcMinutes: TNumberBox;
    Label4: TLabel;
    Label5: TLabel;
    edit_RentFinishCalcValue: TNumberBox;
    Label6: TLabel;
    lbl_Calculation: TLabel;
    layout_RentFinish3: TLayout;
    btn_RentFinish: TButton;
    edit_RentFinishMinutes: TNumberBox;
    Label7: TLabel;
    Label8: TLabel;
    edit_RentFinishValue: TNumberBox;
    Label9: TLabel;
    lbl_Finish: TLabel;
    switch_RentFinishChange: TSwitch;
    rect_TitleRentFinishImage: TRectangle;
    Rectangle1: TRectangle;
    ActionList: TActionList;
    actTabChange_Start: TChangeTabAction;
    actTabChange_Finish: TChangeTabAction;
    actTabChange_List: TChangeTabAction;
    lbl_SubTitleStart: TLabel;
    lbl_SubTitleFinish: TLabel;
    Timer: TTimer;
    btn_Refresh: TSpeedButton;
    cbBox_Payment: TComboBox;
    Edit1: TEdit;
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
    edt_ConfigMinutes: TNumberBox;
    lbl_ConfigMinutes1: TLabel;
    edt_ConfigValue: TNumberBox;
    lbl_ConfigValue2: TLabel;
    lbl_ConfigValue1: TLabel;
    btn_ConfigSave: TButton;
    lbl_ConfigMinutes: TLabel;
    lbl_ConfigValue: TLabel;
    edt_ConfigSizePortrait: TNumberBox;
    lbl_ConfigSizePortrait: TLabel;
    lbl_ConfigSizePortrait1: TLabel;
    edt_ConfigSizeLandscape: TNumberBox;
    lbl_ConfigSizeLandscape: TLabel;
    lbl_ConfigSizeLandscape1: TLabel;
    actTabChange_Config: TChangeTabAction;
    procedure layout_BoatsResized(Sender: TObject);
    procedure btn_ConfigClick(Sender: TObject);
    procedure timer_UpdateSizeTimer(Sender: TObject);
    procedure btn_RentStartClick(Sender: TObject);
    procedure btn_RentFinishClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_CancelFinishClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure trackBar_RentStartMinutesChange(Sender: TObject);
    procedure switch_RentFinishChangeSwitch(Sender: TObject);
    procedure btn_ConfigSaveClick(Sender: TObject);
  private
    { Private declarations }
    FBoat                         : Tfrm_Boat;

    FBoatSizePortrait, FBoatSizeLandscape   : Integer;
    FBoatDefaultValue, FBoatDefaultMinutes  : Integer;

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
    procedure print_receipt;
    procedure BoatOnClick(Sender: TObject);
    procedure BoatOnTap(Sender: TObject; const Point: TPointF);
  end;

const
  frm_Rental_dlg_SetupSize_Title     = 'Ajustes';
  frm_Rental_dlg_SetupSize_DefValue  = 'Padrão - Valor (R$)';
  frm_Rental_dlg_SetupSize_DefMin    = 'Padrão - Minutos (min)';
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
  _IniConfig : TiniFile;
begin
  tabCtrl_List.ActiveTab := tabItem_List;

  _IniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
  try
    FBoatSizePortrait   := _IniConfig.ReadInteger('CLIENT', 'BoatSizePortrait'  , 100);
    FBoatSizeLandscape  := _IniConfig.ReadInteger('CLIENT', 'BoatSizeLandscape' , 100);
    FBoatDefaultValue   := _IniConfig.ReadInteger('CLIENT', 'BoatDefaultValue'  ,  30);
    FBoatDefaultMinutes := _IniConfig.ReadInteger('CLIENT', 'BoatDefaultMinutes',  30);
  finally
    _IniConfig.Free;
  end;

  dm_Main.tb_Boat.LoadFromFile();
  dm_Main.tb_Rental.LoadFromFile();

  BoatsRefresh();
end;

procedure Tfrm_Rental.BoatsRentalApplyUpdates;
var
//  ADeltaList: TFDJSONDeltas;
  _idx       : Integer;
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
                            , dm_Main.tb_Boat.FieldByName('Number'                 ).AsString
                            , dm_Main.tb_Boat.FieldByName('Active'                 ).AsBoolean
                            , TAlphaColor(dm_Main.tb_Boat.FieldByName('Color'      ).AsLongWord)
                            , dm_Main.tb_Boat.FieldByName('DefaultValue'           ).AsInteger
                            , dm_Main.tb_Boat.FieldByName('Rented'                 ).AsBoolean
                            , dm_Main.tb_Boat.FieldByName('RentedAt'               ).AsDateTime
                            , dm_Main.tb_Boat.FieldByName('AdvancedPaymentValue'   ).AsInteger
                            , dm_Main.tb_Boat.FieldByName('AdvancedPaymentMinutes' ).AsInteger
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
  edt_ConfigValue.Value         := FBoatDefaultValue;
  edt_ConfigMinutes.Value       := FBoatDefaultMinutes;
  edt_ConfigSizePortrait.Value  := FBoatSizePortrait;
  edt_ConfigSizeLandscape.Value := FBoatSizeLandscape;

  actTabChange_Config.Execute;
end;

procedure Tfrm_Rental.btn_ConfigSaveClick(Sender: TObject);
var
  _IniConfig : TiniFile;
begin
  _IniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
  try
    FBoatDefaultValue   := Trunc(edt_ConfigValue.Value);
    FBoatDefaultMinutes := Trunc(edt_ConfigMinutes.Value);
    FBoatSizePortrait   := Trunc(edt_ConfigSizePortrait .Value);
    FBoatSizeLandscape  := Trunc(edt_ConfigSizeLandscape .Value);
    _IniConfig.WriteInteger ('CLIENT', 'BoatDefaultValue'  , FBoatDefaultValue   );
    _IniConfig.WriteInteger ('CLIENT', 'BoatDefaultMinutes', FBoatDefaultMinutes );
    _IniConfig.WriteInteger ('CLIENT', 'BoatSizePortrait'  , FBoatSizePortrait   );
    _IniConfig.WriteInteger ('CLIENT', 'BoatSizeLandscape' , FBoatSizeLandscape  );
  finally
    _IniConfig.Free;
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
  _Boat : Tfrm_Boat;
  _DateFinish  : TDateTime;
  _CalcMinutes, _CalcValue : Integer;
begin
  _Boat := TFrm_Boat(TRectangle(Sender).Parent);
  if not _Boat.FActive then Exit;

  if not _Boat.FRented then
    begin
      Timer.Enabled                   := False;
      FBoat                           := _Boat;
      edit_RentStartMinutes.Value     := FBoatDefaultMinutes;
      if _Boat.FDefaultValue = 0 then
        edit_RentStartValue.Value       := FBoatDefaultValue
      else
        edit_RentStartValue.Value       := _Boat.FDefaultValue;
      trackBar_RentStartMinutes.Value := 1;
      lbl_SubTitleStart.Text          := _Boat.FNumber;
      cbBox_Payment.ItemIndex         := 0;
      actTabChange_Start.Execute;
    end
  else
    begin
      Timer.Enabled := False;
      FBoat         := _Boat;
      _DateFinish   := Now;
      _CalcMinutes  := SecondsBetween( _DateFinish, _Boat.FRentedAt);
      _CalcValue    := _CalcMinutes;

      edit_RentFinishStartMinutes.Value := _Boat.FAdvancedPaymentMinutes;
      edit_RentFinishStartValue.Value   := _Boat.FAdvancedPaymentValue;
      edit_RentFinishStartDate.Date     := _Boat.FRentedAt;
      edit_RentFinishStartHour.Time     := _Boat.FRentedAt;
      edit_RentFinishCalcMinutes.Value  := _CalcMinutes;
      edit_RentFinishCalcValue.Value    := _CalcValue;
      edit_RentFinishMinutes.Value      := _Boat.FAdvancedPaymentMinutes;
      edit_RentFinishValue.Value        := _Boat.FAdvancedPaymentValue;
      switch_RentFinishChange.IsChecked := False;
      lbl_SubTitleFinish.Text           := _Boat.FNumber;
      actTabChange_Finish.Execute;
    end;

end;

//------------------------------------------------------------------------------
// RENTAL
//    Start
//      Track Minute Change
//    Finish
//------------------------------------------------------------------------------

procedure Tfrm_Rental.btn_RentStartClick(Sender: TObject);
begin
  if cbBox_Payment.ItemIndex < 1 then
    begin
      TDialogService.ShowMessage('Selecione uma forma de pagamento.');
      Exit;
    end;

  if not getSettings_AutoTime then
    begin
      TDialogService.ShowMessage(msg_AutoTime_Off);
      Exit;
    end;

  if dm_Main.tb_Boat.Locate('Number', FBoat.FNumber) then
    begin

        dm_Main.tb_Boat.Edit;
        dm_Main.tb_Boat.FieldByName('Rented'                ).AsBoolean  := True;
        dm_Main.tb_Boat.FieldByName('RentedAt'              ).AsDateTime := Now;
        dm_Main.tb_Boat.FieldByName('AdvancedPaymentValue'  ).AsInteger  := Trunc(edit_RentStartValue.Value);
        dm_Main.tb_Boat.FieldByName('AdvancedPaymentMinutes').AsInteger  := Trunc(edit_RentStartMinutes.Value);
        dm_Main.tb_Boat.Post;

        FBoat.FRented                 := dm_Main.tb_Boat.FieldByName('Rented'                ).AsBoolean;
        FBoat.FRentedAt               := dm_Main.tb_Boat.FieldByName('RentedAt'              ).AsDateTime;
        FBoat.FAdvancedPaymentValue   := dm_Main.tb_Boat.FieldByName('AdvancedPaymentValue'  ).AsInteger;
        FBoat.FAdvancedPaymentMinutes := dm_Main.tb_Boat.FieldByName('AdvancedPaymentMinutes').AsInteger;

        BoatsRentalApplyUpdates;
        FBoat.Update( Now );

        actTabChange_List.Execute;
        Timer.Enabled := True;

        print_receipt;
    end;
end;

procedure Tfrm_Rental.trackBar_RentStartMinutesChange(Sender: TObject);
var
  _Value : Integer;
begin
  if FBoat.FDefaultValue = 0 then
    _Value       := FBoatDefaultValue
  else
    _Value       := FBoat.FDefaultValue;
  edit_RentStartMinutes.Value := trackBar_RentStartMinutes.Value * FBoatDefaultMinutes;
  edit_RentStartValue.Value   := trackBar_RentStartMinutes.Value * _Value;
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
        dm_Main.tb_Boat.FieldByName('Rented'                ).AsBoolean  := False;
        dm_Main.tb_Boat.FieldByName('RentedAt'              ).Clear;
        dm_Main.tb_Boat.FieldByName('AdvancedPaymentValue'  ).Clear;
        dm_Main.tb_Boat.FieldByName('AdvancedPaymentMinutes').Clear;
        dm_Main.tb_Boat.Post;

        // Add Rental Record
        dm_Main.tb_Rental.Open;
        dm_Main.tb_Rental.Append;
        // dm_Main.tb_Rental.FieldByName('Boat_ID'            ).AsInteger  := FBoat.FID;
        dm_Main.tb_Rental.FieldByName('id'                    ).AsGuid     := TUUIDv7Helper.CreateV7;
        dm_Main.tb_Rental.FieldByName('Number'                ).AsString   := FBoat.FNumber;
        dm_Main.tb_Rental.FieldByName('RentedAt'              ).AsDateTime := FBoat.FRentedAt;
        dm_Main.tb_Rental.FieldByName('RentFinishedAt'        ).AsDateTime := Now;
        dm_Main.tb_Rental.FieldByName('AdvancedPaymentValue'  ).AsInteger  := Trunc(edit_RentFinishStartValue.Value);
        dm_Main.tb_Rental.FieldByName('AdvancedPaymentMinutes').AsInteger  := Trunc(edit_RentFinishStartMinutes.Value);
        dm_Main.tb_Rental.FieldByName('CalculedPaymentValue'  ).AsInteger  := Trunc(edit_RentFinishCalcValue.Value);
        dm_Main.tb_Rental.FieldByName('CalculedPaymentMinutes').AsInteger  := Trunc(edit_RentFinishCalcMinutes.Value);
        dm_Main.tb_Rental.FieldByName('PaymentChanged'        ).AsBoolean  := switch_RentFinishChange.IsChecked;
        dm_Main.tb_Rental.FieldByName('PaymentValue'          ).AsInteger  := Trunc(edit_RentFinishValue.Value);
        dm_Main.tb_Rental.FieldByName('PaymentMinutes'        ).AsInteger  := Trunc(edit_RentFinishMinutes.Value);
        dm_Main.tb_Rental.Post;

        // Update local variable
        FBoat.FRented                 := dm_Main.tb_Boat.FieldByName('Rented'                ).AsBoolean;
        //FBoat.FRentedAt               := Now; // Keep last Rent
        FBoat.FAdvancedPaymentValue   := 0;
        FBoat.FAdvancedPaymentMinutes := 0;

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

procedure Tfrm_Rental.switch_RentFinishChangeSwitch(Sender: TObject);
begin
  edit_RentFinishMinutes.Enabled := switch_RentFinishChange.isChecked;
  edit_RentFinishValue.Enabled   := switch_RentFinishChange.isChecked;

  if switch_RentFinishChange.isChecked then
    begin
      edit_RentFinishMinutes.Text := edit_RentFinishCalcMinutes.Text;
      edit_RentFinishValue.Text   := edit_RentFinishCalcValue.Text;
    end
  else
    begin
      edit_RentFinishMinutes.Text := edit_RentFinishStartMinutes.Text;
      edit_RentFinishValue.Text   := edit_RentFinishStartValue.Text;
    end;
end;

//------------------------------------------------------------------------------
// PRINT
//------------------------------------------------------------------------------

procedure Tfrm_Rental.print_receipt;
var
  _LineSeq, _LineObs, _LineDate, _LineValue, _LineMin : String;
begin

  Exit;

  _LineSeq   := '00' + '     ' + FBoat.FNumber;
  _LineDate  := 'Data  : '     + FormatDateTime( 'dd/MM/yyyy HH:mm', FBoat.FRentedAt );
  _LineValue := 'Valor : R$ '  +       IntToStr( FBoat.FAdvancedPaymentValue         ) + ',00';
  _LineMin   := 'Tempo : '     +       IntToStr( FBoat.FAdvancedPaymentMinutes       ) + ' min';
  _LineObs   := 'R$ 10,00 a cada 10 min excedente';



  BTSendData( EP_INITIALIZE_PRINTER           );
  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH ));
  BTSendData( 'PEDALINHOS KLEIN' + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));
  BTSendData( 'RECIBO' + EP_LF + EP_LF );
  BTSendData( '   Senha     Pedalinho/Boat' + EP_PRINT );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH OR EP_MODE_DOUBLE_HEIGHT OR EP_MODE_EMPHASIZED ));
//BTSendData( '01     G01' + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT  );
  BTSendData( _LineSeq + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT  );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));
  BTSendData( EP_SELECT_JUSTIFICATION_LEFT  );

  BTSendData( EP_LF );
//BTSendData( 'Data  : 01/01/2019 13:00' + EP_PRINT );
//BTSendData( 'Valor : R$ 30,00'         + EP_PRINT );
//BTSendData( 'Tempo : 30 min'           + EP_PRINT );
  BTSendData( _LineDate  + EP_PRINT );
  BTSendData( _LineValue + EP_PRINT );
  BTSendData( _LineMin   + EP_PRINT );
  BTSendData( EP_LF );

  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );
//BTSendData( 'R$ 10,00 a cada 10 min excedente' + EP_PRINT );
  BTSendData( _LineObs + EP_PRINT );

  BTSendData(  EP_LF + EP_LF + EP_LF + EP_LF + EP_LF + EP_PRINT );
end;

//------------------------------------------------------------------------------
// TIMER
//----------------------------------------------------------------------------

procedure Tfrm_Rental.TimerTimer(Sender: TObject);
var
  _Idx  : integer;
  _Date : TDatetime;
begin
  layout_Boats.BeginUpdate;
  _Date := Now;
  for _Idx := 0 to layout_Boats.Controls.Count - 1 do
    begin
      TFrm_Boat(layout_Boats.Controls.Items[_Idx]).Update(_Date);
    end;
  layout_Boats.EndUpdate;
end;

end.
