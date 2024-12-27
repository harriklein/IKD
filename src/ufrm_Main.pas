unit ufrm_Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.Objects, FMX.ListBox,
  FMX.Layouts, FMX.MultiView, System.ImageList, FMX.ImgList, FMX.Effects,
  System.Bluetooth, System.Bluetooth.Components, System.IniFiles;

type
  TSyncStatus = (ssOffline, ssSyncOK, ssSyncFailed, ssSyncInProcess);

  Tfrm_Main = class(TForm)
    images_MultiView: TImageList;
    layout_Content: TLayout;
    rect_ToolBar: TRectangle;
    path_Cloud: TPath;
    path_Offline: TPath;
    path_Sync: TPath;
    floatAni_Sync: TFloatAnimation;
    path_SyncOK: TPath;
    path_SyncFailed: TPath;
    btn_MasterMenu: TSpeedButton;
    lbl_Title: TLabel;
    shadow_ToolBar: TShadowEffect;
    Bluetooth: TBluetooth;
    layout_Main: TLayout;
    rect_MenuPanel: TRectangle;
    rect_MenuHeader: TRectangle;
    path_Logo: TPath;
    btn_MenuRental: TSpeedButton;
    rect_MenuFooter: TRectangle;
    lbl_MenuAdministration: TLabel;
    btn_MenuUsers: TSpeedButton;
    btn_MenuConfig: TSpeedButton;
    btn_MenuBoats: TSpeedButton;
    btn_MenuReport: TSpeedButton;
    lbl_version: TLabel;
    btn_Logout: TSpeedButton;
    path_MenuBoats: TPath;
    path_MenuRental: TPath;
    path_MenuUsers: TPath;
    path_MenuConfig: TPath;
    path_MenuReport: TPath;
    path_Logout: TPath;
    rect_Menu: TRectangle;
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_MasterMenuClick(Sender: TObject);
    procedure btn_MenuClick(Sender: TObject);
    procedure rect_MenuClick(Sender: TObject);
  private
    { Private declarations }
    FSync : TSyncStatus;
    procedure SetSync(const AValue: TSyncStatus);
    procedure InitSync;
  public
    { Public declarations }
    property Sync : TSyncStatus read FSync write SetSync;

    function  CreateEmbeddedFrame(AForm: TComponentClass): TFrame;
    procedure RemoveEmbeddedFrame;
  end;

var
  frm_Main: Tfrm_Main;
  frm_Active : TFrame = nil;

implementation

{$R *.fmx}

uses FMX.DialogService, unt_Printer, ufrm_Login, ufrm_Default, ufrm_Config, unt_DeviceUtils,
  ufrm_Boats, ufrm_Rental, ufrm_Report;


//******************************************************************************
// KEYBOARD ADJUST
//******************************************************************************

// shrink form to fit content when show keyboard
procedure Tfrm_Main.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  frm_Main.Padding.Bottom := Bounds.Height;

  if frm_Active is Tfrm_Rental then
    begin
     Tfrm_Rental(frm_Active).FormVirtualKeyboardShown(Sender, KeyboardVisible, Bounds);
    end;
end;

procedure Tfrm_Main.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  frm_Main.Padding.Bottom := 0;
end;

//******************************************************************************
// EMBEDDED FRAME
//******************************************************************************

function Tfrm_Main.CreateEmbeddedFrame(AForm: TComponentClass): TFrame;
begin
  RemoveEmbeddedFrame();

  frm_Active        := TFrame(AForm.Create(frm_Main));
  frm_Active.Parent := layout_Content;
  lbl_Title.Text    := frm_Active.Hint;

  Result := frm_Active;
end;

procedure Tfrm_Main.RemoveEmbeddedFrame;
begin
  if Assigned(frm_Active) then
    begin
      lbl_Title.Text := Caption;
      frm_Active.Free;
      frm_Active := nil;
    end;
end;

//******************************************************************************
// SYNC
//******************************************************************************

