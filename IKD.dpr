program IKD;

uses
  System.StartUpCopy,
  FMX.Forms,
  unt_Main in 'src\unt_Main.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
