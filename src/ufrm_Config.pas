unit ufrm_Config;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Controls.Presentation, FMX.Layouts, System.IniFiles, System.IOUtils,

{$IFDEF ANDROID}
//    FMX.Helpers.Android,  FMX.DialogService,
//    Androidapi.JNI.GraphicsContentViewText, AndroidApi.Helpers,
//    Androidapi.JNI.Telephony, Androidapi.JNI.Provider, Androidapi.JNIBridge,
//    Androidapi.JNI.JavaTypes, Androidapi.JNI.OS, Androidapi.JNI.App,
{$ENDIF}

  System.Permissions;

type
  Tfrm_Config = class(TFrame)
    vScroll_RentStart: TVertScrollBox;
    layout_RentStart: TFlowLayout;
    layout_RentStart1: TLayout;
    btn_EraseDBBoat: TButton;
    switch_ClockInSeconds: TSwitch;
    Label2: TLabel;
    btn_ConfigSave: TButton;
    btn_Export: TButton;
    btn_ClearValidated: TButton;
    btn_EraseDBPoS: TButton;
    btn_EraseDBCashRegister: TButton;
    btn_EraseDBRental: TButton;
    procedure btn_EraseDBBoatClick(Sender: TObject);
    procedure btn_ConfigSaveClick(Sender: TObject);
    procedure btn_ExportClick(Sender: TObject);
    procedure btn_ClearValidatedClick(Sender: TObject);
    procedure btn_EraseDBPoSClick(Sender: TObject);
    procedure btn_EraseDBCashRegisterClick(Sender: TObject);
    procedure btn_EraseDBRentalClick(Sender: TObject);
  private const
    LOCATION_PERMISSION = 'android.permission.ACCESS_FINE_LOCATION';
    BLUETOOTH_SCAN_PERMISSION = 'android.permission.BLUETOOTH_SCAN';
    BLUETOOTH_CONNECT_PERMISSION = 'android.permission.BLUETOOTH_CONNECT';
  private
    { Private declarations }
  public
    { Public declarations }
    procedure prepare();
  end;

implementation

{$R *.fmx}

uses unt_Printer, unt_DeviceUtils, ufrm_Main, udm_Main, FMX.DialogService;

{ Tfrm_Config }

procedure Tfrm_Config.prepare;
begin
  switch_ClockInSeconds.IsChecked := CLOCK_IN_SECONDS;
end;

procedure Tfrm_Config.btn_ClearValidatedClick(Sender: TObject);
begin
  TDialogService.MessageDialog( 'Confirmar a limpeza dos registros de caixa validados e dos aluguéis correspondentes?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  begin
                                    if AResult = mrYes then
                                      begin
                                          dm_Main.ClearValidated;
                                          TDialogService.ShowMessage('Limpeza finalizada!');
                                      end
                                  end);

end;

procedure Tfrm_Config.btn_ConfigSaveClick(Sender: TObject);
var
  LIniConfig : TiniFile;
begin
  LIniConfig := TIniFile.Create(GetPath('IKDAppConfig.ini'));
  try
    LIniConfig.WriteBool  ('CLIENT', 'ClockSeconds'  , switch_ClockInSeconds.IsChecked);
    CLOCK_IN_SECONDS := switch_ClockInSeconds.IsChecked;
    TDialogService.ShowMessage('Configuração de tempo salva.');
  finally
    LIniConfig.Free;
  end;
end;

procedure Tfrm_Config.btn_EraseDBBoatClick(Sender: TObject);
begin
  TDialogService.MessageDialog( 'ATENÇÃO! Excluir toda a tabela de Pedalinhos?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  begin
                                    if AResult = mrYes then
                                      begin
                                          dm_Main.EraseDBBoat;
                                          TDialogService.ShowMessage('Tabela excluída. Favor reiniciar o app.');
                                      end
                                  end);


end;


procedure Tfrm_Config.btn_ExportClick(Sender: TObject);
var
  LPathMain: String;
  LPath     : String;
begin
  LPathMain := TPath.Combine(TPath.GetSharedDocumentsPath, 'IKD');
  ForceDirectories(LPathMain);

  LPath := TPath.Combine(LPathMain, FormatDateTime('yyymmddhhmmss', Now));


  dm_Main.DataExport(dm_Main.tb_Boat        , LPath + '_boat.csv');
  dm_Main.DataExport(dm_Main.tb_PoS         , LPath + '_pos.csv');
  dm_Main.DataExport(dm_Main.tb_CashRegister, LPath + '_cashRegister.csv');
  dm_Main.DataExport(dm_Main.tb_Rental      , LPath + '_rental.csv');

  TDialogService.ShowMessage('Exportado em ' + LPathMain);
end;

procedure Tfrm_Config.btn_EraseDBPoSClick(Sender: TObject);
begin
  TDialogService.MessageDialog( 'ATENÇÃO! Excluir toda a tabela de Pontos de Vendas?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  begin
                                    if AResult = mrYes then
                                      begin
                                          dm_Main.EraseDBPoS;
                                          TDialogService.ShowMessage('Tabela excluída. Favor reiniciar o app.');
                                      end
                                  end);
end;

procedure Tfrm_Config.btn_EraseDBCashRegisterClick(Sender: TObject);
begin
  TDialogService.MessageDialog( 'ATENÇÃO! Excluir toda a tabela de Caixas?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  begin
                                    if AResult = mrYes then
                                      begin
                                          dm_Main.EraseDBCashRegister;
                                          TDialogService.ShowMessage('Tabela excluída. Favor reiniciar o app.');
                                      end
                                  end);
end;

procedure Tfrm_Config.btn_EraseDBRentalClick(Sender: TObject);
begin
  TDialogService.MessageDialog( 'ATENÇÃO! Excluir toda a tabela de Alugueis?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbCancel, 0,
                                procedure(const AResult: TModalResult)
                                  begin
                                    if AResult = mrYes then
                                      begin
                                          dm_Main.EraseDBRental;
                                          TDialogService.ShowMessage('Tabela excluída. Favor reiniciar o app.');
                                      end
                                  end);
end;

//******************************************************************************



end.
