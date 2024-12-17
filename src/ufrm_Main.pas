unit ufrm_Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.Objects, FMX.ListBox,
  FMX.Layouts, FMX.MultiView, System.ImageList, FMX.ImgList, FMX.Effects,
  System.Bluetooth, System.Bluetooth.Components;

type
  TSyncStatus = (ssOffline, ssSyncOK, ssSyncFailed, ssSyncInProcess);

  Tfrm_Main = class(TForm)
    ballon: TRectangle;
    ShadowEffect1: TShadowEffect;
    ballon_Message: TLabel;
    ballon_ani: TFloatAnimation;
    ballon_Close: TSpeedButton;
    images_MultiView: TImageList;
    Lang: TLang;
    layout_Content: TLayout;
    toolBar: TToolBar;
    rect_ToolBar: TRectangle;
    path_Cloud: TPath;
    path_Offline: TPath;
    path_Sync: TPath;
    floatAni_Sync: TFloatAnimation;
    path_SyncOK: TPath;
    path_SyncFailed: TPath;
    btn_MasterMenu: TSpeedButton;
    lbl_Title: TLabel;
    shadow_Title: TShadowEffect;
    ColorKeyAnimation1: TColorKeyAnimation;
    MultiView: TMultiView;
    lstBox_Menu: TListBox;
    menu_BoatTitle: TListBoxGroupHeader;
    menu_BoatRental: TListBoxItem;
    menu_BoatMap: TListBoxItem;
    menu_AdminTitle: TListBoxGroupHeader;
    menu_AdminUsers: TListBoxItem;
    menu_AdminBoats: TListBoxItem;
    menu_AdminConfig: TListBoxItem;
    menu_Historical: TListBoxItem;
    rect_MenuFooter: TRectangle;
    btn_Logout: TSpeedButton;
    Circle1: TCircle;
    rect_MenuHeader: TRectangle;
    path_Logo: TPath;
    Bluetooth: TBluetooth;
    layout_Main: TLayout;
    procedure Button1Click(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lstBox_MenuItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure btn_MasterMenuClick(Sender: TObject);
    procedure MultiViewHidden(Sender: TObject);
    procedure btn_LogoutClick(Sender: TObject);
  private
    { Private declarations }
    FSync : TSyncStatus;
    procedure SetSync(const argValue: TSyncStatus);
    procedure InitSync;
  public
    { Public declarations }
    property Sync : TSyncStatus read FSync write SetSync;

    function  CreateEmbeddedFrame(argForm: TComponentClass): TFrame;
    procedure RemoveEmbeddedFrame;
  end;

var
  frm_Main: Tfrm_Main;
  frm_Active : TFrame = nil;

implementation

{$R *.fmx}

uses FMX.DialogService, unt_Printer, ufrm_Login, ufrm_Default, ufrm_Config,
  ufrm_Boats;


//******************************************************************************
// KEYBOARD ADJUST
//******************************************************************************

// shrink form to fit content when show keyboard
procedure Tfrm_Main.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  frm_Main.Padding.Bottom := Bounds.Height;
end;

procedure Tfrm_Main.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  frm_Main.Padding.Bottom := 0;
end;

//******************************************************************************
// EMBEDDED FRAME
//******************************************************************************

function Tfrm_Main.CreateEmbeddedFrame(argForm: TComponentClass): TFrame;
begin
  RemoveEmbeddedFrame();

  frm_Active        := TFrame(argForm.Create(frm_Main));
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

procedure Tfrm_Main.SetSync(const argValue: TSyncStatus);
begin
  FSync := argValue;
  case argValue of
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
  MultiView.Mode := TMultiViewMode.NavigationPane;
end;

procedure Tfrm_Main.MultiViewHidden(Sender: TObject);
begin
    lstBox_Menu.ItemIndex := -1;
end;

procedure Tfrm_Main.btn_LogoutClick(Sender: TObject);
begin
  MultiView.HideMaster;
  RemoveEmbeddedFrame;

  Login_Show;
end;

procedure Tfrm_Main.lstBox_MenuItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  // --- Embedded from
  // Use property TAG of the Items to define the form
  case Item.Tag of
//      1 : begin Tfrm_Rental(EmbeddFrame( Tfrm_Rental )).Prepare; end;
//
//     10 : begin Tfrm_Users (EmbeddFrame( Tfrm_Users  )).Prepare; end;
     11 : begin Tfrm_Boats (CreateEmbeddedFrame( Tfrm_Boats  )).Prepare; end;
     12 : begin Tfrm_Config(CreateEmbeddedFrame( Tfrm_Config )).Prepare; end;
//
//     15 : begin Tfrm_Historical(EmbeddFrame( Tfrm_Historical )).Prepare; end;
  else
    Tfrm_Default(CreateEmbeddedFrame( Tfrm_Default )).Prepare;
  end;

  MultiView.HideMaster;
end;

//******************************************************************************

procedure Tfrm_Main.FormCreate(Sender: TObject);
begin

  // Set the initial state, at the design enviroment it is better to keep it showing.
  MultiView.Visible := false;
  MultiView.Mode    := TMultiViewMode.Drawer;
  MultiView.HideMaster;
  lbl_Title.Text    := Caption;

  // Set the initial state, it is just to make sure.
  InitSync;

  // Create User object to store the user information
  // User := TUser.Create;

  PRINTER_BLUETOOTH := Bluetooth;
//  iniCFG := TIniFile.Create(GetPath('KleinAppConfig.ini'));
//  try
//    PRINTER_NAME   := iniCFG.ReadString('CLIENT', 'Printer'  , '');
//  finally
//    iniCFG.DisposeOf;
//  end;

  if BTConnectPrinter(PRINTER_NAME) then
    begin
      //BTSendData( EP_INITIALIZE_PRINTER );
    end;

  // Show default frame
  Tfrm_Default(CreateEmbeddedFrame( Tfrm_Default )).Prepare;
end;


procedure Tfrm_Main.FormDestroy(Sender: TObject);
begin
  RemoveEmbeddedFrame();
end;

//******************************************************************************



procedure Tfrm_Main.Button1Click(Sender: TObject);
begin
  Login_Show();
end;








end.
