unit unt_Rental;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Objects,
  Data.FireDACJSONReflect, Data.DB, Datasnap.DSClientRest, FMX.DialogService, FireDAC.Comp.DataSet,
  FMX.Layouts, FMX.Edit, FMX.Effects, FMX.Controls.Presentation, FMX.TabControl, System.IniFiles,
  unt_Boat, System.Actions, FMX.ActnList, FMX.DateTimeCtrls, FMX.EditBox, FMX.NumberBox, System.DateUtils,
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
  private
    { Private declarations }
    FBoatSizePortrait, FBoatSizeLandscape   : Integer;
    FBoatDefaultValue, FBoatDefaultMinutes  : Integer;
    FBoat : Tfrm_Boat;
    // BASIC HANDLER:
    FTableList                    : TObjectDictionary<String, TFDMemTable>;
    FTable                        : TFDMemTable;
    FBoatsDataSetList             : TFDJSONDataSets;
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
    procedure SetupSize;

    procedure print_receipt;
    procedure BoatOnClick(Sender: TObject);
  end;

const
  frm_Rental_dlg_SetupSize_Title     = 'Ajustes';
  frm_Rental_dlg_SetupSize_DefValue  = 'Padrão - Valor (R$)';
  frm_Rental_dlg_SetupSize_DefMin    = 'Padrão - Minutos (min)';
  frm_Rental_dlg_SetupSize_Portrait  = 'Tamanho Posição Retrato (px)';
  frm_Rental_dlg_SetupSize_Landscape = 'Tamanho Posição Panorama (px)';

implementation

{$R *.fmx}

uses usm_Utils, unt_Utils, unt_Waiting, udm_Server, unt_Printer, unt_Boats, unt_Main,
  unt_ResourceStrings;

//------------------------------------------------------------------------------
// BASE HANDLE
//      Prepare
//      ApplyUpdates
//      Refresh
//------------------------------------------------------------------------------

procedure Tfrm_Rental.Prepare;
var
  iniCFG : TiniFile;
  Table : TFDMemTable;
begin
  tabCtrl_List.ActiveTab := tabItem_List;

  iniCFG := TIniFile.Create(GetPath('KleinAppConfig.ini'));
  try
    FBoatSizePortrait   := iniCFG.ReadInteger('CLIENT', 'BoatSizePortrait'  , 100);
    FBoatSizeLandscape  := iniCFG.ReadInteger('CLIENT', 'BoatSizeLandscape' , 100);
    FBoatDefaultValue   := iniCFG.ReadInteger('CLIENT', 'BoatDefaultValue'  ,  30);
    FBoatDefaultMinutes := iniCFG.ReadInteger('CLIENT', 'BoatDefaultMinutes',  30);
  finally
    iniCFG.DisposeOf;
  end;

  FTableList.Clear;
  FTableList.Add('Boat'  , dm_Server.tb_Boat  );
  FTableList.Add('Rental', dm_Server.tb_Rental);

  //dm_Server.tb_Boat.LoadFromFile();
  //dm_Server.tb_Rental.LoadFromFile();
  for Table in FTableList.Values do
    Table.LoadFromFile();

  BoatsRefresh;
end;

procedure Tfrm_Rental.BoatsRentalApplyUpdates;
var
  ADeltaList: TFDJSONDeltas;
  idx       : Integer;
  Table : TFDMemTable;
