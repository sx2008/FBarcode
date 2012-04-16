program bctest;

uses
  Forms,
  main in 'main.pas' {Form1},
  Barcode2 in 'Barcode2.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
