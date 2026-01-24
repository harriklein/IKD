unit unt_DeviceUtils;

interface


function MD5(AString: String): String;
function GetPath(AFileName: String = ''): String;
function GetDownloadPath(AFileName: String = ''): String;

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
    Androidapi.JNI.Telephony, Androidapi.JNI.Provider, Androidapi.JNIBridge,
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


function MD5(AString: String): String;
begin
  with TIdHashMessageDigest5.Create do
    begin
      Result := HashStringAsHex(AString);
      Free;
    end;
end;

function GetPath(AFileName: String = ''): String;
begin
{$IF DEFINED(LINUX64) OR DEFINED(MSWINDOWS) }
  Result := ExtractFilePath(ParamStr(0));
{$ELSE}
  Result := TPath.GetDocumentsPath;
{$ENDIF}

  if not AFileName.IsEmpty then
    Result := TPath.Combine(Result, AFileName);
end;

function GetDownloadPath(AFileName: String = ''): String;
begin
{$IF DEFINED(LINUX64) OR DEFINED(MSWINDOWS) }
  Result := ExtractFilePath(ParamStr(0));
{$ELSE}
  Result := TPath.GetDownloadsPath;
{$ENDIF}

  if not AFileName.IsEmpty then
    Result := TPath.Combine(Result, AFileName);
end;

//------------------------------------------------------------------------------

{$IFDEF MSWINDOWS}
function GetBuildInfo(const AFileName: String; var AMajor, AMinor, ARelease, ABuild: WORD): Boolean;
var
  LFileName: String;
  LInfoSize: DWORD;
  LWND     : DWORD;
  LVerBuf  : Pointer;
  LFI      : PVSFixedFileInfo;
  LVerSize : DWORD;
begin
  Result := False;
  // GetFileVersionInfo modifies the filename parameter data while parsing.
  // Copy the String const into a local variable to create a writeable copy.
  if AFileName = '' then
    LFileName := ParamStr(0)
  else
    LFileName := AFileName;
  UniqueString(LFileName);
  LInfoSize := GetFileVersionInfoSize(PChar(LFileName), LWND);
  if LInfoSize <> 0 then
  begin
    GetMem(LVerBuf, LInfoSize);
    try
      if GetFileVersionInfo(PChar(LFileName), LWND, LInfoSize, LVerBuf) then
        if VerQueryValue(LVerBuf, '\', Pointer(LFI), LVerSize) then
        begin
          AMajor   := HiWord(LFI.dwProductVersionMS);
          AMinor   := LoWord(LFI.dwProductVersionMS);
          ARelease := HiWord(LFI.dwProductVersionLS);
          ABuild   := LoWord(LFI.dwProductVersionLS);
          Result:= True;
        end;
    finally
      FreeMem(LVerBuf);
    end;
  end;
end;

function getAppVersion: String;
var
  LV1, LV2, LV3, LV4: WORD;
begin
  GetBuildInfo('', LV1, LV2, LV3, LV4);
  Result := IntToStr(LV1) + '.' + IntToStr(LV2) + '.' +  IntToStr(LV3);
end;
{$ENDIF}

{$IFDEF ANDROID}
function getAppVersion: String;
var
  LPackageManager: JPackageManager;
  LPackageInfo   : JPackageInfo;
begin
  LPackageManager := TAndroidHelper.Activity.getPackageManager;
  LPackageInfo    := LPackageManager.getPackageInfo(TAndroidHelper.Context.getPackageName(), TJPackageManager.JavaClass.GET_ACTIVITIES);
  Result          := JStringToString(LPackageInfo.VersionName);
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
  Result := 'WINDOWS';
end;
{$ENDIF}

{$IFDEF OSX}
function getDeviceInfoPlatform: String;
begin
  Result := 'MACOS';
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoPlatform: String;
begin
  Result := 'IOS';
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoPlatform: String;
begin
  Result := 'ANDROID';
end;
{$ENDIF}

//****************************
//          DEVICE MANUFACTURER
//****************************

{$IFDEF MSWINDOWS}
function getDeviceInfoDeviceManufacturer: String;
var
  LFSWbemLocator : OLEVariant;
  LFWMIService   : OLEVariant;
  LFWbemObjectSet: OLEVariant;
  LFWbemObject   : OLEVariant;
  _oEnum         : IEnumvariant;
  _iValue        : LongWord;
begin
  try
    CoInitialize(nil);
    try
      LFSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      LFWMIService   := LFSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      LFWbemObjectSet:= LFWMIService.ExecQuery('SELECT Manufacturer FROM Win32_ComputerSystem','WQL',$00000020);
      _oEnum         := IUnknown(LFWbemObjectSet._NewEnum) as IEnumVariant;
      if _oEnum.Next(1, LFWbemObject, _iValue) = 0 then
        Result := Format('%s',[String(LFWbemObject.Manufacturer)]);
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
  Result := 'Apple';
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoDeviceManufacturer: String;
begin
  Result := 'Apple';
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}