begin
  //if dm_Server.tb_Boat.State   in dsEditModes then dm_Server.tb_Boat.Post;
  //if dm_Server.tb_Rental.State in dsEditModes then dm_Server.tb_Rental.Post;
  for Table in FTableList.Values do
    if Table.State   in dsEditModes then Table.Post;

  if frm_Main.Sync = ssOffline then
    begin
      //dm_Server.tb_Boat.SaveToFile;
      //dm_Server.tb_Rental.SaveToFile;
      for Table in FTableList.Values do
        Table.SaveToFile;
      Exit;
    end;

  frm_Main.Sync := ssSyncInProcess;


  //dm_Server.tb_Rental2.Data := dm_Server.tb_Rental;

  ADeltaList := TFDJSONDeltas.Create;
  //TFDJSONDeltasWriter.ListAdd(ADeltaList, 'Rental', dm_Server.tb_Rental);
  //TFDJSONDeltasWriter.ListAdd(ADeltaList, 'Boat'  , dm_Server.tb_Boat  );
  for idx := 0 to FTableList.Count - 1 do
    TFDJSONDeltasWriter.ListAdd(ADeltaList, FTableList.Keys.ToArray[idx], FTableList.Values.ToArray[idx]);


  FBoatsApplyUpdatesErrorMessage := '';

  with TThread.CreateAnonymousThread( procedure
    begin
      try
        try
          dm_Server.CloseSession;
          dm_Server.srvMethodsClient.updateBoatsRental(ADeltaList);
        except
          on E: TDSRestProtocolException do
            HandleRestException(dm_Server.DSRestConnection, 'Apply Updates Error', E, FBoatsApplyUpdatesErrorMessage);
          on E : Exception do
            FBoatsApplyUpdatesErrorMessage := CONNECTION_FAILED_TXT + E.Message;
        end;
      finally
        dm_Server.CloseSession;
      end;
    end
  ) do
    begin
      onTerminate := BoatsRentalApplyUpdatesTerminated;
      Start;
    end;
end;

procedure Tfrm_Rental.BoatsRentalApplyUpdatesTerminated(Sender: TObject);
var
  Table: TFDMemTable;
begin
  try
    dm_Server.CloseSession;

    if not FBoatsApplyUpdatesErrorMessage.IsEmpty then
      begin
        if FBoatsApplyUpdatesErrorMessage.StartsWith(CONNECTION_FAILED_TXT) then
          begin
            // silence error
          end
        else
          begin
            TDialogService.ShowMessage(FBoatsApplyUpdatesErrorMessage);
            dm_Server.tb_Boat.CancelUpdates; // Clear UpdatesPending????
          end;
      end;
  finally
    if FBoatsApplyUpdatesErrorMessage.IsEmpty then
      begin
        frm_Main.Sync := ssSyncOK;
        dm_Server.tb_Rental.CancelUpdates; // Clear UpdatesPending
        dm_Server.tb_Boat.CancelUpdates;   // Clear UpdatesPending
        BoatsRefresh;
      end
    else
      begin
        //dm_Server.tb_Boat.SaveToFile;
        //dm_Server.tb_Rental.SaveToFile;
        for Table in FTableList.Values do
          Table.SaveToFile;

        frm_Main.Sync := ssSyncFailed;
      end;
  end;
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

  if dm_Server.tb_Boat.UpdatesPending or dm_Server.tb_Rental.UpdatesPending  then
    begin
      RefreshGrid;
      BoatsRentalApplyUpdates;
      Exit;
    end;

  FBoatsGetErrorMessage := '';
  Waiting_Show;

  with TThread.CreateAnonymousThread( procedure
    begin
      try
        try
          FBoatsDataSetList := dm_Server.srvMethodsClient.Boat;
        except
          on E: TDSRestProtocolException do
            HandleRestException(dm_Server.DSRestConnection, 'Get Error', E, FBoatsGetErrorMessage);
          on E : Exception do
            FBoatsGetErrorMessage := E.Message;
        end;
      finally

      end;
    end
  ) do
    begin
      onTerminate := BoatsRefreshTerminated;
      Start;
    end;
end;

