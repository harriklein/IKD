object dm_Main: Tdm_Main
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object tb_UserLogin: TFDMemTable
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    IndexFieldNames = 'Username'
    FetchOptions.AssignedValues = [evMode, evRowsetSize]
    FetchOptions.Mode = fmAll
    FetchOptions.RowsetSize = 9999
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode, rvStorePrettyPrint]
    ResourceOptions.SilentMode = True
    ResourceOptions.PersistentFileName = 'UserLogin.db'
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 56
    Top = 32
    object tb_UserLoginid: TStringField
      FieldName = 'id'
      Size = 64
    end
    object tb_UserLoginUsername: TStringField
      FieldName = 'Username'
      Size = 100
    end
    object tb_UserLoginPassword: TStringField
      FieldName = 'Password'
      Size = 50
    end
    object tb_UserLoginName: TStringField
      FieldName = 'Name'
      Size = 100
    end
    object tb_UserLoginLastLogin: TDateTimeField
      FieldName = 'LastLogin'
    end
    object tb_UserLoginLevel: TStringField
      FieldName = 'Level'
      Size = 100
    end
  end
  object tb_User: TFDMemTable
    CachedUpdates = True
    IndexFieldNames = 'Name'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode, rvStorePrettyPrint]
    ResourceOptions.SilentMode = True
    ResourceOptions.PersistentFileName = 'User.db'
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 96
    object tb_Userid: TFDAutoIncField
      FieldName = 'id'
    end
    object tb_UserActive: TBooleanField
      FieldName = 'Active'
    end
    object tb_UserLevel: TLongWordField
      FieldName = 'Level'
    end
    object tb_UserUsername: TStringField
      FieldName = 'Username'
      Size = 100
    end
    object tb_UserPassword: TStringField
      FieldName = 'Password'
      Size = 64
    end
    object tb_UserResetPassword: TBooleanField
      FieldName = 'ResetPassword'
    end
    object tb_UserName: TStringField
      FieldName = 'Name'
      Size = 100
    end
  end
  object tb_Boat: TFDMemTable
    CachedUpdates = True
    IndexFieldNames = 'Number'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.SilentMode = True
    ResourceOptions.PersistentFileName = 'Boat.db'
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 168
    object tb_Boatid: TFDAutoIncField
      FieldName = 'id'
    end
    object tb_BoatNumber: TStringField
      FieldName = 'Number'
      Size = 3
    end
    object tb_BoatActive: TBooleanField
      FieldName = 'Active'
    end
    object tb_BoatRented: TBooleanField
      FieldName = 'Rented'
    end
    object tb_BoatRentedAt: TDateTimeField
      FieldName = 'RentedAt'
    end
    object tb_BoatAdvancedPaymentValue: TLongWordField
      FieldName = 'AdvancedPaymentValue'
    end
    object tb_BoatAdvancedPaymentMinutes: TLongWordField
      FieldName = 'AdvancedPaymentMinutes'
    end
  end
  object tb_Rental: TFDMemTable
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    IndexFieldNames = 'RentedAt'
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
    Left = 56
    Top = 232
    object FDAutoIncField1: TFDAutoIncField
      FieldName = 'id'
    end
    object tb_RentalBoat_id: TLongWordField
      FieldName = 'Boat_id'
    end
    object tb_RentalRentedAt: TDateTimeField
      FieldName = 'RentedAt'
    end
    object tb_RentalRentFinishedAt: TDateTimeField
      FieldName = 'RentFinishedAt'
    end
    object tb_RentalAdvancedPaymentValue: TLongWordField
      FieldName = 'AdvancedPaymentValue'
    end
    object tb_RentalAdvancedPaymentMinutes: TLongWordField
      FieldName = 'AdvancedPaymentMinutes'
    end
    object tb_RentalCalculedPaymentValue: TLongWordField
      FieldName = 'CalculedPaymentValue'
    end
    object tb_RentalCalculedPaymentMinutes: TLongWordField
      FieldName = 'CalculedPaymentMinutes'
    end
    object tb_RentalPaymentChanged: TBooleanField
      FieldName = 'PaymentChanged'
    end
    object tb_RentalPaymentValue: TLongWordField
      FieldName = 'PaymentValue'
    end
    object tb_RentalPaymentMinutes: TLongWordField
      FieldName = 'PaymentMinutes'
    end
    object tb_RentalNumber: TStringField
      FieldName = 'Number'
      ProviderFlags = []
      Size = 3
    end
    object tb_RentalTotal: TAggregateField
      FieldName = 'Total'
      ProviderFlags = []
      Active = True
      DisplayName = ''
      Expression = 'Sum(PaymentValue)'
    end
  end
  object FDStanStorageBinLink: TFDStanStorageBinLink
    Left = 184
    Top = 32
  end
end