{$IFDEF ANDROID}
function getDeviceInfoDeviceManufacturer: String;
begin
  Result := JStringToString(TJBuild.JavaClass.MANUFACTURER);
  Result := Result.ToUpper;
end;
{$ENDIF}


//****************************
//          DEVICE MODEL
//****************************

{$IFDEF MSWINDOWS}
function getDeviceInfoDeviceModel: String;
var
  LFSWbemLocator : OLEVariant;
  LFWMIService   : OLEVariant;
  LFWbemObjectSet: OLEVariant;
  LFWbemObject   : OLEVariant;
  LEnum         : IEnumvariant;
  LValue        : LongWord;
begin
  Result := '';
  try
    CoInitialize(nil);
    try
      LFSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      LFWMIService   := LFSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      LFWbemObjectSet:= LFWMIService.ExecQuery('SELECT Model FROM Win32_ComputerSystem','WQL',$00000020);
      LEnum         := IUnknown(LFWbemObjectSet._NewEnum) as IEnumVariant;
      if LEnum.Next(1, LFWbemObject, LValue) = 0 then
        Result := Format('%s',[String(LFWbemObject.Model)]);
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
  LDevice : UIDevice;
begin
  LDevice := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  Result := NSStrToStr(LDevice.model);
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoDeviceModel: String;
var
  LDevice : UIDevice;
begin
  LDevice := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  Result := NSStrToStr(LDevice.model);
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoDeviceModel: String;
begin
  Result := JStringToString(TJBuild.JavaClass.MODEL);
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
  LFSWbemLocator : OLEVariant;
  LFWMIService   : OLEVariant;
  LFWbemObjectSet: OLEVariant;
  LFWbemObject   : OLEVariant;
  LEnum         : IEnumvariant;
  LValue        : LongWord;
begin
  Result := '';
  try
    CoInitialize(nil);
    try
      LFSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      LFWMIService   := LFSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      LFWbemObjectSet:= LFWMIService.ExecQuery('SELECT Caption FROM Win32_OperatingSystem','WQL',$00000020);
      LEnum         := IUnknown(LFWbemObjectSet._NewEnum) as IEnumVariant;
      if LEnum.Next(1, LFWbemObject, LValue) = 0 then
        Result := Format('%s',[String(LFWbemObject.Caption)]);
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
  Result := '';
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoOSName: String;
var
  LDevice : UIDevice;
begin
  LDevice := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  Result  := NSStrToStr(LDevice.systemName);
  Result  := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoOSName: String;
begin
  Result := JStringToString(TJBuild_VERSION.JavaClass.RELEASE);
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
  LFSWbemLocator : OLEVariant;
  LFWMIService   : OLEVariant;
  LFWbemObjectSet: OLEVariant;
  LFWbemObject   : OLEVariant;
  LEnum         : IEnumvariant;
  LValue        : LongWord;
begin
  Result := '';
  try
    CoInitialize(nil);
    try
      LFSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      LFWMIService   := LFSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      LFWbemObjectSet:= LFWMIService.ExecQuery('SELECT CSDVersion FROM Win32_ComputerSystem','WQL',$00000020);
      LEnum         := IUnknown(LFWbemObjectSet._NewEnum) as IEnumVariant;
      if LEnum.Next(1, LFWbemObject, LValue) = 0 then
        Result := Format('%s',[String(LFWbemObject.CSDVersion)]);
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
  Result := '';
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoOSVersion: String;
var
  LDevice : UIDevice;
begin
  LDevice := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  Result  := NSStrToStr(LDevice.systemVersion);
  Result  := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoOSVersion: String;
begin
  Result := JStringToString(TJBuild_VERSION.JavaClass.RELEASE);
  Result := Result.ToUpper;
end;
{$ENDIF}

//****************************
//          DEVICE ID
//****************************

{$IFDEF MSWINDOWS}
function getDeviceInfoDeviceUID: String;
var
  LFSWbemLocator : OLEVariant;
  LFWMIService   : OLEVariant;
  LFWbemObjectSet: OLEVariant;
  LFWbemObject   : OLEVariant;
  LEnum         : IEnumvariant;
  LValue        : LongWord;