procedure Tfrm_Rental.BoatsRefreshTerminated(Sender: TObject);
begin
  try
    if not FBoatsGetErrorMessage.IsEmpty then
      begin
        dm_Server.tb_Boat.LoadFromFile;
        frm_Main.ShowAlert(udm_Server_msg_Refresh_Server_Failed);
        //TDialogService.ShowMessage(FBoatsGetErrorMessage);
      end
    else
      begin
        try
          Assert(TFDJSONDataSetsReader.GetListCount(FBoatsDataSetList) = 1);
        except

        end;
        dm_Server.tb_Boat.Active  := False;
        dm_Server.tb_Boat.AppendData(TFDJSONDataSetsReader.GetListValueByName(FBoatsDataSetList, 'Boat')); // Old method, it works without Presistent File
        dm_Server.tb_Boat.CancelUpdates; // Clear UpdatesPending Flag
        dm_Server.tb_Boat.SaveToFile;
      end;
  finally
    dm_Server.CloseSession;
    RefreshGrid;   // dm_Server.tb_boat.Active  := True;
    Waiting_Hide;
  end;
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

  dm_Server.tb_Boat.Active  := True;
  layout_Boats.BeginUpdate;
  dm_Server.tb_Boat.First;
  while not dm_Server.tb_Boat.Eof do
    begin
      with Tfrm_Boat.Create ( layout_Boats, TFmxObject(Self)
                            , dm_Server.tb_Boat.FieldByName('ID'                     ).AsInteger
                            , dm_Server.tb_Boat.FieldByName('Number'                 ).AsString
                            , dm_Server.tb_Boat.FieldByName('Active'                 ).AsBoolean
                            , dm_Server.tb_Boat.FieldByName('Rented'                 ).AsBoolean
                            , dm_Server.tb_Boat.FieldByName('RentedAt'               ).AsDateTime
                            , dm_Server.tb_Boat.FieldByName('AdvancedPaymentValue'   ).AsInteger
                            , dm_Server.tb_Boat.FieldByName('AdvancedPaymentMinutes' ).AsInteger
      ) do
        begin
          rect_Background.OnClick := BoatOnClick;
        end;
      dm_Server.tb_Boat.Next;
    end;
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
  SetupSize;
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

procedure Tfrm_Rental.BoatOnClick(Sender: TObject);
var
  Boat : Tfrm_Boat;
  //Frm_Rental : Tfrm_Rental;
  dateFinish  : TDateTime;
  CalcMinutes, CalcValue : Integer;
begin
  Boat := TFRm_Boat(TRectangle(Sender).Parent);
  if not Boat.FActive then Exit;


  //Frm_Rental := TFrm_Rental( Boat.Frm );

  if not Boat.FRented then
    begin
      Timer.Enabled := False;
      FBoat := Boat;
      edit_RentStartMinutes.Value     := FBoatDefaultMinutes;
      edit_RentStartValue.Value       := FBoatDefaultValue;
      trackBar_RentStartMinutes.Value := FBoatDefaultMinutes;
      lbl_SubTitleStart.Text          := Boat.FNumber;
      cbBox_Payment.ItemIndex         := 0;
      actTabChange_Start.Execute;
    end
  else
    begin
      Timer.Enabled := False;
      FBoat := Boat;
      dateFinish := Now;
      CalcMinutes := SecondsBetween( dateFinish, Boat.FRentedAt);
      CalcValue   := CalcMinutes;

      edit_RentFinishStartMinutes.Value := Boat.FAdvancedPaymentMinutes;
      edit_RentFinishStartValue.Value   := Boat.FAdvancedPaymentValue;
      edit_RentFinishStartDate.Date     := Boat.FRentedAt;
      edit_RentFinishStartHour.Time     := Boat.FRentedAt;
      edit_RentFinishCalcMinutes.Value  := CalcMinutes;
      edit_RentFinishCalcValue.Value    := CalcValue;
      edit_RentFinishMinutes.Value      := Boat.FAdvancedPaymentMinutes;
      edit_RentFinishValue.Value        := Boat.FAdvancedPaymentValue;
      switch_RentFinishChange.IsChecked := False;
      lbl_SubTitleFinish.Text := Boat.FNumber;
      actTabChange_Finish.Execute;
    end;
  //ShowMessage( Boat.lbl_Number.Text );
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

  if dm_Server.tb_Boat.Locate('ID', FBoat.FID) then
    begin

        dm_Server.tb_Boat.Edit;
        dm_Server.tb_Boat.FieldByName('Rented'                ).AsBoolean  := True;
        dm_Server.tb_Boat.FieldByName('RentedAt'              ).AsDateTime := Now;
        dm_Server.tb_Boat.FieldByName('AdvancedPaymentValue'  ).AsInteger  := Trunc(edit_RentStartValue.Value);
        dm_Server.tb_Boat.FieldByName('AdvancedPaymentMinutes').AsInteger  := Trunc(edit_RentStartMinutes.Value);
        dm_Server.tb_Boat.Post;

        FBoat.FRented                 := dm_Server.tb_Boat.FieldByName('Rented'                ).AsBoolean;
        FBoat.FRentedAt               := dm_Server.tb_Boat.FieldByName('RentedAt'              ).AsDateTime;
        FBoat.FAdvancedPaymentValue   := dm_Server.tb_Boat.FieldByName('AdvancedPaymentValue'  ).AsInteger;
        FBoat.FAdvancedPaymentMinutes := dm_Server.tb_Boat.FieldByName('AdvancedPaymentMinutes').AsInteger;

        BoatsRentalApplyUpdates;
        FBoat.Update( Now );

        actTabChange_List.Execute;
        Timer.Enabled := True;

        print_receipt;
    end;
