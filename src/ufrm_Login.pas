unit ufrm_Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.Controls.Presentation,
  FMX.Layouts, FMX.TabControl, FMX.Objects, FMX.Gestures, System.Actions, System.IniFiles,
  FMX.ActnList, FMX.ListBox, FMX.Media, FMX.DialogService, System.Hash;

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
    lbl_PoS: TLabel;
    lbl_Password: TLabel;
    btn_Login: TButton;
    edt_Password: TEdit;
    tabItem_DeviceInfo: TTabItem;
    label_DeviceInfo: TLabel;
    mmo_Information: TMemo;
    cb_PoS: TComboBox;
    CameraComponent1: TCameraComponent;
    btn_License: TButton;
    procedure FrameResize(Sender: TObject);
    procedure FrameGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure btn_LoginClick(Sender: TObject);
    procedure btn_LicenseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PoSClear;
    destructor Destroy; override;
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

uses unt_DeviceUtils, ufrm_Main, ufrm_Message, udm_Main, ufrm_Rental, unt_Class,
  ufrm_PoS;

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
          tabCtrl_Login.TabIndex := 0;
          Parent := frm_Main;

          // Retrieve the Local App & Device information, and expose it
          mmo_Information.Lines.Clear;
          if TOKEN_VALID_SIGNATURE then
            begin
              mmo_Information.Lines.Add( 'Licença  : Ativada' );
              mmo_Information.Lines.Add( 'Inicia em: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', TOKEN_IAT));
              mmo_Information.Lines.Add( 'Expiração: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', TOKEN_EXP));
            end
          else
            begin
              mmo_Information.Lines.Add( 'Licença  : Desativada' );
              mmo_Information.Lines.Add( 'Inicia em: N/A');
              mmo_Information.Lines.Add( 'Expiração: N/A');
            end;

          mmo_Information.Lines.Add( 'App Version: '          + getAppVersion()                   );
          mmo_Information.Lines.Add( 'Device Platform: '      + getDeviceInfoPlatform2()          );
          mmo_Information.Lines.Add( 'Device Manufacturer: '  + getDeviceInfoDeviceManufacturer() );
          mmo_Information.Lines.Add( 'Device Model: '         + getDeviceInfoDeviceModel()        );
          mmo_Information.Lines.Add( 'Device UID: '           + getDeviceInfoDeviceUID()          );
          mmo_Information.Lines.Add( 'OS Name: '              + getDeviceInfoOSName2()            );
          mmo_Information.Lines.Add( 'OS Version: '           + getDeviceInfoOSVersion2()         );
          mmo_Information.Lines.Add( 'OS Lang: '              + getDeviceInfoOSLang()             );
          mmo_Information.Lines.Add( 'Screen Scale: '         + getDeviceScreenScale().ToString   );

          // PoS ---------------------------
          PoSClear;
          cb_PoS.Items.AddObject('Administração', TComboBoxItemGuid.Create(cb_PoS, POS_NONE) );
          dm_Main.tb_PoS.First;
          while not dm_Main.tb_PoS.Eof do
            begin
              cb_PoS.Items.AddObject(dm_Main.tb_PoS.FieldByName('Name').AsString, TComboBoxItemGuid.Create(cb_PoS, dm_Main.tb_PoS.FieldByName('id').AsGuid));
              dm_Main.tb_PoS.Next;
            end;
          // ---------------------------------
        end;
    end;
end;

procedure Login_Hide;
begin
//  frm_Main.lbl_MenuAdministration.Visible := PoSAdmin;
//  frm_Main.btn_MenuBoats.Visible          := PoSAdmin;
//  frm_Main.btn_MenuPoS.Visible            := PoSAdmin;
  frm_Main.btn_MenuConfig.Visible         := PoSAdmin;
  frm_Main.btn_MenuReport.Visible         := False;


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

procedure Tfrm_Login.btn_LicenseClick(Sender: TObject);
begin
 TDialogService.InputQuery('Licença', [''], [''],
    procedure(const AResult: TModalResult; const AValues: array of string)
    var
      LCode, LAdmPwd, LPoSPwd : String;
      LTokenValid: Boolean;
      LTokenEXP, LTokenIAT : TDateTime;
      LIniConfig : TiniFile;

    begin
      if AResult = mrOK then
        begin
          LCode := AValues[0];
          DecodeToken(LCode, LAdmPwd, LPoSPwd, LTokenValid, LTokenEXP, LTokenIAT);
          if not LTokenValid then
            begin
              TDialogService.ShowMessage('Código de Ativação inválido');
              Exit;
            end;

          if Now > LTokenEXP then
            begin
              TDialogService.ShowMessage('Código de Ativação expirado');
              Exit;
            end;

          LIniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
          try
            LIniConfig.WriteString  ('CLIENT', 'ActivationCode'  , LCode);
            TDialogService.ShowMessage('Código de Ativação salvo. Favor reinicie o app.');
          finally
            LIniConfig.Free;
          end;

        end;
    end);
