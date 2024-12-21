unit unt_DeviceUtils;

interface


function MD5(S: String): String;
function GetPath(filename: String = '') : String;
function GetDownloadPath(filename: String = '') : String;

function getDeviceInfoPlatform          : String;
function getDeviceInfoPlatform2         : String;
function getDeviceInfoDeviceManufacturer: String;
function getDeviceInfoDeviceModel       : String;
function getDeviceInfoDeviceUID         : String;
function getDeviceInfoOSName            : String;
function getDeviceInfoOSName2           : String;
function getDeviceInfoOSVersion         : String;
function getDeviceInfoOSVersion2        : String;
function getDeviceInfoOSLang            : String;
function getDeviceScreenScale           : Single;
function getAppVersion                  : String;
function getSettings_AutoTime           : Boolean;

implementation

uses
  FMX.Platform,
  System.IOUtils,
  IdHashMessageDigest,
  System.Permissions,
{$IFDEF MSWINDOWS}
    ActiveX,
    ComObj,
    Variants,
    Winapi.Windows,
{$ENDIF}
{$IFDEF ANDROID}
    FMX.Helpers.Android,  FMX.DialogService,
    Androidapi.JNI.GraphicsContentViewText, AndroidApi.Helpers,
    Androidapi.JNI.Telephony,Androidapi.JNI.Provider, Androidapi.JNIBridge,
    Androidapi.JNI.JavaTypes, Androidapi.JNI.OS, Androidapi.JNI.App,
{$ENDIF}
{$IFDEF OSX}
    MacApi.Helpers,
{$ELSE}
  {$IFDEF IOS}
    iOSApi.UIKit,
    iOSApi.Foundation,
    MacApi.Helpers,
  {$ENDIF}
{$ENDIF}

  System.SysUtils;


function MD5(S: String): String;
begin
  with TIdHashMessageDigest5.Create do
    begin
      Result := HashStringAsHex(S);
      DisposeOf;
    end;
end;

function GetPath(filename: String = ''): String;
begin
{$IF DEFINED(LINUX64) OR DEFINED(MSWINDOWS) }
  Result := ExtractFilePath(ParamStr(0));
{$ELSE}
  Result := TPath.GetDocumentsPath;
{$ENDIF}

  if not filename.IsEmpty then
    Result := TPath.Combine(Result, filename);
end;

function GetDownloadPath(filename: String = ''): String;
begin
{$IF DEFINED(LINUX64) OR DEFINED(MSWINDOWS) }
  Result := ExtractFilePath(ParamStr(0));
{$ELSE}
  Result := TPath.GetDownloadsPath;
{$ENDIF}

  if not filename.IsEmpty then
    Result := TPath.Combine(Result, filename);
end;

//------------------------------------------------------------------------------

{$IFDEF MSWINDOWS}
function GetBuildInfo(const AFileName: string; var AMajor, AMinor, ARelease, ABuild: WORD): Boolean;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := False;
  // GetFileVersionInfo modifies the filename parameter data while parsing.
  // Copy the string const into a local variable to create a writeable copy.
  if AFileName = '' then
    FileName := ParamStr(0)
  else
    FileName := AFileName;
  UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
        begin
          AMajor   := HiWord(FI.dwProductVersionMS);
          AMinor   := LoWord(FI.dwProductVersionMS);
          ARelease := HiWord(FI.dwProductVersionLS);
          ABuild   := LoWord(FI.dwProductVersionLS);
          Result:= True;
        end;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;

function getAppVersion: String;
var
  V1, V2, V3, V4: Word;
begin
  GetBuildInfo('', V1, V2, V3, V4);
  Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' +  IntToStr(V3);
end;
{$ENDIF}

{$IFDEF ANDROID}
function getAppVersion: String;
var
  PackageManager: JPackageManager;
  PackageInfo : JPackageInfo;
