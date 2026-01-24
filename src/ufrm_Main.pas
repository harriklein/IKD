unit ufrm_Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.Objects, FMX.ListBox,
  FMX.Layouts, FMX.MultiView, System.ImageList, FMX.ImgList, FMX.Effects,
  System.Bluetooth, System.Bluetooth.Components, System.IniFiles,  FMX.VirtualKeyboard, FMX.Platform, System.Hash,    System.NetEncoding,  System.JSON, System.DateUtils,
{$IFDEF ANDROID}
    FMX.Helpers.Android,                 Androidapi.JNI.GraphicsContentViewText, AndroidApi.Helpers,
    Androidapi.JNI.Telephony, Androidapi.JNI.Provider, Androidapi.JNIBridge,
    Androidapi.JNI.JavaTypes, Androidapi.JNI.OS, Androidapi.JNI.App,
{$ENDIF}
   System.Permissions;


const
  UNEXPECTED_ERROR = 'Ocorreu um erro inesperado, favor informar ao administrador.\nReferencia: ';

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
    btn_MenuConfigPrint: TSpeedButton;
    btn_MenuBoats: TSpeedButton;
    btn_MenuReport: TSpeedButton;
    lbl_version: TLabel;
    btn_Logout: TSpeedButton;
    path_MenuBoats: TPath;
    path_MenuRental: TPath;
    path_MenuUsers: TPath;
    path_MenuConfigPrint: TPath;
    path_MenuReport: TPath;
    path_Logout: TPath;
    rect_Menu: TRectangle;
    btn_MenuPoS: TSpeedButton;
    path_MenuPoS: TPath;
    btn_MenuConfig: TSpeedButton;
    path_MenuConfig: TPath;
    Label1: TLabel;
    Label2: TLabel;
    Layout1: TLayout;
    Label3: TLabel;
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_MasterMenuClick(Sender: TObject);
    procedure btn_MenuClick(Sender: TObject);
    procedure rect_MenuClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: WideChar;
      Shift: TShiftState);

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

procedure DecodeToken(AToken: String;  var AAdmPwd, APoSPwd: String; var ATokenValid: Boolean; var ATokenEXP, ATokenIAT: TDateTime);


var
  frm_Main: Tfrm_Main;
  frm_Active : TFrame = nil;
  PoSAdmin  : Boolean;
  PoSID     : TGUID;
  PoSName   : String;
  CLOCK_IN_SECONDS  : Boolean = False;
  EXP     : TDate;
  ADM_PWD : String = '';
  POS_PWD : String = '';
  TOKEN_VALID_SIGNATURE  : Boolean;
  TOKEN_EXP              : TDateTime;
  TOKEN_IAT              : TDateTime;

implementation

{$R *.fmx}

uses FMX.DialogService, unt_Printer, ufrm_Login, ufrm_Default, ufrm_ConfigPrint, unt_DeviceUtils,
  ufrm_Boats, ufrm_Rental, ufrm_Report, ufrm_PoS, ufrm_Config;


//******************************************************************************
// KEYBOARD ADJUST
//******************************************************************************

// shrink form to fit content when show keyboard
procedure Tfrm_Main.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  frm_Main.Padding.Bottom := Bounds.Height;

  if frm_Active is Tfrm_Rental then Tfrm_Rental(frm_Active).FormVirtualKeyboardShown(Sender, KeyboardVisible, Bounds);
  if frm_Active is Tfrm_Boats  then Tfrm_Boats (frm_Active).FormVirtualKeyboardShown(Sender, KeyboardVisible, Bounds);
end;

procedure Tfrm_Main.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  frm_Main.Padding.Bottom := 0;
end;

