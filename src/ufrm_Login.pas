unit ufrm_Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.Controls.Presentation,
  FMX.Layouts, FMX.TabControl, FMX.Objects, FMX.Gestures, System.Actions,
  FMX.ActnList;

type
  Tfrm_Login = class(TFrame)
    ActionList: TActionList;
    actNextTab_Login: TNextTabAction;
    actPrevTab_Login: TPreviousTabAction;
    GestureManager: TGestureManager;
    rect_Background: TRectangle;
    tabCtrl_Login: TTabControl;
    tabItem_Login: TTabItem;
    layout_Login: TFlowLayout;
    rct_Logo: TRectangle;
    layout_FormLogin: TLayout;
    lbl_Username: TLabel;
    lbl_Password: TLabel;
    btn_Login: TButton;
    edt_Username: TEdit;
    edt_Password: TEdit;
    tabItem_DeviceInfo: TTabItem;
    label_DeviceInfo: TLabel;
    mmo_Information: TMemo;
    procedure FrameResize(Sender: TObject);
    procedure FrameGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure btn_LoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 TUser = class
    public
    ID       : String;
    Name     : String;
    Level    : String;
    ResetPwd : Boolean;
    Online   : Boolean;
    Logged   : Boolean;
    constructor Create;
    procedure Clear;
  end;

const
  frm_Login_msg_UsernameEmpty              = 'Campo usuário vazio.';                // 'Username is empty.';
  frm_Login_msg_InvalidUsernamePassword    = 'Usuário ou Senha inválido(s)';        // 'Invalid Username or Password'
  frm_Login_msg_AccessDenied               = 'Acesso Negado';                       // 'Access denied'
  frm_Login_msg_ConnectionFailed           = 'Falha na conexão com o servidor';     // 'Connection failed.';
  frm_Login_msg_VersionRequired            = 'Versão requerida: %s';                // Version required: %s
  frm_Login_msg_InternalError              = 'Erro interno no servidor';            // Internal Server Error
  frm_Login_cmd_OK                         = 'OK';
  frm_Login_cmd_OK_Offline                 = 'OK-Offline';
  frm_Login_msg_Offline_Confirmation       = 'Confirmar Acesso com modo offline?';         // Confirm Offline Login?
  frm_Login_dlg_ServerConfigTitle          = 'Servidor';


var
  frm_Login : Tfrm_Login = nil;
  User : TUser;

procedure Login_Show;
procedure Login_Hide;


implementation

{$R *.fmx}

uses unt_DeviceUtils, ufrm_Main, ufrm_Message;

procedure Login_Show;
begin
  // Just to make sure that the to clean the connection if we forgot the connection opened in Design enviroment.
//  dm_Server.CloseSession;
//  dm_Server.DSRestConnection.UserName  := '';
//  dm_Server.DSRestConnection.Password  := '';
  // If there is no form, create it.
  if not Assigned(frm_Login) then
    begin
      frm_Login := Tfrm_Login.Create(frm_Main);
      with frm_Login do
        begin
          Parent := frm_Main;

          // Retrieve the Local App & Device information, and expose it
          mmo_Information.Lines.Clear;
          mmo_Information.Lines.Add( 'App Version: '          + getAppVersion()                   );
          mmo_Information.Lines.Add( 'Device Platform: '      + getDeviceInfoPlatform2()          );
          mmo_Information.Lines.Add( 'Device Manufacturer: '  + getDeviceInfoDeviceManufacturer() );
          mmo_Information.Lines.Add( 'Device Model: '         + getDeviceInfoDeviceModel()        );
          mmo_Information.Lines.Add( 'Device UID: '           + getDeviceInfoDeviceUID()          );
          mmo_Information.Lines.Add( 'OS Name: '              + getDeviceInfoOSName2()            );
          mmo_Information.Lines.Add( 'OS Version: '           + getDeviceInfoOSVersion2()         );
          mmo_Information.Lines.Add( 'OS Lang: '              + getDeviceInfoOSLang()             );
          mmo_Information.Lines.Add( 'Screen Scale: '         + getDeviceScreenScale().ToString   );
        end;
    end;
end;

procedure Login_Hide;
begin
  // Hide & Destroy the form
  if Assigned(frm_Login) then
    begin
      frm_Login.Free;
      frm_Login := nil;
    end;
end;


{ TUser }

procedure TUser.Clear;
begin

end;

constructor TUser.Create;
begin

end;

procedure Tfrm_Login.btn_LoginClick(Sender: TObject);
begin
  if edt_Username.Text = 'root' then
    begin
      Login_Hide;
    end
  else
    begin
      ShowAlert('Invalid Username/Password');
    end;

end;

procedure Tfrm_Login.FrameGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  Handled := True;

  if EventInfo.GestureID = sgiLeft         then actNextTab_Login.Execute;           // If Gesture is to Left go to the next tab
  if EventInfo.GestureID = sgiRight        then actPrevTab_Login.Execute;           // If Gesture is to Right go to the previous tab
end;

procedure Tfrm_Login.FrameResize(Sender: TObject);
var
  i : Single;
begin
//   --- Change the Login layout depends on device orientation (Logo/Form)
  if (Width > Height) then                                                          // If it is portrait
    begin
      if (layout_Login.Width < layout_Login.Height) then                            // Resize to move form below to logo
        begin
          i := layout_Login.Width;
          layout_Login.Width := layout_Login.Height;
          layout_Login.Height := i;
        end;
    end
  else                                                                              // If it is Landscape
    begin
      if (layout_Login.Height < layout_Login.Width) then                            // Resize to move form next to logo
        begin
          i := layout_Login.Width;
          layout_Login.Width := layout_Login.Height;
          layout_Login.Height := i;
        end;
    end;



  // is it big enough to show logo?
  rct_Logo.Visible := (Width > layout_Login.Width) and (Height > layout_Login.Height);

end;

end.