begin


  PackageManager := TAndroidHelper.Activity.getPackageManager;
  PackageInfo := PackageManager.getPackageInfo(TAndroidHelper.Context.getPackageName(), TJPackageManager.JavaClass.GET_ACTIVITIES);
  Result := JStringToString(PackageInfo.versionName);
end;
{$ENDIF}

//****************************
//          PLATFORM
//****************************

function getDeviceInfoPlatform2: String;
begin
  Result := '';
  case TOSVersion.Platform of
    pfWindows : Result := 'Windows';
    pfMacOS   : Result := 'MacOS';
    pfiOS     : Result := 'iOS';
    pfAndroid : Result := 'Android';
    pfWinRT   : Result := 'WinRT';
    pfLinux   : Result := 'Linux';
  end;
  Result := Result.ToUpper;
end;

{$IFDEF MSWINDOWS}
function getDeviceInfoPlatform: String;
begin
  result := 'WINDOWS';
end;
{$ENDIF}

{$IFDEF OSX}
function getDeviceInfoPlatform: String;
begin
  result := 'MACOS';
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoPlatform: String;
begin
  result := 'IOS';
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoPlatform: String;
begin
  result := 'ANDROID';
end;
{$ENDIF}

//****************************
//          DEVICE MANUFACTURER
//****************************

{$IFDEF MSWINDOWS}
function getDeviceInfoDeviceManufacturer: String;
var
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject   : OLEVariant;
  oEnum         : IEnumvariant;
  iValue        : LongWord;
begin
  try
    CoInitialize(nil);
    try
      FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      FWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      FWbemObjectSet:= FWMIService.ExecQuery('SELECT Manufacturer FROM Win32_ComputerSystem','WQL',$00000020);
      oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
      if oEnum.Next(1, FWbemObject, iValue) = 0 then
        Result := Format('%s',[String(FWbemObject.Manufacturer)]);
    finally
      CoUninitialize;
    end;
  except
  end;
  Result := Result.ToUpper;
end;
{$ENDIF}

{$IFDEF OSX}
function getDeviceInfoDeviceManufacturer: String;
begin
  result := 'Apple';
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoDeviceManufacturer: String;
begin
  result := 'Apple';
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}


{$IFDEF ANDROID}
function getDeviceInfoDeviceManufacturer: String;
begin
  result := JStringToString(TJBuild.JavaClass.MANUFACTURER);
  Result := Result.ToUpper;
end;
{$ENDIF}


//****************************
//          DEVICE MODEL
//****************************

{$IFDEF MSWINDOWS}
function getDeviceInfoDeviceModel: String;
var
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject   : OLEVariant;
  oEnum         : IEnumvariant;
  iValue        : LongWord;
begin
  result := '';
  try
    CoInitialize(nil);
    try
      FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      FWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      FWbemObjectSet:= FWMIService.ExecQuery('SELECT Model FROM Win32_ComputerSystem','WQL',$00000020);
      oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
      if oEnum.Next(1, FWbemObject, iValue) = 0 then
        Result := Format('%s',[String(FWbemObject.Model)]);
    finally
      CoUninitialize;
    end;
  except
  end;
  Result := Result.ToUpper;
end;
{$ENDIF}

{$IFDEF OSX}
function getDeviceInfoDeviceModel: String;
var
  Device : UIDevice;
begin
  Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  result := NSStrToStr(Device.model);
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoDeviceModel: String;
var
  Device : UIDevice;
begin
  Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  result := NSStrToStr(Device.model);
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoDeviceModel: String;
begin
  result := JStringToString(TJBuild.JavaClass.MODEL);
  Result := Result.ToUpper;
end;
{$ENDIF}

//****************************
//          OS NAME
//****************************

function getDeviceInfoOSName2: String;
begin
  Result := TOSVersion.Name;
  Result := Result.ToUpper;
end;

{$IFDEF MSWINDOWS}
function getDeviceInfoOSName: String;
var
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject   : OLEVariant;
  oEnum         : IEnumvariant;
  iValue        : LongWord;