procedure Tfrm_Main.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
{$IFDEF ANDROID}
var
  LVKService : IFMXVirtualKeyboardService;
{$ENDIF}
begin
  if Key = vkHardwareBack then
    begin
      {$IFDEF ANDROID}
      if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(LVKService)) then
        begin
          if Assigned(LVKService) and (TVirtualKeyboardState.Visible in LVKService.VirtualKeyboardState) then
            Exit;
        end;
      {$ENDIF}

      // Key := 0;
      // TDialogService.ShowMessage('HardwareBack');

      if frm_Active is Tfrm_Default  then with Tfrm_Default(frm_Active) do
        begin
          Key := 0;
          TDialogService.MessageDialog( 'Deseja sair da aplicação '#$D#$A'Pedalinhos Klein?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                        procedure(const AResult: TModalResult)
                                          begin
                                            if AResult = mrYes then
                                              begin
                                                Close;
                                              end
                                          end);
          Exit;
        end;

      if frm_Active is Tfrm_Rental then with Tfrm_Rental(frm_Active) do
        begin
               if tabCtrl_List.ActiveTab = tabItem_List then
            begin
              Key := 0;
              Tfrm_Default(CreateEmbeddedFrame( Tfrm_Default )).Prepare;
            end
          else if tabCtrl_List.ActiveTab = tabItem_Config then
            begin
              Key := 0;
              btn_ConfigBack.OnClick(btn_ConfigBack);
            end
          else if tabCtrl_List.ActiveTab = tabItem_Start then
            begin
              Key := 0;
              btn_StartBack.OnClick(btn_StartBack);
            end
          else if tabCtrl_List.ActiveTab = tabitem_End then
            begin
              Key := 0;
              btn_EndBack.OnClick(btn_EndBack);
            end
          else if tabCtrl_List.ActiveTab = tabitem_EndPay then
            begin
              Key := 0;
              btn_EndPayBack.OnClick(btn_EndPayBack);
            end
          else if tabCtrl_List.ActiveTab = tabitem_PoS then
            begin
              Key := 0;
              btn_PoSBack.OnClick(btn_PoSBack);
            end
          else if tabCtrl_List.ActiveTab = tabItem_Receipt then
            begin
              Key := 0;
              btn_ReceiptBack.OnClick(btn_ReceiptBack);
            end;
          Exit;
        end;

      if frm_Active is Tfrm_Boats  then with Tfrm_Boats(frm_Active) do
        begin
               if tabCtrl_List.ActiveTab = tabItem_List then
            begin
              Key := 0;
              Tfrm_Default(CreateEmbeddedFrame( Tfrm_Default )).Prepare;
            end
          else if tabCtrl_List.ActiveTab = tabItem_Detail then
            begin
              Key := 0;
              btn_Cancel.OnClick(btn_Cancel);
            end;
          Exit;
        end;

      if frm_Active is Tfrm_ConfigPrint  then with Tfrm_ConfigPrint(frm_Active) do
        begin
          Key := 0;
          Tfrm_Default(CreateEmbeddedFrame( Tfrm_Default )).Prepare;
          Exit;
        end;

    end;
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

