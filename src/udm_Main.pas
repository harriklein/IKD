unit udm_Main;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin, FMX.DialogService;

type
  Tdm_Main = class(TDataModule)
    tb_UserLogin: TFDMemTable;
    tb_UserLoginid: TStringField;
    tb_UserLoginUsername: TStringField;
    tb_UserLoginPassword: TStringField;
    tb_UserLoginName: TStringField;
    tb_UserLoginLastLogin: TDateTimeField;
    tb_UserLoginLevel: TStringField;
    tb_User: TFDMemTable;
    tb_Userid: TFDAutoIncField;
    tb_UserActive: TBooleanField;
    tb_UserLevel: TLongWordField;
    tb_UserUsername: TStringField;
    tb_UserPassword: TStringField;
    tb_UserResetPassword: TBooleanField;
    tb_UserName: TStringField;
    tb_Boat: TFDMemTable;
    tb_BoatNumber: TStringField;
    tb_BoatActive: TBooleanField;
    tb_BoatRented: TBooleanField;
    tb_BoatRentedAt: TDateTimeField;
    tb_BoatAdvancedPaymentValue: TLongWordField;
    tb_BoatAdvancedPaymentMinutes: TLongWordField;
    tb_Rental: TFDMemTable;
    tb_RentalBoat_id: TLongWordField;
    tb_RentalRentedAt: TDateTimeField;
    tb_RentalRentFinishedAt: TDateTimeField;
    tb_RentalAdvancedPaymentValue: TLongWordField;
    tb_RentalAdvancedPaymentMinutes: TLongWordField;
    tb_RentalCalculedPaymentValue: TLongWordField;
    tb_RentalCalculedPaymentMinutes: TLongWordField;
    tb_RentalPaymentChanged: TBooleanField;
    tb_RentalPaymentValue: TLongWordField;
    tb_RentalPaymentMinutes: TLongWordField;
    tb_RentalNumber: TStringField;
    tb_RentalTotal: TAggregateField;
    FDStanStorageBinLink: TFDStanStorageBinLink;
    tb_BoatColor: TLongWordField;
    tb_BoatDefaultValue: TLongWordField;
    tb_Rentalid: TGuidField;
    procedure DataModuleCreate(Sender: TObject);
    procedure tb_RentalNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm_Main: Tdm_Main;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses unt_DeviceUtils, unt_VSoftUUIDv7;

{$R *.dfm}

procedure Tdm_Main.DataModuleCreate(Sender: TObject);
begin
  // to fix the file path
  tb_UserLogin.ResourceOptions.PersistentFileName :=  GetPath(tb_UserLogin.ResourceOptions.PersistentFileName);
       tb_User.ResourceOptions.PersistentFileName :=  GetPath(     tb_User.ResourceOptions.PersistentFileName);
       tb_Boat.ResourceOptions.PersistentFileName :=  GetPath(     tb_Boat.ResourceOptions.PersistentFileName);
     tb_Rental.ResourceOptions.PersistentFileName :=  GetPath(   tb_Rental.ResourceOptions.PersistentFileName);

//  if false then
//    begin
//      DeleteFile(GetPath(tb_UserLogin.ResourceOptions.PersistentFileName));
//      DeleteFile(GetPath(     tb_User.ResourceOptions.PersistentFileName));
//      DeleteFile(GetPath(     tb_Boat.ResourceOptions.PersistentFileName));
//      DeleteFile(GetPath(   tb_Rental.ResourceOptions.PersistentFileName));
//    end;

  // Meka sure that we have a file to Load, this avoid exception with LocaFromFile in Prepare procedures
  if not FileExists(tb_UserLogin.ResourceOptions.PersistentFileName) then
    begin
      tb_UserLogin.CreateDataSet;  // We have to create the basic structure, otherwise it reises an exception
      tb_UserLogin.SaveToFile();
    end;
  if not FileExists(tb_User.ResourceOptions.PersistentFileName     ) then
    begin
      tb_User.CreateDataSet;
      tb_User.SaveToFile();
    end;
  if not FileExists(tb_Boat.ResourceOptions.PersistentFileName     ) then
    begin
      tb_Boat.CreateDataSet;
      tb_Boat.SaveToFile();
    end;
  if not FileExists(tb_Rental.ResourceOptions.PersistentFileName   ) then
    begin
      tb_Rental.CreateDataSet;
      tb_Rental.SaveToFile();
    end
  else
    begin
//      DeleteFile(tb_Rental.ResourceOptions.PersistentFileName);
//      tb_Rental.CreateDataSet;
//      tb_Rental.SaveToFile();
    end;

  try
    tb_UserLogin.LoadFromFile();
  except
    tb_UserLogin.CreateDataSet;
    tb_UserLogin.SaveToFile();
  end;

  try
    tb_User.LoadFromFile();
  except
    tb_User.CreateDataSet;
    tb_User.SaveToFile();
  end;

  try
    tb_Boat.LoadFromFile();
  except
    tb_Boat.CreateDataSet;
    tb_Boat.SaveToFile();
  end;

  try
    tb_Rental.LoadFromFile();
  except
    tb_Rental.CreateDataSet;
    tb_Rental.SaveToFile();
  end;
end;

procedure Tdm_Main.tb_RentalNewRecord(DataSet: TDataSet);
var
  uuid : TGuid;
begin
  uuid := TUUIDv7Helper.CreateV7;
  tb_Rentalid.AsGuid := uuid;
//  TDialogService.ShowMessage(tb_Rentalid.AsString);
end;

end.
