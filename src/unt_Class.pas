unit unt_Class;

interface

uses System.Classes;

type
  TComboBoxItemGuid = class
  public
    Value: TGuid;
    constructor Create(AOwner: TComponent; AGuid: TGuid);
    destructor Destroy;
  end;

  TComboBoxItemGuid3 = class
  public
    Value: TGuid;
    constructor Create(AOwner: TComponent; AGuid: TGuid);
    destructor Destroy;
  end;

implementation

{ TComboBoxItem }

constructor TComboBoxItemGuid.Create(AOwner: TComponent; AGuid: TGuid);
begin
  inherited Create;  // Call the ancestor constructor
  Value := AGuid;
end;

destructor TComboBoxItemGuid.Destroy;
begin
    inherited Destroy;
end;


constructor TComboBoxItemGuid3.Create(AOwner: TComponent; AGuid: TGuid);
begin
  inherited Create;  // Call the ancestor constructor
  Value := AGuid;
end;

destructor TComboBoxItemGuid3.Destroy;
begin
    inherited Destroy;
end;

end.
