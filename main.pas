unit main;
{
	Demo - Programm for Barcode Component

   this demo runs with or without installing of the barcode
   component. (thanks to Igor Zakhrebetkov for the suggestion)

}



interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Barcode, ExtCtrls, StdCtrls, Menus;

type
  TForm1 = class(TForm)
	 Image1: TImage;
    Panel1: TPanel;
    Label1: TLabel;
	 Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Edit2: TEdit;
    Label4: TLabel;
    ComboBox2: TComboBox;
    CBCheckSum: TCheckBox;
    EditWidth: TEdit;
    Label5: TLabel;
    FontDialog1: TFontDialog;
    BtnFont: TButton;
    ComboBox3: TComboBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Print1: TMenuItem;
    Printform1: TMenuItem;
    SetupPrinter1: TMenuItem;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
	 procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
	 procedure ComboBox2Click(Sender: TObject);
    procedure CBCheckSumClick(Sender: TObject);
    procedure EditWidthEnter(Sender: TObject);
    procedure EditWidthExit(Sender: TObject);
    procedure Barcode1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure BtnFontClick(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure Printform1Click(Sender: TObject);
    procedure SetupPrinter1Click(Sender: TObject);
  private
	 { Private-Deklarationen }
    Barcode1 : TAsBarcode;

	 procedure print_demo(bc:TAsBarcode);


  public
	 { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses WinTypes, WinProcs, Printers, barcode2;

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
   {
   Create a barcode object.
   this object is freed when the form is going to destroyed, because it is owned
   by the form (self parameter)
   }
   Barcode1 := TAsBarcode.Create(self);
   Barcode1.Top := 50;
   Barcode1.Left := 30;
   Barcode1.Typ := bcCodePostNet;
   Barcode1.Modul := 2;
   Barcode1.Ratio := 2.0;
   Barcode1.Height := 50;

   Barcode1.OnChange := Self.Barcode1Change;

	ComboBox2.ItemIndex := integer(Barcode1.ShowText);
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
	{ Start Email Client }
	WinExec('start "mailto:shmia@bizerba.de?subject=Barcode component"',
		SW_HIDE);
end;


procedure TForm1.ComboBox1Click(Sender: TObject);
begin
  Barcode1.Typ := TBarcodeType(ComboBox1.ItemIndex);
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
	try
		Barcode1.Angle := StrToFloat(Edit2.Text);
	except
		Barcode1.Angle := 0.0;
	end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	Barcode1.Top  := Y;
	Barcode1.Left := X;
end;

procedure TForm1.ComboBox2Click(Sender: TObject);
begin
	Barcode1.ShowText := TBarcodeOption(ComboBox2.ItemIndex);
end;

procedure TForm1.CBCheckSumClick(Sender: TObject);
begin
	Barcode1.Checksum := CBCheckSum.Checked;
end;


procedure TForm1.print_demo(bc:TAsBarcode);
var
   tmpbarcode : TAsBarcode;
begin

   { create a temp barcode object, because we want to change some
     properties
     }
   tmpbarcode := TAsBarcode.Create(nil);
   { copy the object }
   tmpbarcode.Assign(bc);

   try
      with printer do
      begin
         BeginDoc;

         Canvas.TextOut(10, 10, 'Barcode Printing Demo '+DateTimeToStr(Now));

         { Height of barcode: 40mm }
         tmpbarcode.Height := ConvertMmToPixelsY(40.0);
         tmpbarcode.Height := ConvertInchToPixelsY(1.5);


         { Modulwidth: 0.5mm }
         tmpbarcode.Modul  := ConvertMmToPixelsX(0.5);

         tmpbarcode.Top    := ConvertMmToPixelsY(100.0);
         tmpbarcode.Left   := ConvertMmToPixelsX(35.0);

         tmpbarcode.DrawBarcode(Canvas);

         EndDoc;
      end;
   finally
      tmpbarcode.Free;
   end;
end;




procedure TForm1.EditWidthEnter(Sender: TObject);
begin
	EditWidth.Text := IntToStr(Barcode1.Width);
end;

procedure TForm1.EditWidthExit(Sender: TObject);
begin
	Barcode1.Width := StrToInt(EditWidth.Text);
	EditWidth.Text := IntToStr(Barcode1.Width);
end;

procedure TForm1.Barcode1Change(Sender: TObject);
begin
   Image1.Picture := nil;
	Barcode1.DrawBarcode(Image1.Canvas);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
   Barcode1.Text := Edit1.Text;
end;

procedure TForm1.BtnFontClick(Sender: TObject);
begin
   with FontDialog1 do
   begin
      Font := Barcode1.ShowTextFont;
      if Execute then
         Barcode1.ShowTextFont := Font;
   end;
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
   Barcode1.ShowTextPosition := TShowTextPosition(ComboBox3.ItemIndex);
end;

procedure TForm1.Print1Click(Sender: TObject);
begin
	print_demo(Barcode1);
end;

procedure TForm1.Printform1Click(Sender: TObject);
begin
	Print;
end;

procedure TForm1.SetupPrinter1Click(Sender: TObject);
begin
   PrinterSetupDialog1.Execute;
end;

end.
