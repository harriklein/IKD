object dm_Main: Tdm_Main
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object tb_Boat: TFDMemTable
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    IndexFieldNames = 'number'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.SilentMode = True
    ResourceOptions.PersistentFileName = 'Boat.db'
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 40
    Top = 64
    object tb_Boatid: TGuidField
      FieldName = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object tb_Boatnumber: TStringField
      FieldName = 'number'
      Size = 3
    end
    object tb_Boatactive: TBooleanField
      FieldName = 'active'
    end
    object tb_Boatcolor: TLongWordField
      FieldName = 'color'
    end
    object tb_BoatposId: TGuidField
      FieldName = 'posId'
      Size = 38
    end
    object tb_BoatdefaultMinutes: TIntegerField
      FieldName = 'defaultMinutes'
    end
    object tb_BoatdefaultValue: TLongWordField
      FieldName = 'defaultValue'
    end
    object tb_BoatdefaultExtraMinutes: TLongWordField
      FieldName = 'defaultExtraMinutes'
    end
    object tb_BoatdefaultExtraValue: TLongWordField
      FieldName = 'defaultExtraValue'
    end
    object tb_Boatrented: TBooleanField
      FieldName = 'rented'
    end
    object tb_BoatcashRegisterId: TStringField
      FieldName = 'cashRegisterId'
      Size = 50
    end
    object tb_BoatrentedSince: TDateTimeField
      FieldName = 'rentedSince'
    end
    object tb_BoatrentalPausedAt: TDateTimeField
      FieldName = 'rentalPausedAt'
    end
    object tb_BoatrentalId: TGuidField
      FieldName = 'rentalId'
      Size = 38
    end
    object tb_BoatrentalExpectedMinutes: TLongWordField
      FieldName = 'rentalExpectedMinutes'
    end
    object tb_BoatrentalToleranceMinutes: TLongWordField
      FieldName = 'rentalToleranceMinutes'
    end
  end
  object tb_Rental: TFDMemTable
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    IndexFieldNames = 'id'
    Aggregates = <
      item
      end>
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.SilentMode = True
    ResourceOptions.PersistentFileName = 'Rental.db'
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 40
    Top = 256
    object tb_Rentalid: TGuidField
      FieldName = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object tb_RentalboatId: TGuidField
      FieldName = 'boatId'
      Size = 38
    end
    object tb_RentalboatNumber: TStringField
      FieldName = 'boatNumber'
      ProviderFlags = []
      Size = 3
    end
    object tb_RentalposId: TGuidField
      FieldName = 'posId'
      Size = 38
    end
    object tb_RentalposName: TStringField
      FieldName = 'posName'
      Size = 30
    end
    object tb_RentalcashRegisterDate: TDateField
      FieldName = 'cashRegisterDate'
    end
    object tb_RentalcashRegisterId: TStringField
      FieldName = 'cashRegisterId'
      Size = 50
    end
    object tb_RentalcashRegisterCount: TIntegerField
      FieldName = 'cashRegisterCount'
    end
    object tb_RentalstartAt: TDateTimeField
      FieldName = 'startAt'
    end
    object tb_RentalendAt: TDateTimeField
      FieldName = 'endAt'
    end
    object tb_RentalstartPayMinutes: TLongWordField
      FieldName = 'startPayMinutes'
    end
    object tb_RentalstartPayValue: TCurrencyField
      FieldName = 'startPayValue'
    end
    object tb_RentalstartPayMethod: TStringField
      FieldName = 'startPayMethod'
      Size = 50
    end
    object tb_RentalstartPayValueCard: TCurrencyField
      FieldName = 'startPayValueCard'
    end
    object tb_RentalstartPayValueCash: TCurrencyField
      FieldName = 'startPayValueCash'
    end
    object tb_RentalstartPayValuePix: TCurrencyField
      FieldName = 'startPayValuePix'
    end
    object tb_RentalstartPayValueOther: TCurrencyField
      FieldName = 'startPayValueOther'
    end
    object tb_RentalstartPayValueDiscount: TCurrencyField
      FieldName = 'startPayValueDiscount'
    end
    object tb_Rentalobs: TStringField
      FieldName = 'obs'
      Size = 2000
    end
    object tb_RentalextraMinutes: TLongWordField
      FieldName = 'extraMinutes'
    end
    object tb_RentalextraValue: TCurrencyField
      FieldName = 'extraValue'
    end
    object tb_RentalendPayMinutes: TLongWordField
      FieldName = 'endPayMinutes'
    end
    object tb_RentalendPayValue: TCurrencyField
      FieldName = 'endPayValue'
    end
    object tb_RentalendPayMethod: TStringField
      FieldName = 'endPayMethod'
      Size = 50
    end
    object tb_RentalendPayValueCard: TCurrencyField
      FieldName = 'endPayValueCard'
    end
    object tb_RentalendPayValueCash: TCurrencyField
      FieldName = 'endPayValueCash'
    end
    object tb_RentalendPayValuePix: TCurrencyField
      FieldName = 'endPayValuePix'
    end
    object tb_RentalendPayValueOther: TCurrencyField
      FieldName = 'endPayValueOther'
    end
    object tb_RentalendPayValueDiscount: TCurrencyField
      FieldName = 'endPayValueDiscount'
    end
  end
  object FDStanStorageBinLink: TFDStanStorageBinLink
    Left = 224
    Top = 64
  end
  object tb_PoS: TFDMemTable
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    IndexFieldNames = 'name'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.SilentMode = True
    ResourceOptions.PersistentFileName = 'PoS.db'
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 40
    Top = 128
    object tb_PoSid: TGuidField
      FieldName = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object tb_PoSactive: TBooleanField
      FieldName = 'active'
    end
    object tb_PoSname: TStringField
      DisplayWidth = 15
      FieldName = 'name'
      Size = 30
    end
  end
  object tb_CashRegister: TFDMemTable
    BeforePost = tb_CashRegisterBeforePost
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    IndexFieldNames = 'date'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.SilentMode = True
    ResourceOptions.PersistentFileName = 'CashRegister.db'
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 40
    Top = 192
    object tb_CashRegisterid: TStringField
      FieldName = 'id'
      Size = 50
    end
    object tb_CashRegisterdate: TDateField
      FieldName = 'date'
    end
    object tb_CashRegisterposId: TGuidField
      FieldName = 'posId'
      Size = 38
    end
    object tb_CashRegisteropen: TBooleanField
      FieldName = 'open'
    end
    object tb_CashRegistervalidated: TBooleanField
      FieldName = 'validated'
    end
    object tb_CashRegistervalidatedAt: TDateTimeField
      FieldName = 'validatedAt'
    end
    object tb_CashRegisterCount: TIntegerField
      FieldName = 'count'
    end
    object tb_CashRegisterinitialCash: TCurrencyField
      FieldName = 'initialCash'
    end
    object tb_CashRegisterexpensesTotal: TCurrencyField
      FieldName = 'expensesTotal'
    end
    object tb_CashRegisterexpensesFuel: TCurrencyField
      FieldName = 'expensesFuel'
    end
    object tb_CashRegisterexpensesMeal: TCurrencyField
      FieldName = 'expensesMeal'
    end
    object tb_CashRegisterexpensesDaily: TCurrencyField
      FieldName = 'expensesDaily'
    end
    object tb_CashRegisterexpensesOther: TCurrencyField
      FieldName = 'expensesOther'
    end
  end
end
