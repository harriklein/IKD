unit udm_Main;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin, FMX.DialogService, System.Hash,
  System.IOUtils,
  FMX.Platform,
  FMX.Types;

type
  Tdm_Main = class(TDataModule)
    tb_Boat: TFDMemTable;
    tb_Boatnumber: TStringField;
    tb_Boatactive: TBooleanField;
    tb_Boatrented: TBooleanField;
    tb_Rental: TFDMemTable;
    tb_RentalstartAt: TDateTimeField;
    tb_RentalendAt: TDateTimeField;
    tb_RentalboatNumber: TStringField;
    FDStanStorageBinLink: TFDStanStorageBinLink;
    tb_Boatcolor: TLongWordField;
    tb_BoatdefaultValue: TLongWordField;
    tb_Rentalid: TGuidField;
    tb_BoatdefaultMinutes: TIntegerField;
    tb_BoatdefaultExtraMinutes: TLongWordField;
    tb_BoatdefaultExtraValue: TLongWordField;
    tb_PoS: TFDMemTable;
    tb_PoSactive: TBooleanField;
    tb_PoSname: TStringField;
    tb_RentalcashRegisterDate: TDateField;
    tb_RentalposName: TStringField;
    tb_Boatid: TGuidField;
    tb_PoSid: TGuidField;
    tb_BoatposId: TGuidField;
    tb_RentalboatId: TGuidField;
    tb_RentalposId: TGuidField;
    tb_RentalcashRegisterCount: TIntegerField;
    tb_CashRegister: TFDMemTable;
    tb_CashRegisterposId: TGuidField;
    tb_CashRegisterdate: TDateField;
    tb_CashRegisterCount: TIntegerField;
    tb_CashRegisterexpensesTotal: TCurrencyField;
    tb_CashRegisterexpensesFuel: TCurrencyField;
    tb_CashRegisterexpensesMeal: TCurrencyField;
    tb_CashRegisterexpensesDaily: TCurrencyField;
    tb_CashRegisterexpensesOther: TCurrencyField;
    tb_CashRegisterinitialCash: TCurrencyField;
    tb_CashRegistervalidated: TBooleanField;
    tb_BoatrentedSince: TDateTimeField;
    tb_BoatrentalId: TGuidField;
    tb_BoatrentalExpectedMinutes: TLongWordField;
    tb_BoatrentalToleranceMinutes: TLongWordField;
    tb_CashRegistervalidatedAt: TDateTimeField;
    tb_CashRegisterid: TStringField;
    tb_RentalcashRegisterId: TStringField;
    tb_RentalstartPayMinutes: TLongWordField;
    tb_RentalstartPayValue: TCurrencyField;
    tb_RentalstartPayMethod: TStringField;
    tb_RentalstartPayValueCard: TCurrencyField;
    tb_RentalstartPayValueCash: TCurrencyField;
    tb_RentalstartPayValuePix: TCurrencyField;
    tb_RentalstartPayValueOther: TCurrencyField;
    tb_RentalstartPayValueDiscount: TCurrencyField;
    tb_Rentalobs: TStringField;
    tb_RentalextraMinutes: TLongWordField;
    tb_RentalextraValue: TCurrencyField;
    tb_RentalendPayMinutes: TLongWordField;
    tb_RentalendPayValue: TCurrencyField;
    tb_RentalendPayMethod: TStringField;
    tb_RentalendPayValueCard: TCurrencyField;
    tb_RentalendPayValueCash: TCurrencyField;
    tb_RentalendPayValuePix: TCurrencyField;
    tb_RentalendPayValueOther: TCurrencyField;
    tb_RentalendPayValueDiscount: TCurrencyField;
    tb_CashRegisteropen: TBooleanField;
    tb_BoatrentalPausedAt: TDateTimeField;
    tb_BoatcashRegisterId: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure tb_CashRegisterBeforePost(DataSet: TDataSet);
  private
    procedure EraseDBBoats;
    { Private declarations }
  public
    { Public declarations }
    procedure EraseDB;
    procedure EraseDBBoat;
    procedure EraseDBPoS;
    procedure EraseDBCashRegister;
    procedure EraseDBRental;

    procedure ClearValidated();

    procedure DataExport(ADateSet: TFDMemTable; AFileName: String);

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
          tb_Boat.ResourceOptions.PersistentFileName :=  GetPath(         tb_Boat.ResourceOptions.PersistentFileName);
           tb_PoS.ResourceOptions.PersistentFileName :=  GetPath(          tb_PoS.ResourceOptions.PersistentFileName);
  tb_CashRegister.ResourceOptions.PersistentFileName :=  GetPath( tb_CashRegister.ResourceOptions.PersistentFileName);
        tb_Rental.ResourceOptions.PersistentFileName :=  GetPath(       tb_Rental.ResourceOptions.PersistentFileName);

  // Make sure that we have a file to Load, this avoid exception with LocaFromFile in Prepare procedures
  if not FileExists(tb_Boat.ResourceOptions.PersistentFileName         ) then
    begin
      tb_Boat.CreateDataSet;
      tb_Boat.SaveToFile();
    end;
  if not FileExists(tb_PoS.ResourceOptions.PersistentFileName          ) then
    begin
      tb_PoS.CreateDataSet;
      tb_PoS.SaveToFile();
    end;
  if not FileExists(tb_CashRegister.ResourceOptions.PersistentFileName ) then
    begin
      tb_CashRegister.CreateDataSet;
      tb_CashRegister.SaveToFile();
    end;
  if not FileExists(tb_Rental.ResourceOptions.PersistentFileName       ) then
    begin
      tb_Rental.CreateDataSet;
      tb_Rental.SaveToFile();
    end;



  // Fail to load probably means we have changed the structure
  try
    tb_Boat.LoadFromFile();
  except
    tb_Boat.CreateDataSet;
    tb_Boat.SaveToFile();
  end;

  try
    tb_PoS.LoadFromFile();
  except
    tb_PoS.CreateDataSet;
    tb_PoS.SaveToFile();
  end;

  try
    tb_CashRegister.LoadFromFile();
  except
    tb_CashRegister.CreateDataSet;
    tb_CashRegister.SaveToFile();
  end;

  try
    tb_Rental.LoadFromFile();
  except
    tb_Rental.CreateDataSet;
    tb_Rental.SaveToFile();
  end;

  tb_Boat.Filtered         := False;
  tb_PoS.Filtered          := False;
  tb_CashRegister.Filtered := False;
  tb_Rental.Filtered       := False;

  tb_Boat.Active         := True;
  tb_PoS.Active          := True;
  tb_CashRegister.Active := True;
  tb_Rental.Active       := True;