begin
  Result := '';
  try
    CoInitialize(nil);
    try
      LFSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      LFWMIService   := LFSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      LFWbemObjectSet:= LFWMIService.ExecQuery('SELECT SerialNumber FROM Win32_BIOS','WQL',$00000020);
      LEnum         := IUnknown(LFWbemObjectSet._NewEnum) as IEnumVariant;
      if LEnum.Next(1, LFWbemObject, LValue) = 0 then
        Result := Format('%s',[String(LFWbemObject.SerialNumber)]);
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
  Result := '';
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoDeviceUID: String;
var
  LIMEI: String;
  LDevice : UIDevice;
begin
  LIMEI := '';

  LDevice := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);

  LIMEI :=           LDevice.identifierForVendor.UUIDString.UTF8String;
  //LIMEI   := NSStrToStr(LDevice.identifierForVendor.UUIDString);
//ShowMessage(LDevice.uniqueIdentifier.UTF8String);
 //   ShowMessage(LDevice.identifierForVendor.UUIDString.UTF8String);

  Result := LIMEI;
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoDeviceUID: String;
var
  ContentResolver: JContentResolver;
  AndroidID: JString;
begin
  ContentResolver := TAndroidHelper.Context.getContentResolver;
  AndroidID := TJSettings_Secure.JavaClass.getString(ContentResolver,
                TJSettings_Secure.JavaClass.ANDROID_ID);
  Result := JStringToString(AndroidID) + ' (ANDROID_ID)';
end;

function getDeviceInfoDeviceUID2: String;
var
  LIMEI: String;
  LObj : JObject;
  LTM  : JTelephonyManager;
  LPermission : String;
begin
  LIMEI := '';

  LPermission := JStringToString(TJManifest_permission.JavaClass.READ_PHONE_STATE);
  PermissionsService.RequestPermissions([LPermission],nil, nil);

  LTM   := TJTelephonyManager.Create;
  LIMEI := JStringToString(LTM.getImei);

  if LIMEI = '' then
    LIMEI := JStringToString(TJSettings_Secure.JavaClass.getString( TAndroidHelper.Activity.getContentResolver, TJSettings_Secure.JavaClass.ANDROID_ID));

//  // OLD WAY
//  LObj := TAndroidHelper.Activity.getSystemService(TJContext.JavaClass.TELEPHONY_SERVICE);
//  if LObj <> nil then
//    begin
//      LTM := TJTelephonyManager.Wrap( (LObj as ILocalObject).GetObjectID );
//      if TM <> nil then
//        LIMEI := JStringToString(LTM.getDeviceId);
//    end;
//  if LIMEI = '' then
//    LIMEI := JStringToString(TJSettings_Secure.JavaClass.getString( TAndroidHelper.Activity.getContentResolver, TJSettings_Secure.JavaClass.ANDROID_ID));

  Result := LIMEI;
  Result := Result.ToUpper;
end;
{$ENDIF}


//****************************
//          OS LANG
//****************************


{$IFDEF MSWINDOWS}
function getDeviceInfoOSLang: String;
var
  LBuffer: MarshaledString;
  LUserLCID: LCID;
  LBufferLen: Integer;
begin
  // defaults
  LUserLCID := GetUserDefaultLCID;
  LBufferLen := GetLocaleInfo(LUserLCID, LOCALE_SISO639LANGNAME, nil, 0);
  LBuffer := StrAlloc(LBufferLen);
  if GetLocaleInfo(LUserLCID, LOCALE_SISO639LANGNAME, LBuffer, LBufferLen) <> 0 then
    Result := LBuffer
  else
    Result := 'en';
  StrDispose(LBuffer);
  Result := Result.ToUpper;
end;
{$ENDIF}

{$IFDEF OSX}
function getDeviceInfoOSLang: String;
begin
  Result := '';
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoOSLang: String;
var
  LLanguages: NSArray;
begin
  LLanguages := TNSLocale.OCClass.preferredLanguages;
  Result := TNSString.Wrap(LLanguages.objectAtIndex(0)).UTF8String;
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}


{$IFDEF ANDROID}
function getDeviceInfoOSLang: String;
var
  LLocaleService: IFMXLocaleService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, IInterface(LLocaleService)) then
    Result := LLocaleService.GetCurrentLangID;
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
  LValue : String;
begin
  Result := false;

  LValue := JStringToString( TJSettings_System.JavaClass.getString( TAndroidHelper.ContentResolver, TJSettings_System.JavaClass.AUTO_TIME ) );

  if LValue = '1' then
    Result := True;
end;
{$ENDIF}

//****************************
//          TIME ZONE
//****************************

//****************************
//          SCALE
//****************************

function getDeviceScreenScale: Single;
var
  LScreenService: IFMXScreenService;
begin
  Result := 0;
  if TPlatformServices.Current.SupportsPlatformService (IFMXScreenService, IInterface(LScreenService)) then
    begin
      Result := LScreenService.GetScreenScale;
    end;
end;


end.