function Base64UrlEncode(const ABytes: TBytes): string;
begin
  Result := TNetEncoding.Base64.EncodeBytesToString(ABytes);
  Result := Result.Replace('+', '-')
                   .Replace('/', '_')
                   .Replace('=', '')
                   .Replace(#$A, '')
                   .Replace(#$D, '');
end;

function Base64UrlDecode(const AValue: string): TBytes;
var
  S: string;
begin
  S := AValue.Replace('-', '+').Replace('_', '/');

  case Length(S) mod 4 of
    2: S := S + '==';
    3: S := S + '=';
  end;

  Result := TNetEncoding.Base64.DecodeStringToBytes(S);
end;

function EpochToDateTime(const Epoch: Int64): TDateTime;
begin
  Result := UnixToDateTime(Epoch, True); // True = UTC
end;

procedure DecodeToken(AToken: String; var AAdmPwd, APoSPwd: String; var ATokenValid: Boolean; var ATokenEXP, ATokenIAT: TDateTime);
var
  Parts: TArray<string>;
  SigningInput, ExpectedSig, TokenSig: string;
  Hash: TBytes;

  LPayloadBytes : TBytes;
  LPayloadJson  : String;
  LJsonObj: TJSONObject;

  LValue  : String;
  LDateTime : TDateTime;
begin
  AAdmPwd := 'none';
  APoSPwd := 'none';
  ATokenValid  := False;
  ATokenEXP    := 0;
  ATokenIAT    := UnixToDateTime(64060588800, False);;


  Parts := AToken.Split(['.']);
  if Length(Parts) <> 3 then Exit;

  SigningInput := Parts[0] + '.' + Parts[1];
  TokenSig := Parts[2];

  Hash := THashSHA2.GetHMACAsBytes(
    SigningInput,
    'Irmaos' + 'Klein' + 'Divertimentos' + '@' + '04121967',
    SHA512
  );

  ExpectedSig := Base64UrlEncode(Hash);

  ATokenValid := ExpectedSig = TokenSig;

  if not ATokenValid then Exit;

  // -----------------------------------------

  LPayloadBytes := Base64UrlDecode(Parts[1]);
  LPayloadJson  := TEncoding.UTF8.GetString(LPayloadBytes);

  LJsonObj := TJSONObject.ParseJSONValue(LPayloadJson) as TJSONObject;
  try
    if LJsonObj.TryGetValue<string>('admPwd', LValue) then AAdmPwd   := LValue;
    if LJsonObj.TryGetValue<string>('posPwd', LValue) then APoSPwd   := LValue;
    if LJsonObj.TryGetValue<string>('exp'   , LValue) then ATokenEXP := UnixToDateTime(StrToInt64Def(LValue, 0), False);
    if LJsonObj.TryGetValue<string>('iat'   , LValue) then ATokenIAT := UnixToDateTime(StrToInt64Def(LValue, 64060588800), False);
  finally
    LJsonObj.Free;
  end;


end;

procedure Tfrm_Main.RemoveEmbeddedFrame;
begin
  if Assigned(frm_Active) then
    begin
//      if frm_Active is Tfrm_Boats then Tfrm_Boats(frm_Active).Release;

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
  // Use property TAG of the Items to define the form  s
  case TSpeedButton(Sender).Tag of
      1 : begin Tfrm_Rental(CreateEmbeddedFrame( Tfrm_Rental )).Prepare; end;
//
//     10 : begin Tfrm_Users (EmbeddFrame( Tfrm_Users  )).Prepare; end;
     11 : begin Tfrm_Boats (CreateEmbeddedFrame( Tfrm_Boats  )).Prepare; end;
     12 : begin Tfrm_PoS   (CreateEmbeddedFrame( Tfrm_PoS    )).Prepare; end;
     13 : begin Tfrm_ConfigPrint(CreateEmbeddedFrame( Tfrm_ConfigPrint )).Prepare; end;
     14 : begin Tfrm_Report(CreateEmbeddedFrame( Tfrm_Report )).Prepare; end;
     15 : begin Tfrm_Config(CreateEmbeddedFrame( Tfrm_Config )).Prepare; end;

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
  LToken : String;
begin

// PermissionsService.RequestPermissions([JStringToString(TJManifest_permission.JavaClass.BLUETOOTH),
//                                  JStringToString(TJManifest_permission.JavaClass.BLUETOOTH_SCAN),
//                                  JStringToString(TJManifest_permission.JavaClass.BLUETOOTH_CONNECT),
//                                  JStringToString(TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION)],
//
//                                     nil
//  );

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
    PRINTER_NAME      := LIniConfig.ReadString('CLIENT', 'Printer'      , ''  );
    PRINTER_ENABLE    := LIniConfig.ReadBool  ('CLIENT', 'PrinterEnable', True);
    CLOCK_IN_SECONDS  := LIniConfig.ReadBool  ('CLIENT', 'ClockSeconds' , false);
    LToken            := LIniConfig.ReadString('CLIENT', 'ActivationCode', '' );
  finally
    LIniConfig.Free;
  end;

  DecodeToken(LToken, ADM_PWD, POS_PWD, TOKEN_VALID_SIGNATURE, TOKEN_EXP, TOKEN_IAT);

  if BTConnectPrinter(PRINTER_NAME) then
    begin
      BTSendData( EP_INITIALIZE_PRINTER );
    end;

  // Show default frame
  // Tfrm_Default(CreateEmbeddedFrame( Tfrm_Default )).Prepare;
  Login_Show;
end;


procedure Tfrm_Main.FormDestroy(Sender: TObject);
begin
  RemoveEmbeddedFrame();

  Login_Hide;
end;



//******************************************************************************



end.