procedure Tfrm_Main.InitSync;
begin
  Sync := ssOffline;  // Set the initial state, it is just to make sure.
end;

procedure Tfrm_Main.SetSync(const AValue: TSyncStatus);
begin
  FSync := AValue;
  case AValue of
    ssOffline       : begin
                        path_Offline.Visible     := True;
                        path_SyncOK.Visible      := False;
                        path_SyncFailed.Visible  := False;
                        path_Sync.Visible        := False;
                        floatAni_Sync.Stop;
                      end;
    ssSyncOK        : begin
                        path_Offline.Visible     := False;
                        path_SyncOK.Visible      := True;
                        path_SyncFailed.Visible  := False;
                        path_Sync.Visible        := False;
                        floatAni_Sync.Stop;
                      end;
    ssSyncFailed    : begin
                        path_Offline.Visible     := False;
                        path_SyncOK.Visible      := False;
                        path_SyncFailed.Visible  := True;
                        path_Sync.Visible        := False;
                        floatAni_Sync.Stop;
                      end;
    ssSyncInProcess : begin
                        path_Offline.Visible     := False;
                        path_SyncOK.Visible      := False;
                        path_SyncFailed.Visible  := False;
                        path_Sync.Visible        := True;
                        floatAni_Sync.Start;
                      end;
  end;
end;


//******************************************************************************
// MENU
//******************************************************************************

procedure Tfrm_Main.btn_MasterMenuClick(Sender: TObject);
begin
  rect_Menu.Visible := not rect_Menu.Visible;
end;

procedure Tfrm_Main.btn_MenuClick(Sender: TObject);
begin
  // --- Embedded from
  // Use property TAG of the Items to define the form
  case TSpeedButton(Sender).Tag of
      1 : begin Tfrm_Rental(CreateEmbeddedFrame( Tfrm_Rental )).Prepare; end;
//
//     10 : begin Tfrm_Users (EmbeddFrame( Tfrm_Users  )).Prepare; end;
     11 : begin Tfrm_Boats (CreateEmbeddedFrame( Tfrm_Boats  )).Prepare; end;
     12 : begin Tfrm_Config(CreateEmbeddedFrame( Tfrm_Config )).Prepare; end;
     13 : begin Tfrm_Report(CreateEmbeddedFrame( Tfrm_Report )).Prepare; end;

     999: begin
               RemoveEmbeddedFrame;
               Login_Show;
          end;
  else
    Tfrm_Default(CreateEmbeddedFrame( Tfrm_Default )).Prepare;
  end;

  rect_Menu.Visible := False;
end;

procedure Tfrm_Main.rect_MenuClick(Sender: TObject);
begin
  rect_Menu.Visible := False;
end;

//******************************************************************************

procedure Tfrm_Main.FormCreate(Sender: TObject);
var
  LIniConfig: TIniFile;
begin

  // Set the initial state, at the design enviroment it is better to keep it showing.
  rect_Menu.Visible := False;
  lbl_Title.Text    := Caption;
  lbl_version.Text  := lbl_version.Text + ' '  + getAppVersion();

  // Set the initial state, it is just to make sure.
  InitSync;

  // Create User object to store the user information
  // User := TUser.Create;

  PRINTER_BLUETOOTH := Bluetooth;
  LIniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
  try
    PRINTER_NAME   := LIniConfig.ReadString('CLIENT', 'Printer'      , ''  );
    PRINTER_ENABLE := LIniConfig.ReadBool  ('CLIENT', 'PrinterEnable', True);
  finally
    LIniConfig.Free;
  end;

  if BTConnectPrinter(PRINTER_NAME) then
    begin
      BTSendData( EP_INITIALIZE_PRINTER );
    end;

  // Show default frame
  Tfrm_Default(CreateEmbeddedFrame( Tfrm_Default )).Prepare;
end;


procedure Tfrm_Main.FormDestroy(Sender: TObject);
begin
  RemoveEmbeddedFrame();
end;

//******************************************************************************



end.
