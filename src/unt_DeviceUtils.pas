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
  _FileName: String;
  _InfoSize: DWORD;
  _WND     : DWORD;
  _VerBuf  : Pointer;
  _FI      : PVSFixedFileInfo;
  _VerSize : DWORD;
begin
  Result := False;
  // GetFileVersionInfo modifies the filename parameter data while parsing.
  // Copy the String const into a local variable to create a writeable copy.
  if AFileName = '' then
    _FileName := ParamStr(0)
  else
    _FileName := AFileName;
  UniqueString(_FileName);
  _InfoSize := GetFileVersionInfoSize(PChar(_FileName), _WND);
  if _InfoSize <> 0 then
  begin
    GetMem(_VerBuf, _InfoSize);
    try
      if GetFileVersionInfo(PChar(_FileName), _WND, _InfoSize, _VerBuf) then
        if VerQueryValue(_VerBuf, '\', Pointer(_FI), _VerSize) then
        begin
          AMajor   := HiWord(_FI.dwProductVersionMS);
          AMinor   := LoWord(_FI.dwProductVersionMS);
          ARelease := HiWord(_FI.dwProductVersionLS);
          ABuild   := LoWord(_FI.dwProductVersionLS);
          Result:= True;
        end;
    finally
      FreeMem(_VerBuf);
    end;
  end;
end;

function getAppVersion: String;
var
  _V1, _V2, _V3, _V4: WORD;
begin
  GetBuildInfo('', _V1, _V2, _V3, _V4);
  Result := IntToStr(_V1) + '.' + IntToStr(_V2) + '.' +  IntToStr(_V3);
end;
{$ENDIF}

{$IFDEF ANDROID}
function getAppVersion: String;
var
  _PackageManager: JPackageManager;
  _PackageInfo   : JPackageInfo;
begin
  _PackageManager := TAndroidHelper.Activity.getPackageManager;
  _PackageInfo    := _PackageManager.getPackageInfo(TAndroidHelper.Context.getPackageName(), TJPackageManager.JavaClass.GET_ACTIVITIES);
  Result          := JStringToString(_PackageInfo.VersionName);
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
  _FSWbemLocator : OLEVariant;
  _FWMIService   : OLEVariant;
  _FWbemObjectSet: OLEVariant;
  _FWbemObject   : OLEVariant;
  _oEnum         : IEnumvariant;
  _iValue        : LongWord;
begin
  try
    CoInitialize(nil);
    try
      _FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      _FWMIService   := _FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      _FWbemObjectSet:= _FWMIService.ExecQuery('SELECT Manufacturer FROM Win32_ComputerSystem','WQL',$00000020);
      _oEnum         := IUnknown(_FWbemObjectSet._NewEnum) as IEnumVariant;
      if _oEnum.Next(1, _FWbemObject, _iValue) = 0 then
        Result := Format('%s',[String(_FWbemObject.Manufacturer)]);
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
  _FSWbemLocator : OLEVariant;
  _FWMIService   : OLEVariant;
  _FWbemObjectSet: OLEVariant;
  _FWbemObject   : OLEVariant;
  _oEnum         : IEnumvariant;
  _iValue        : LongWord;
begin
  Result := '';
  try
    CoInitialize(nil);
    try
      _FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      _FWMIService   := _FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      _FWbemObjectSet:= _FWMIService.ExecQuery('SELECT Model FROM Win32_ComputerSystem','WQL',$00000020);
      _oEnum         := IUnknown(_FWbemObjectSet._NewEnum) as IEnumVariant;
      if _oEnum.Next(1, _FWbemObject, _iValue) = 0 then
        Result := Format('%s',[String(_FWbemObject.Model)]);
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
  _Device : UIDevice;
begin
  _Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  Result := NSStrToStr(_Device.model);
  Result := Result.ToUpper;
end;
{$ELSE}
{$IFDEF IOS}
function getDeviceInfoDeviceModel: String;
var
  _Device : UIDevice;
begin
  _Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  Result := NSStrToStr(_Device.model);
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
  _FSWbemLocator : OLEVariant;
  _FWMIService   : OLEVariant;
  _FWbemObjectSet: OLEVariant;
  _FWbemObject   : OLEVariant;
  _oEnum         : IEnumvariant;
  _iValue        : LongWord;
begin
  Result := '';
  try
    CoInitialize(nil);
    try
      _FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      _FWMIService   := _FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      _FWbemObjectSet:= _FWMIService.ExecQuery('SELECT Caption FROM Win32_OperatingSystem','WQL',$00000020);
      _oEnum         := IUnknown(_FWbemObjectSet._NewEnum) as IEnumVariant;
      if _oEnum.Next(1, _FWbemObject, _iValue) = 0 then
        Result := Format('%s',[String(_FWbemObject.Caption)]);
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
  _Device : UIDevice;
begin
  _Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  Result  := NSStrToStr(_Device.systemName);
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
  _FSWbemLocator : OLEVariant;
  _FWMIService   : OLEVariant;
  _FWbemObjectSet: OLEVariant;
  _FWbemObject   : OLEVariant;
  _oEnum         : IEnumvariant;
  _iValue        : LongWord;
begin
  Result := '';
  try
    CoInitialize(nil);
    try
      _FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      _FWMIService   := _FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      _FWbemObjectSet:= _FWMIService.ExecQuery('SELECT CSDVersion FROM Win32_ComputerSystem','WQL',$00000020);
      _oEnum         := IUnknown(_FWbemObjectSet._NewEnum) as IEnumVariant;
      if _oEnum.Next(1, _FWbemObject, _iValue) = 0 then
        Result := Format('%s',[String(_FWbemObject.CSDVersion)]);
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
  _Device : UIDevice;
begin
  _Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);
  Result  := NSStrToStr(_Device.systemVersion);
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
  _FSWbemLocator : OLEVariant;
  _FWMIService   : OLEVariant;
  _FWbemObjectSet: OLEVariant;
  _FWbemObject   : OLEVariant;
  _oEnum         : IEnumvariant;
  _iValue        : LongWord;
