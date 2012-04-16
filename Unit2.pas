unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, Qrctrls, ExtCtrls, RxGIF, StdCtrls;

type
  TForm2 = class(TForm)
    QuickRep1: TQuickRep;
    Button1: TButton;
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRep1StartPage(Sender: TCustomQuickRep);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;

implementation

uses main;

{$R *.DFM}

procedure TForm2.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
//	Form1.Barcode1.DrawBarcode(QRImage1.Picture.Bitmap.Canvas);
end;

procedure TForm2.QuickRep1StartPage(Sender: TCustomQuickRep);
begin
//	QRImage1.Picture.Bitmap.Canvas.Rectangle(0,0,10,10);
	Form1.Barcode1.Top := 0;
	Form1.Barcode1.Left := 0;
	Form1.Barcode1.Angle := 0.0;

//	Form1.Barcode1.DrawBarcode(QRImage1.Picture.Bitmap.Canvas);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
//	QRImage1.Picture.Bitmap.Canvas.Rectangle(0,0,10,10);
	Form1.Barcode1.Top := 0;
	Form1.Barcode1.Left := 0;
	Form1.Barcode1.Angle := 0.0;

//	Form1.Barcode1.DrawBarcode(QRImage1.Picture.Bitmap.Canvas);
end;

end.