begin
  result := '';
  try
    CoInitialize(nil);
    try
      FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      FWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      FWbemObjectSet:= FWMIService.ExecQuery('SELECT Caption FROM Win32_OperatingSystem','WQL',$00000020);
      oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
      if oEnum.Next(1, FWbemObject, iValue) = 0 then
        Result := Format('%s',[String(FWbemObject.Caption)]);
    finally
      CoUninitialize;
    end;
  except
  end;
  Result := Result.ToUpper;
end;
{$ENDIF}

{$IFDEF OSX}
function getDeviceInfoOSName: String;
begin
  result := '';
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoOSName: String;
var
  Device : UIDevice;
begin
  Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  result := NSStrToStr(Device.systemName);
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoOSName: String;
begin
  result := JStringToString(TJBuild_VERSION.JavaClass.RELEASE);
  Result := Result.ToUpper;
end;
{$ENDIF}

//****************************
//          OS VERSION
//****************************

function getDeviceInfoOSVersion2: String;
begin
  Result := Format('%d.%d.%d', [TOSVersion.Major, TOSVersion.Minor, TOSVersion.Build, TOSVersion.ServicePackMajor]);

  case TOSVersion.Architecture of
    arIntelX86 : Result := Result + ' x86';
    arIntelX64 : Result := Result + ' x64';
    arARM32    : Result := Result + ' ARM32';
    arARM64    : Result := Result + ' ARM64';
  end;

  Result := Result.ToUpper;
end;

{$IFDEF MSWINDOWS}
function getDeviceInfoOSVersion: String;
var
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject   : OLEVariant;
  oEnum         : IEnumvariant;
  iValue        : LongWord;
begin
  result := '';
  try
    CoInitialize(nil);
    try
      FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      FWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      FWbemObjectSet:= FWMIService.ExecQuery('SELECT CSDVersion FROM Win32_ComputerSystem','WQL',$00000020);
      oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
      if oEnum.Next(1, FWbemObject, iValue) = 0 then
        Result := Format('%s',[String(FWbemObject.CSDVersion)]);
    finally
      CoUninitialize;
    end;
  except
  end;
  Result := Result.ToUpper;
end;
{$ENDIF}

{$IFDEF OSX}
function getDeviceInfoOSVersion: String;
begin
  result := '';
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoOSVersion: String;
var
  Device : UIDevice;
begin
  Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  result := NSStrToStr(Device.systemVersion);
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoOSVersion: String;
begin
  result := JStringToString(TJBuild_VERSION.JavaClass.RELEASE);
  Result := Result.ToUpper;
end;
{$ENDIF}

//****************************
//          DEVICE ID
//****************************

{$IFDEF MSWINDOWS}
function getDeviceInfoDeviceUID: String;
var
  FSWbemLocator : OLEVariant;
  FWMIService   : OLEVariant;
  FWbemObjectSet: OLEVariant;
  FWbemObject   : OLEVariant;
  oEnum         : IEnumvariant;
  iValue        : LongWord;
begin
  result := '';
  try
    CoInitialize(nil);
    try
      FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      FWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      FWbemObjectSet:= FWMIService.ExecQuery('SELECT SerialNumber FROM Win32_BIOS','WQL',$00000020);
      oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
      if oEnum.Next(1, FWbemObject, iValue) = 0 then
        Result := Format('%s',[String(FWbemObject.SerialNumber)]);
    finally
      CoUninitialize;
    end;
  except
  end;
  Result := Result.ToUpper;
end;

{$ENDIF}

{$IFDEF OSX}
function getDeviceInfoDeviceUID: String;
begin
  result := '';
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoDeviceUID: String;
var
  IMEI: String;
  device : UIDevice;
begin
  IMEI := '';

  device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);

  IMEI :=           device.identifierForVendor.UUIDString.UTF8String;
  //IMEI   := NSStrToStr(Device.identifierForVendor.UUIDString);