begin
  Result := '';
  try
    CoInitialize(nil);
    try
      _FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
      _FWMIService   := _FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
      _FWbemObjectSet:= _FWMIService.ExecQuery('SELECT SerialNumber FROM Win32_BIOS','WQL',$00000020);
      _oEnum         := IUnknown(_FWbemObjectSet._NewEnum) as IEnumVariant;
      if _oEnum.Next(1, _FWbemObject, _iValue) = 0 then
        Result := Format('%s',[String(_FWbemObject.SerialNumber)]);
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
  _IMEI: String;
  _Device : UIDevice;
begin
  _IMEI := '';

  _Device := TUIDevice.Wrap(TUIDevice.OCClass.currentDevice);

  _IMEI :=           _Device.identifierForVendor.UUIDString.UTF8String;
  //_IMEI   := NSStrToStr(_Device.identifierForVendor.UUIDString);
//ShowMessage(_Device.uniqueIdentifier.UTF8String);
 //   ShowMessage(_Device.identifierForVendor.UUIDString.UTF8String);

  Result := _IMEI;
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}

{$IFDEF ANDROID}
function getDeviceInfoDeviceUID: String;
var
  _IMEI: String;
  _obj : JObject;
  _TM  : JTelephonyManager;
  _strPermission : String;
begin
  _IMEI := '';

  _strPermission := JStringToString(TJManifest_permission.JavaClass.READ_PHONE_STATE);
  PermissionsService.RequestPermissions([_strPermission],nil, nil);

  _TM   := TJTelephonyManager.Create;
  _IMEI := JStringToString(_TM.getImei);

  if _IMEI = '' then
    _IMEI := JStringToString(TJSettings_Secure.JavaClass.getString( TAndroidHelper.Activity.getContentResolver, TJSettings_Secure.JavaClass.ANDROID_ID));

//  // OLD WAY
//  _obj := TAndroidHelper.Activity.getSystemService(TJContext.JavaClass.TELEPHONY_SERVICE);
//  if _obj <> nil then
//    begin
//      _TM := TJTelephonyManager.Wrap( (_obj as ILocalObject).GetObjectID );
//      if TM <> nil then
//        _IMEI := JStringToString(_TM.getDeviceId);
//    end;
//  if _IMEI = '' then
//    _IMEI := JStringToString(TJSettings_Secure.JavaClass.getString( TAndroidHelper.Activity.getContentResolver, TJSettings_Secure.JavaClass.ANDROID_ID));

  Result := _IMEI;
  Result := Result.ToUpper;
end;
{$ENDIF}


//****************************
//          OS LANG
//****************************


{$IFDEF MSWINDOWS}
function getDeviceInfoOSLang: String;
var
  _buffer: MarshaledString;
  _userLCID: LCID;
  _bufLen: Integer;
begin
  // defaults
  _userLCID := GetUserDefaultLCID;
  _bufLen := GetLocaleInfo(_userLCID, LOCALE_SISO639LANGNAME, nil, 0);
  _buffer := StrAlloc(_bufLen);
  if GetLocaleInfo(_userLCID, LOCALE_SISO639LANGNAME, _buffer, _bufLen) <> 0 then
    Result := _buffer
  else
    Result := 'en';
  StrDispose(_buffer);
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
  _languages: NSArray;
begin
  _languages := TNSLocale.OCClass.preferredLanguages;
  Result := TNSString.Wrap(_languages.objectAtIndex(0)).UTF8String;
  Result := Result.ToUpper;
end;
{$ENDIF}
{$ENDIF}


{$IFDEF ANDROID}
function getDeviceInfoOSLang: String;
var
  _locServ: IFMXLocaleService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, IInterface(_locServ)) then
    Result := _locServ.GetCurrentLangID;
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
  _str : String;
begin
  Result := false;

  _str := JStringToString( TJSettings_System.JavaClass.getString( TAndroidHelper.ContentResolver, TJSettings_System.JavaClass.AUTO_TIME ) );

  if _str = '1' then
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
  _ScreenService: IFMXScreenService;
begin
  Result := 0;
  if TPlatformServices.Current.SupportsPlatformService (IFMXScreenService, IInterface(_ScreenService)) then
    begin
      Result := _ScreenService.GetScreenScale;
    end;
end;


end.
