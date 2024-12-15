unit unt_Printer;

interface

uses System.Classes, System.SysUtils, System.Bluetooth, System.Bluetooth.Components;

function BTGetDeviceByName( pDeviceName: String ): TBluetoothDevice;
function BTConnectPrinter(pDeviceName: String): boolean;
procedure BTDeviceList(pList: TStrings);
procedure BTSendData(pData: String);

const
  UUID_BTPrinter = '{00001101-0000-1000-8000-00805F9B34FB}';

// 3.1 Miscellaneous function commands --------------------------------------------------------------------------------------------------------------------------------
  EP_INITIALIZE_PRINTER               = #27#64;     // 3.1.1 ESC @
  EP_PRINT_RETURN_STANDARD_MODE       = #12;        // 3.1.2 FF
  EP_PRINT_LINE_FEED                  = #10;        // 3.1.3 LF      ; '\n'
  EP_LF                               = #10;        // 3.1.3 LF      ; '\n'
  EP_PRINT_PAPER_FEED_                = #27#74;     // 3.1.4 ESC J n ; 0 <= n <= 255 ; n x 0.125mm
  EP_PRINT_FEED_LINES_                = #27#100;    // 3.1.5 ESC d n ; 0 <= n <= 255
  EP_PRINT                            = #27#100#0;
  EP_PRINT_LF                         = #10#27#100#0;
  EP_HORIZONTAL_TAB                   = #9;         // 3.1.6 HT
  EP_TRANSMIT_PRINTER_STATUS          = #27#118;    // 3.1.7 ESC v
  EP_SELECT_HEAD_CONTROL_METHOD_      = #29#69;     // 3.1.8 GS E n  ; 0 <= n <= 255
  EP_REVERSE_FEED_                    = #27#75;     // 3.1.9 ESC K n ; 0 <= n <= 255 ; n x 0.125mm
// 3.2 CHARACTER COMMAND ----------------------------------------------------------------------------------------------------------------------------------------------
  EP_SELECT_PRINTER_MODE_             = #27#33;     // 3.2.1 ESC ! n // Ex: n = CHR(EP_MODE_EMPHASIZED or EP_MODE_DOUBLE_WIDTH)
    EP_MODE_STANDARD                  =       $00;
    EP_MODE_EMPHASIZED                =       $08;
    EP_MODE_DOUBLE_HEIGHT             =       $10;
    EP_MODE_DOUBLE_WIDTH              =       $20;
    EP_MODE_UNDERLINE                 =       $80;
  EP_SELECT_CHARACTER_SIZE_           = #29#33;     // 3.2.2 GS ! n ; 0 <= n <= 8
  EP_SELECT_FONT_WESTERN_CHAR_12x24   = #27#77#0;   // 3.2.3 ESC M n
  EP_SELECT_FONT_WESTERN_CHAR_8x16    = #27#77#1;
  EP_SELECT_FONT_SIMP_CHINESE_24x24   = #27#77#16;
  EP_SELECT_FONT_SIMP_CHINESE_16x16   = #27#77#17;
  EP_SELECT_FONT_BIG5_CHINESE_24x24   = #27#77#18;
  EP_SELECT_FONT_BIG5_CHINESE_16x16   = #27#77#19;
  EP_UNDERLINE_OFF                    = #27#45#0;   // 3.2.4 ESC – n                                // Turn underline mode on or off
  EP_UNDERLINE_ONE_DOT                = #27#45#1;
  EP_UNDERLINE_TWO_DOT                = #27#45#2;
                                                    // 3.2.5 ESC E n                                // Turn emphasized mode on / off
                                                    // 3.2.6 ESC G n                                // Turn double-strike mode on/off
                                                    // 3.2.7 GS B n                                 // Turn white/black reverse printing mode on/off
                                                    // 3.2.8 ESC R n                                // Select an international character set
                                                    // 3.2.9 ESC t n                                // Select character code table
// 3.3 PRINT POSITION COMMAND -----------------------------------------------------------------------------------------------------------------------------------------
                                                    // 3.3.1 ESC $ nL nH                            // Set absolute print position
                                                    // 3.3.2 ESC D n1 n2…nk NULL                    // Set horizontal tab positions
                                                    // 3.3.3 ESC 2                                  // Select default line spacing
                                                    // 3.3.4 ESC 3 n                                // Set line spacing
                                                    // 3.3.5 ESC SP n                               // Set character spacing
  EP_SELECT_JUSTIFICATION_LEFT        = #27#97#0;   // 3.3.6 ESC a n
  EP_SELECT_JUSTIFICATION_CENTER      = #27#97#1;
  EP_SELECT_JUSTIFICATION_RIGHT       = #27#97#2;
                                                    // 3.3.7 GS L nL nH                             // Set left margin
                                                    // 3.3.8 GS W                                   // Set print area width