//ShowMessage(Device.uniqueIdentifier.UTF8String);
 //   ShowMessage(Device.identifierForVendor.UUIDString.UTF8String);

  result := IMEI;
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoDeviceUID: String;
var
  IMEI: String;
  obj: JObject;
  TM: JTelephonyManager;
  strPermission : String;
begin
  IMEI := '';

  strPermission := JStringToString(TJManifest_permission.JavaClass.READ_PHONE_STATE);
  PermissionsService.RequestPermissions([strPermission],nil, nil);

  TM   := TJTelephonyManager.Create;
  IMEI := JStringToString(TM.getImei);

  if IMEI = '' then
    IMEI := JStringToString(TJSettings_Secure.JavaClass.getString( TAndroidHelper.Activity.getContentResolver, TJSettings_Secure.JavaClass.ANDROID_ID));

//  // OLD WAY
//  obj := TAndroidHelper.Activity.getSystemService(TJContext.JavaClass.TELEPHONY_SERVICE);
//  if obj <> nil then
//    begin
//      TM := TJTelephonyManager.Wrap( (obj as ILocalObject).GetObjectID );
//      if TM <> nil then
//        IMEI := JStringToString(tm.getDeviceId);
//    end;
//  if IMEI = '' then
//    IMEI := JStringToString(TJSettings_Secure.JavaClass.getString( TAndroidHelper.Activity.getContentResolver, TJSettings_Secure.JavaClass.ANDROID_ID));

  Result := IMEI;
  Result := Result.ToUpper;
end;
{$ENDIF}


//****************************
//          OS LANG
//****************************


{$IFDEF MSWINDOWS}
function getDeviceInfoOSLang: String;
var
  buffer: MarshaledString;
  UserLCID: LCID;
  BufLen: Integer;
begin
  // defaults
  UserLCID := GetUserDefaultLCID;
  BufLen := GetLocaleInfo(UserLCID, LOCALE_SISO639LANGNAME, nil, 0);
  buffer := StrAlloc(BufLen);
  if GetLocaleInfo(UserLCID, LOCALE_SISO639LANGNAME, buffer, BufLen) <> 0 then
    Result := buffer
  else
    Result := 'en';
  StrDispose(buffer);
  Result := Result.ToUpper;
end;
{$ENDIF}

{$IFDEF OSX}
function getDeviceInfoOSLang: String;
begin
  result := '';
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoOSLang: String;
var
  Languages: NSArray;
begin
  Languages := TNSLocale.OCClass.preferredLanguages;
  Result := TNSString.Wrap(Languages.objectAtIndex(0)).UTF8String;
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}


{$IFDEF ANDROID}
function getDeviceInfoOSLang: String;
var
  LocServ: IFMXLocaleService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, IInterface(LocServ)) then
    Result := LocServ.GetCurrentLangID;
  Result := Result.ToUpper;
end;
{$ENDIF}


//****************************
//          AUTO TIME
//****************************

{$IFDEF MSWINDOWS}
function getSettings_AutoTime: Boolean;
begin
  Result := True;
end;
{$ENDIF}

{$IFDEF OSX}
function getSettings_AutoTime: Boolean;
begin
  Result := True;
end;
{$ELSE}
{$IFDEF IOS}
function getSettings_AutoTime: Boolean;
begin
  Result := True;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getSettings_AutoTime: Boolean;
var
  str : String;
begin
  Result := False;

  str := JStringToString( TJSettings_System.JavaClass.getString( TAndroidHelper.ContentResolver, TJSettings_System.JavaClass.AUTO_TIME ) );

  if str = '1' then
    Result := True;
end;
{$ENDIF}

//****************************
//          TIME ZONE
//****************************

//****************************
//          SCALE
//****************************

function getDeviceScreenScale: Single ;
var
  ScreenService: IFMXScreenService;
begin
  Result := 0;
  if TPlatformServices.Current.SupportsPlatformService (IFMXScreenService, IInterface(ScreenService)) then
    begin
      Result := ScreenService.GetScreenScale;
    end;

end;


end.
