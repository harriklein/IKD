unit ufrm_ConfigPrint;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Controls.Presentation, FMX.Layouts, System.IniFiles,

{$IFDEF ANDROID}
//    FMX.Helpers.Android,  FMX.DialogService,
//    Androidapi.JNI.GraphicsContentViewText, AndroidApi.Helpers,
//    Androidapi.JNI.Telephony, Androidapi.JNI.Provider, Androidapi.JNIBridge,
//    Androidapi.JNI.JavaTypes, Androidapi.JNI.OS, Androidapi.JNI.App,
{$ENDIF}

  System.Permissions;

type
  Tfrm_ConfigPrint = class(TFrame)
    vScroll_RentStart: TVertScrollBox;
    layout_RentStart: TFlowLayout;
    layout_RentStart1: TLayout;
    lbl_Printers: TLabel;
    btn_Save: TButton;
    cbBox_Printers: TComboBox;
    btn_Test: TButton;
    switch_PrinterEnable: TSwitch;
    Label1: TLabel;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private const
    LOCATION_PERMISSION = 'android.permission.ACCESS_FINE_LOCATION';
    BLUETOOTH_SCAN_PERMISSION = 'android.permission.BLUETOOTH_SCAN';
    BLUETOOTH_CONNECT_PERMISSION = 'android.permission.BLUETOOTH_CONNECT';
  private
    { Private declarations }
  public
    { Public declarations }
    procedure prepare();
    procedure PrintReceipt();
  end;

implementation

{$R *.fmx}

uses unt_Printer, unt_DeviceUtils, ufrm_Main, udm_Main;

{ Tfrm_Config }

procedure Tfrm_ConfigPrint.prepare;
begin
  BTDeviceList( cbBox_Printers.Items );

  cbBox_Printers.ItemIndex       := cbBox_Printers.Items.IndexOf( PRINTER_NAME );
  switch_PrinterEnable.IsChecked := PRINTER_ENABLE;
end;

procedure Tfrm_ConfigPrint.btn_SaveClick(Sender: TObject);
var
  LIniConfig : TiniFile;
begin
  if (cbBox_Printers.Selected <> nil) and (cbBox_Printers.Selected.Text <> '') then
    begin
      PRINTER_NAME := cbBox_Printers.Selected.Text;
      PRINTER_ENABLE := switch_PrinterEnable.IsChecked;
      LIniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
      try
        LIniConfig.WriteString('CLIENT', 'Printer'        , PRINTER_NAME  );
        LIniConfig.WriteBool  ('CLIENT', 'PrinterEnable'  , PRINTER_ENABLE);
      finally
        LIniConfig.Free;
      end;
      if BTConnectPrinter(cbBox_Printers.Selected.Text) then
        begin
          ShowMessage('Dispositivo conectado corretamente: ' + PRINTER_NAME);
        end
      else
        begin
          ShowMessage('Não é possivel conectar com o dispositivo selecionado.');
        end;
    end
    else
    begin
      ShowMessage('Selecione um dispositivo.');
    end;
end;

//******************************************************************************

procedure Tfrm_ConfigPrint.btn_TestClick(Sender: TObject);
begin
  PrintReceipt();
end;

procedure Tfrm_ConfigPrint.Button1Click(Sender: TObject);
var
  Permissions: TArray<string>;
begin

  if TOSVersion.Check(12) then
    Permissions := [LOCATION_PERMISSION, BLUETOOTH_SCAN_PERMISSION, BLUETOOTH_CONNECT_PERMISSION]
  else
    Permissions := [LOCATION_PERMISSION];

  PermissionsService.RequestPermissions(Permissions,
    procedure(const Permissions: TClassicStringDynArray; const GrantResults: TClassicPermissionStatusDynArray)
    begin
      if ((Length(GrantResults) = 3) and (GrantResults[0] = TPermissionStatus.Granted)
                                     and (GrantResults[1] = TPermissionStatus.Granted)
                                     and (GrantResults[2] = TPermissionStatus.Granted)) or
         ((Length(GrantResults) = 1) and (GrantResults[0] = TPermissionStatus.Granted)) then
      begin
            frm_Main.Bluetooth.Enabled := True;
      end;
    end);


end;

procedure Tfrm_ConfigPrint.PrintReceipt;
var
  LSeq, LPoS, LObs, LDate, LValue, LMin : String;
begin
//LSeq   := '00' + '     ' + '1';
  LSeq   := '  ' + '     ' + '1';
  LPoS   := 'Ponto : '     + 'Teste' + ' (' + FormatDateTime( 'yyMMdd', Now ) + ')';
  LDate  := 'Data  : '     + FormatDateTime( 'dd/MM/yyyy HH:mm', Now );
  LValue := 'Valor : R$ '  +       IntToStr( 99         ) + ',00';
  LMin   := 'Tempo : '     +       IntToStr( 35         ) + ' min';
  LObs   := 'R$ 10,00 a cada 10 min excedente';

  BTSendData( EP_INITIALIZE_PRINTER           );
  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH ));
  BTSendData( 'PEDALINHOS KLEIN'      + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));
  BTSendData( 'RECIBO' + EP_LF + EP_LF );
//BTSendData( '   Senha     Pedalinho/Boat' + EP_PRINT );
  BTSendData( '             Pedalinho/Boat' + EP_PRINT );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH OR EP_MODE_DOUBLE_HEIGHT OR EP_MODE_EMPHASIZED ));
//BTSendData( '01     G01' + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT  );
  BTSendData( LSeq + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT  );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));
  BTSendData( EP_SELECT_JUSTIFICATION_LEFT  );

  BTSendData( EP_LF );
//BTSendData( 'Data  : 01/01/2019 13:00' + EP_PRINT );
//BTSendData( 'Valor : R$ 30,00'         + EP_PRINT );
//BTSendData( 'Tempo : 30 min'           + EP_PRINT );
  BTSendData( LPoS   + EP_PRINT );
  BTSendData( LDate  + EP_PRINT );
  BTSendData( LValue + EP_PRINT );
  BTSendData( LMin   + EP_PRINT );
  BTSendData( EP_LF );

  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );
//BTSendData( 'R$ 10,00 a cada 10 min excedente' + EP_PRINT );
  BTSendData( LObs + EP_PRINT );

  BTSendData(  EP_LF + EP_LF + EP_LF + EP_LF + EP_LF + EP_PRINT );
end;


end.