end;

procedure Tdm_Main.EraseDB;
begin
  EraseDBBoat;
  EraseDBPoS;
  EraseDBCashRegister;
  EraseDBRental;
end;

procedure Tdm_Main.EraseDBBoat;
begin
  if FileExists(tb_Boat.ResourceOptions.PersistentFileName         ) then
    begin
      DeleteFile(tb_Boat.ResourceOptions.PersistentFileName        );
    end;
end;

procedure Tdm_Main.EraseDBBoats;
begin

end;

procedure Tdm_Main.EraseDBCashRegister;
begin
  if FileExists(tb_CashRegister.ResourceOptions.PersistentFileName ) then
    begin
      DeleteFile(tb_CashRegister.ResourceOptions.PersistentFileName);
    end;
end;

procedure Tdm_Main.EraseDBPoS;
begin
  if FileExists(tb_PoS.ResourceOptions.PersistentFileName          ) then
    begin
      DeleteFile(tb_Pos.ResourceOptions.PersistentFileName         );
    end;
end;

procedure Tdm_Main.EraseDBRental;
begin
  if FileExists(tb_Rental.ResourceOptions.PersistentFileName       ) then
    begin
      DeleteFile(tb_Rental.ResourceOptions.PersistentFileName      );
    end;
end;

procedure Tdm_Main.ClearValidated;
begin
  tb_CashRegister.Filtered := False;
  tb_CashRegister.Filter   := 'validated = TRUE';
  tb_CashRegister.Filtered := True;
  try
    tb_CashRegister.First;
    while not tb_CashRegister.Eof do
      begin
        tb_Rental.Filtered := False;
        tb_Rental.Filter   := 'cashRegisterId = ' + QuotedStr(tb_CashRegister.FieldByName('id').AsString);
        tb_Rental.Filtered := True;
        try
          tb_Rental.First;
          while not tb_Rental.Eof do
            begin
              tb_Rental.Delete;
            end;
        finally
          tb_Rental.Filtered := False;
        end;
        tb_CashRegister.Delete;
      end;
  finally
    tb_CashRegister.Filtered := False;
  end;

  tb_Rental.SaveToFile();
  tb_CashRegister.SaveToFile();
end;

procedure Tdm_Main.DataExport(ADateSet: TFDMemTable; AFileName: String);
var
  SL: TStringList;
  I: Integer;
  Line: string;
begin
  SL := TStringList.Create;
  try
    // Cabeçalho
    Line := '';
    for I := 0 to ADateSet.FieldCount - 1 do
    begin
      if I > 0 then Line := Line + ';';
      Line := Line + ADateSet.Fields[I].FieldName;
    end;
    SL.Add(Line);

    ADateSet.DisableControls;
    try
      ADateSet.First;
      while not ADateSet.Eof do
      begin
        Line := '';
        for I := 0 to ADateSet.FieldCount - 1 do
        begin
          if I > 0 then Line := Line + ';';
          Line := Line + ADateSet.Fields[I].AsString;
        end;
        SL.Add(Line);
        ADateSet.Next;
      end;
    finally
      ADateSet.EnableControls;
    end;

    SL.SaveToFile(AFileName, TEncoding.UTF8);
  finally
    SL.Free;
  end;

end;

procedure Tdm_Main.tb_CashRegisterBeforePost(DataSet: TDataSet);
begin
  tb_CashRegister.FieldByName('expensesTotal').AsCurrency := tb_CashRegister.FieldByName('expensesMeal' ).AsCurrency
                                                           + tb_CashRegister.FieldByName('expensesFuel' ).AsCurrency
                                                           + tb_CashRegister.FieldByName('expensesDaily').AsCurrency
                                                           + tb_CashRegister.FieldByName('expensesOther').AsCurrency;
end;

end.
