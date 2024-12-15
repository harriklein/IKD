unit ufrm_Default;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ListBox, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo;

type
  Tfrm_Default = class(TFrame)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure prepare;
  end;

implementation

{$R *.fmx}

uses ufrm_Message;


{ Tfrm_Default }

procedure Tfrm_Default.Button1Click(Sender: TObject);
begin
   ShowAlert('test');
end;

procedure Tfrm_Default.prepare;
begin

end;

end.