end;

procedure Tfrm_Rental.trackBar_RentStartMinutesChange(Sender: TObject);
begin
  edit_RentStartMinutes.Value := trackBar_RentStartMinutes.Value;
  edit_RentStartValue.Value   := trackBar_RentStartMinutes.Value;
end;

procedure Tfrm_Rental.btn_RentFinishClick(Sender: TObject);
begin
  if not getSettings_AutoTime then
    begin
      TDialogService.ShowMessage(msg_AutoTime_Off);
      Exit;
    end;

  if dm_Server.tb_Boat.Locate('ID', FBoat.FID) then
    begin
        // Update Boat
        dm_Server.tb_Boat.Edit;
        dm_Server.tb_Boat.FieldByName('Rented'                ).AsBoolean  := False;
        dm_Server.tb_Boat.FieldByName('RentedAt'              ).Clear;
        dm_Server.tb_Boat.FieldByName('AdvancedPaymentValue'  ).Clear;
        dm_Server.tb_Boat.FieldByName('AdvancedPaymentMinutes').Clear;
        dm_Server.tb_Boat.Post;

        // Add Rental Record
        dm_Server.tb_Rental.Open;
        dm_Server.tb_Rental.Append;
        dm_Server.tb_Rental.FieldByName('Boat_ID'               ).AsInteger  := FBoat.FID;
        dm_Server.tb_Rental.FieldByName('Number'                ).AsString   := FBoat.FNumber;
        dm_Server.tb_Rental.FieldByName('RentedAt'              ).AsDateTime := FBoat.FRentedAt;
        dm_Server.tb_Rental.FieldByName('RentFinishedAt'        ).AsDateTime := Now;
        dm_Server.tb_Rental.FieldByName('AdvancedPaymentValue'  ).AsInteger  := Trunc(edit_RentFinishStartValue.Value);
        dm_Server.tb_Rental.FieldByName('AdvancedPaymentMinutes').AsInteger  := Trunc(edit_RentFinishStartMinutes.Value);
        dm_Server.tb_Rental.FieldByName('CalculedPaymentValue'  ).AsInteger  := Trunc(edit_RentFinishCalcValue.Value);
        dm_Server.tb_Rental.FieldByName('CalculedPaymentMinutes').AsInteger  := Trunc(edit_RentFinishCalcMinutes.Value);
        dm_Server.tb_Rental.FieldByName('PaymentChanged'        ).AsBoolean  := switch_RentFinishChange.IsChecked;
        dm_Server.tb_Rental.FieldByName('PaymentValue'          ).AsInteger  := Trunc(edit_RentFinishValue.Value);
        dm_Server.tb_Rental.FieldByName('PaymentMinutes'        ).AsInteger  := Trunc(edit_RentFinishMinutes.Value);
        dm_Server.tb_Rental.Post;

        // Update local variable
        FBoat.FRented                 := dm_Server.tb_Boat.FieldByName('Rented'                ).AsBoolean;
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

procedure Tfrm_Rental.SetupSize;
var
  strPrompts, strValues : array[0..3] of String;

