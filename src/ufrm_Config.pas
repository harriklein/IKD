unit ufrm_Config;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Controls.Presentation, FMX.Layouts, System.IniFiles;

type
  Tfrm_Config = class(TFrame)
    vScroll_RentStart: TVertScrollBox;
    layout_RentStart: TFlowLayout;
    layout_RentStart1: TLayout;
    lbl_Printers: TLabel;
    btn_Save: TButton;
    cbBox_Printers: TComboBox;
    btn_Test: TButton;
    Button1: TButton;
    Button2: TButton;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure prepare();
    procedure print_receipt();
  end;

implementation

{$R *.fmx}

uses unt_Printer, unt_DeviceUtils;

{ Tfrm_Config }

procedure Tfrm_Config.btn_SaveClick(Sender: TObject);
var
  iniCFG : TiniFile;
begin
 if (cbBox_Printers.Selected <> nil) and (cbBox_Printers.Selected.Text <> '') then
  begin
    PRINTER_NAME := cbBox_Printers.Selected.Text;
    iniCFG := TIniFile.Create(GetPath('IKDAppConfig.ini'));
    try
      iniCFG.WriteString('CLIENT', 'Printer'  , PRINTER_NAME);
    finally
      iniCFG.Free;
    end;
    if BTConnectPrinter(cbBox_Printers.Selected.Text) then
      begin
        ShowMessage('Dispositivo conectado corretamente: ' + PRINTER_NAME);
      end
    else
      begin
        ShowMessage('Não é possivel conectar com o dispositivo selecionado.');
      end;
  end
  else
  begin
    ShowMessage('Selecione um dispositivo.');
  end;
end;

procedure Tfrm_Config.btn_TestClick(Sender: TObject);
begin
  print_receipt();
end;

procedure Tfrm_Config.Button1Click(Sender: TObject);
begin
  BTSendData(  EP_PRINT_LINE_FEED );

end;

procedure Tfrm_Config.Button2Click(Sender: TObject);
begin
   BTSendData(  EP_LF );
end;

procedure Tfrm_Config.prepare;
begin
  BTDeviceList( cbBox_Printers.Items );

  cbBox_Printers.ItemIndex := cbBox_Printers.Items.IndexOf( PRINTER_NAME );
end;

procedure Tfrm_Config.print_receipt;
var
  xLineSeq, xLineObs, xLineDate, XLineValue, xLineMin : String;
begin
  xLineSeq   := '00' + '     ' + '1';
  xLineDate  := 'Data  : '     + FormatDateTime( 'dd/MM/yyyy HH:mm', Now );
  XLineValue := 'Valor : R$ '  +       IntToStr( 99         ) + ',00';
  xLineMin   := 'Tempo : '     +       IntToStr( 35         ) + ' min';
  xLineObs   := 'R$ 10,00 a cada 10 min excedente';



  BTSendData( EP_INITIALIZE_PRINTER           );
  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH ));
  BTSendData( 'PEDALINHOS KLEIN'      + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));
  BTSendData( 'RECIBO' + EP_LF + EP_LF );
  BTSendData( '   Senha     Pedalinho/Boat' + EP_PRINT );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_DOUBLE_WIDTH OR EP_MODE_DOUBLE_HEIGHT OR EP_MODE_EMPHASIZED ));
//BTSendData( '01     G01' + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT  );
  BTSendData( xLineSeq + EP_PRINT_RETURN_STANDARD_MODE + EP_PRINT  );

  BTSendData( EP_SELECT_PRINTER_MODE_ + CHR( EP_MODE_STANDARD   ));
  BTSendData( EP_SELECT_JUSTIFICATION_LEFT  );

  BTSendData( EP_LF );
//BTSendData( 'Data  : 01/01/2019 13:00' + EP_PRINT );
//BTSendData( 'Valor : R$ 30,00'         + EP_PRINT );
//BTSendData( 'Tempo : 30 min'           + EP_PRINT );
  BTSendData( xLineDate  + EP_PRINT );
  BTSendData( XLineValue + EP_PRINT );
  BTSendData( xLineMin   + EP_PRINT );
  BTSendData( EP_LF );

  BTSendData( EP_SELECT_JUSTIFICATION_CENTER  );
//BTSendData( 'R$ 10,00 a cada 10 min excedente' + EP_PRINT );
  BTSendData( xLineObs + EP_PRINT );

  BTSendData(  EP_LF + EP_LF + EP_LF + EP_LF + EP_LF + EP_LF );


end;


end.
