unit udm_Main;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin;

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
    tb_Boatid: TFDAutoIncField;
    tb_BoatNumber: TStringField;
    tb_BoatActive: TBooleanField;
    tb_BoatRented: TBooleanField;
    tb_BoatRentedAt: TDateTimeField;
    tb_BoatAdvancedPaymentValue: TLongWordField;
    tb_BoatAdvancedPaymentMinutes: TLongWordField;
    tb_Rental: TFDMemTable;
    FDAutoIncField1: TFDAutoIncField;
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
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm_Main: Tdm_Main;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses unt_DeviceUtils;

{$R *.dfm}

procedure Tdm_Main.DataModuleCreate(Sender: TObject);
begin
  // to fix the file path
  tb_UserLogin.ResourceOptions.PersistentFileName :=  GetPath(tb_UserLogin.ResourceOptions.PersistentFileName);
  tb_User.ResourceOptions.PersistentFileName      :=  GetPath(tb_User.ResourceOptions.PersistentFileName);
  tb_Boat.ResourceOptions.PersistentFileName      :=  GetPath(tb_Boat.ResourceOptions.PersistentFileName);
  tb_Rental.ResourceOptions.PersistentFileName    :=  GetPath(tb_Rental.ResourceOptions.PersistentFileName);

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

  tb_UserLogin.LoadFromFile();
  tb_User.LoadFromFile();
  tb_Boat.LoadFromFile();
  tb_Rental.LoadFromFile();
end;

end.