end;

procedure Tfrm_Login.btn_LoginClick(Sender: TObject);
var
  LPwd : string;
begin
  if cb_PoS.ItemIndex < 0 then
    begin
      ShowAlert('Selecione um Ponto');
      Exit;
    end;

  if not TOKEN_VALID_SIGNATURE then
    begin
      ShowAlert('App não ativado');
      Exit;
    end;

  if Now > TOKEN_EXP then
    begin
      ShowAlert('Ativação expirada em ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', TOKEN_EXP));
      Exit;
    end;

  if Now <= TOKEN_IAT then
    begin
      ShowAlert('Ativação válida a partir de ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', TOKEN_IAT));
      Exit;
    end;


   LPwd := THashSHA2.GetHashString(edt_Password.Text, SHA512);

  if cb_PoS.ItemIndex = 0 then
    begin
      if LPwd = ADM_PWD then
        begin
          PoSID     := POS_NONE;
          PoSName   := 'Todos';
          PoSAdmin  := True;

          Tfrm_Rental(frm_Main.CreateEmbeddedFrame( Tfrm_Rental )).Prepare;

          Login_Hide;
        end
      else
        begin
          ShowAlert('Senha inválida');
        end;
    end
  else
    begin
      if LPwd = POS_PWD then
        begin
          PoSID     := TComboBoxItemGuid(cb_PoS.Items.Objects[cb_PoS.ItemIndex]).Value;
          PoSName   := cb_PoS.Items.Strings[cb_PoS.ItemIndex];
          PoSAdmin  := False;

          Tfrm_Rental(frm_Main.CreateEmbeddedFrame( Tfrm_Rental )).Prepare;

          Login_Hide;
        end
      else
        begin
          ShowAlert('Senha inválida');
        end;
    end;


//  if edt_Password.Text = '' then
//    begin
//      if cb_PoS.ItemIndex = 0 then
//        begin
//          PoSID     := POS_NONE;
//          PoSName   := 'Todos';
//          PoSAdmin  := True;
//        end
//      else
//        begin
//          PoSID     := TComboBoxItemGuid(cb_PoS.Items.Objects[cb_PoS.ItemIndex]).Value;
//          PoSName   := cb_PoS.Items.Strings[cb_PoS.ItemIndex];
//          PoSAdmin  := False;
//        end;
//
//
//      Tfrm_Rental(frm_Main.CreateEmbeddedFrame( Tfrm_Rental )).Prepare;
//
//      Login_Hide;
//    end
//  else
//    begin
//      ShowAlert('Senha inválida');
//    end;

end;

destructor Tfrm_Login.Destroy;
begin
  PoSClear;
  inherited Destroy;
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
  LTmp : Single;
begin
//   --- Change the Login layout depends on device orientation (Logo/Form)
  if (Width > Height) then                                                          // If it is portrait
    begin
      if (layout_Login.Width < layout_Login.Height) then                            // Resize to move form below to logo
        begin
          LTmp := layout_Login.Width;
          layout_Login.Width  := layout_Login.Height;
          layout_Login.Height := LTmp;
        end;
    end
  else                                                                              // If it is Landscape
    begin
      if (layout_Login.Height < layout_Login.Width) then                            // Resize to move form next to logo
        begin
          LTmp := layout_Login.Width;
          layout_Login.Width  := layout_Login.Height;
          layout_Login.Height := LTmp;
        end;
    end;



  // is it big enough to show logo?
  rct_Logo.Visible := (Width > layout_Login.Width) and (Height > layout_Login.Height);

end;

procedure Tfrm_Login.PoSClear;
var
  i : Integer;
begin
  // Release all object before clear
  for i := cb_PoS.Items.Count-1 downto 0 do
    begin
      if cb_PoS.Items.Objects[i] <> nil  then
        cb_PoS.Items.Objects[i].Free;
    end;
  cb_PoS.Clear;
end;

end.