// 3.4 Bit-Image commands ---------------------------------------------------------------------------------------------------------------------------------------------
                                                    // 3.4.1 ESC * m nL nH d1…dk                    // Select bit-image mode
                                                    // 3.4.2 GS * x y d1…dk                         // Define downloaded bit image
                                                    // 3.4.3 GS / n                                 // Print a downloaded bit image
                                                    // 3.4.4 FS p n                                                   // Print bit image in NV memory
                                                    // 3.4.5 FS q n [xL xH yL yH d1...dk]1...[xL xH yL yH d1...dk]n   // Define NV bit image
                                                    // 3.4.6 GS v 0 m xL xH yL Yh d1....dk                            // Print raster bit image
// 3.5 Bar code commands ----------------------------------------------------------------------------------------------------------------------------------------------
                                                    // 3.5.1 GS h n ; 1 = n = 40 ; 36(DEFAULT)      // Set bar code height
                                                    // 3.5.2 GS w n ; 1 = n = 4  ; 2 (DEFAULT)      // Set bar code width
                                                    // 3.5.3 GS H n ; 0 = n = 2  ; 0 (DEFAULT)      // Select printing position of HRI characters
                                                    // 3.5.4 GS f n ; n = 0, 1   ; 0 (DEFAULT)      // Select font for Human Readable Interpretation (HRI) characters
                                                    // 3.5.5 GS k                                   // Print bar code
                                                    // 3.5.6 GS k m v r d1……dk [NULL]               // Print QRCODE
                                                    // 3.5.7GS ( k <Function 167>                   // QR Code: Set the size of module
                                                    // 3.5.8GS ( k <Function 169>                   // QR Code: Select the error correction level
                                                    // 3.5.9GS ( k <Function 180>                   // QR Code: Store the dat a in the symbol storage area
                                                    // 3.5.10 GS ( k <Function 181>                 // QR Code: Pr int the symbol data in the symbol storage area
// 3.6 Curve print commands -------------------------------------------------------------------------------------------------------------------------------------------
                                                    // 3.6.1 GS ‘                                   // Print line section on a horizontal

// 3.7 User-defined character commands --------------------------------------------------------------------------------------------------------------------------------
                                                    // 3.7.1 ESC % n                                                     // Select /cancel user-defined character set
                                                    // 3.7.2 ESC & y c1 c2 [x1 d1...d(y * x1)]...[xk d1...d(y * xk)]     // Define user-defined characters
                                                    // 3.7.3 ESC ?                                                       // Cancel user-defined characters
// 3.8 Kanji character commands --------------------------------------------------------------------------------------------------------------------------------
                                                    // 3.8.1 FS &                                                        // Select Chinese character mode
                                                    // 3.8.2 FS 2 c1 c2 d1…dk                                            // Define user-defined Kanji characters
                                                    // 3.8.3 FS .                                                        // Canceling chinese mode
var
  PRINTER_SOCKET    : TBluetoothSocket;
  PRINTER_BLUETOOTH : TBluetooth = nil;
  PRINTER_CONNECTED : Boolean = False;
  PRINTER_NAME      : String = '';


implementation

function BTGetDeviceByName( pDeviceName: String ): TBluetoothDevice;
var
  lDevice: TBluetoothDevice;
begin
  Result := nil;
  if not Assigned(PRINTER_BLUETOOTH) then Exit;

  for lDevice in PRINTER_BLUETOOTH.PairedDevices do
  begin
    if lDevice.DeviceName = pDeviceName then
    begin
      Result := lDevice;
    end;
  end;
end;

function BTConnectPrinter(pDeviceName: String): boolean;
var
  lDevice: TBluetoothDevice;
begin
  Result := False;
  try
    lDevice := BTGetDeviceByName(pDeviceName);
    if lDevice <> nil then
    begin
      PRINTER_SOCKET := lDevice.CreateClientSocket(StringToGUID(UUID_BTPrinter), False);
      if PRINTER_SOCKET <> nil then
      begin
        PRINTER_SOCKET.Connect;
        Result := PRINTER_SOCKET.Connected
      end;
    end;
  except

  end;
  PRINTER_CONNECTED := Result;
end;

procedure BTDeviceList(pList: TStrings);
var
  lDevice: TBluetoothDevice;
begin
  pList.Clear;
  if not Assigned(PRINTER_BLUETOOTH) then Exit;
  for lDevice in PRINTER_BLUETOOTH.PairedDevices do
  begin
    pList.Add(lDevice.DeviceName);
  end;
end;

procedure BTSendData(pData: String);
begin
  if (PRINTER_SOCKET <> nil) and (PRINTER_SOCKET.Connected) then
    PRINTER_SOCKET.SendData(TEncoding.UTF8.GetBytes(pData));
end;

end.