begin
  strPrompts[0] := frm_Rental_dlg_SetupSize_DefValue;
  strPrompts[1] := frm_Rental_dlg_SetupSize_DefMin;
  strPrompts[2] := frm_Rental_dlg_SetupSize_Portrait;
  strPrompts[3] := frm_Rental_dlg_SetupSize_Landscape;

  strValues[0] := IntToStr(FBoatDefaultValue );
  strValues[1] := IntToStr(FBoatDefaultMinutes);
  strValues[2] := IntToStr(FBoatSizePortrait );
  strValues[3] := IntToStr(FBoatSizeLandscape);

  TDialogService.InputQuery ( frm_Rental_dlg_SetupSize_Title, strPrompts, strValues,
                              procedure(const AResult: TModalResult; const AValues: array of string)
                                var
                                  iniCFG : TiniFile;
                                begin
                                  if AResult = mrOK then
                                    begin
                                      iniCFG := TIniFile.Create(GetPath('KleinAppConfig.ini'));
                                      try
                                        FBoatDefaultValue   := StrToIntDef(AValues[0],  30);
                                        FBoatDefaultMinutes := StrToIntDef(AValues[1],  30);
                                        FBoatSizePortrait   := StrToIntDef(AValues[2], 100);
                                        FBoatSizeLandscape  := StrToIntDef(AValues[3], 100);
                                        iniCFG.WriteInteger ('CLIENT', 'BoatDefaultValue'  , FBoatDefaultValue   );
                                        iniCFG.WriteInteger ('CLIENT', 'BoatDefaultMinutes', FBoatDefaultMinutes );
                                        iniCFG.WriteInteger ('CLIENT', 'BoatSizePortrait'  , FBoatSizePortrait   );
                                        iniCFG.WriteInteger ('CLIENT', 'BoatSizeLandscape' , FBoatSizeLandscape  );
                                      finally
                                        iniCFG.DisposeOf;
                                      end;
                                    end;
                                end
                            );
  DoFixLayoutSize;
end;

//------------------------------------------------------------------------------
// PRINT
//------------------------------------------------------------------------------

procedure Tfrm_Rental.print_receipt;
var
  xLineSeq, xLineObs, xLineDate, XLineValue, xLineMin : String;
begin
  xLineSeq   := '00' + '     ' + FBoat.FNumber;
  xLineDate  := 'Data  : '     + FormatDateTime( 'dd/MM/yyyy HH:mm', FBoat.FRentedAt );
  XLineValue := 'Valor : R$ '  +       IntToStr( FBoat.FAdvancedPaymentValue         ) + ',00';
  xLineMin   := 'Tempo : '     +       IntToStr( FBoat.FAdvancedPaymentMinutes       ) + ' min';
  xLineObs   := 'R$ 10,00 a cada 10 min excedente';



  BTSendData( EP_INITIALIZE_PRINTER           );
  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH ));
  BTSendData( 'PEDALINHOS KLEIN' + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));
  BTSendData( 'RECIBO' + EP_LF + EP_LF );
  BTSendData( '   Senha     Pedalinho/Boat' + EP_PRINT );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH OR EP_MODE_DOUBLE_HEIGHT OR EP_MODE_EMPHASIZED ));
//BTSendData( '01     G01' + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT  );
  BTSendData( xLineSeq + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT  );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));
  BTSendData( EP_SELECT_JUSTIFICATION_LEFT  );

  BTSendData( EP_LF );
//BTSendData( 'Data  : 01/01/2019 13:00' + EP_PRINT );
//BTSendData( 'Valor : R$ 30,00'         + EP_PRINT );
//BTSendData( 'Tempo : 30 min'           + EP_PRINT );
  BTSendData( xLineDate  + EP_PRINT );
  BTSendData( XLineValue + EP_PRINT );
  BTSendData( xLineMin   + EP_PRINT );
  BTSendData( EP_LF );

  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );
//BTSendData( 'R$ 10,00 a cada 10 min excedente' + EP_PRINT );
  BTSendData( xLineObs + EP_PRINT );

  BTSendData(  EP_PRINT + EP_PRINT );
end;

//------------------------------------------------------------------------------
// TIMER
//----------------------------------------------------------------------------

procedure Tfrm_Rental.TimerTimer(Sender: TObject);
var
  I : Integer;
  xDate : TDatetime;

begin
  layout_Boats.BeginUpdate;
  xDate := Now;
  for I := 0 to layout_Boats.Controls.Count - 1 do
    begin
      TFrm_Boat(layout_Boats.Controls.Items[I]).Update( xDate );
    end;
  layout_Boats.EndUpdate;
end;

end.
