unit qrBarcode;
//QMARK - Removed the QuestionMark copyright and added a comment
//        like the one in barcode.pas. You can have this code
//        to distribute freely with your fbarcode files, as if
//        you had originally wrote it. A mention of my name is
//        always nice though.

{
QuickReport Barcode Component
Version 1.19 (27.09.2000)
Copyright 2000 Andreas Schmidt and friends

This file has a Barcode component for QuickReports. It relies
on the version 1.19 (or newer) of the freeware TAsBarcode
component by Andreas Schmidt and friends.

Originally written for Delphi 5 by Samuel J. Comstock.
may work in with Delphi 1/2/3/4/5
only tested in Delphi 5; better use Delphi 5 (or higher)

Freeware
Feel free to distribute the component as
long as all files are unmodified and kept together.

I am not responsible for wrong barcodes.

bug-reports, enhancements:
mailto:shmia@bizerba.de or a_j_schmidt@rocketmail.com

please tell me wich version you are using, when mailing me.


get latest version from
http://members.tripod.de/AJSchmidt/index.html


See the comments in barcode.pas for more details.

}
//QMARK - End of change

interface

uses
  Classes, SysUtils, Graphics, Barcode, QRCTRLS;

type
  TQRAsBarcode = class(TQRImage)
  private
    FBarcode :TASBarcode;
    FIgnoreOnChange :Boolean;
    procedure FixupSize;
    procedure BarcodeToCanvas;
    procedure SetBarcode(const Value: TASBarcode);
    function GetBarcode: TASBarcode;
    function GetAngle: double;
    function GetCheckSum: boolean;
    function GetCheckSumMethod: TCheckSumMethod;
    function GetColor: TColor;
    function GetColorBar: TColor;
    function GetModul: integer;
    function GetRatio: double;
    function GetShowText: TBarcodeOption;
    function GetText: string;
    function GetTyp: TBarcodeType;
    procedure SetAngle(const Value: double);
    procedure SetCheckSum(const Value: boolean);
    procedure SetCheckSumMethod(const Value: TCheckSumMethod);
    procedure SetColor(const Value: TColor);
    procedure SetColorBar(const Value: TColor);
    procedure SetModul(const Value: integer);
    procedure SetRatio(const Value: double);
    procedure SetShowText(const Value: TBarcodeOption);
    procedure SetText(const Value: string);
    procedure SetTyp(const Value: TBarcodeType);
    function GetBarcodeHeight: Integer;
    function GetBarcodeWidth: Integer;
    procedure SetBarcodeHeight(const Value: Integer);
    procedure SetBarcodeWidth(const Value: Integer);
  protected
    procedure Loaded; override;
    procedure Resize; override;
    procedure OnBarcodeChange(Sender :TObject);
  public
    constructor Create(AOwner :TComponent); override;
//QMARK - Not needed anymore
//    destructor Destroy; override;
//QMARK - End of change
    property Barcode :TASBarcode read GetBarcode write SetBarcode;
  published
		property Angle :double read GetAngle write SetAngle;
    property BarcodeHeight :Integer read GetBarcodeHeight write SetBarcodeHeight;
    property BarcodeWidth :Integer read GetBarcodeWidth write SetBarcodeWidth;
		property Checksum :boolean read GetCheckSum write SetCheckSum default FALSE;
		property CheckSumMethod :TCheckSumMethod read GetCheckSumMethod write SetCheckSumMethod default csmModulo10;
		property Color :TColor read GetColor write SetColor default clWhite;
		property ColorBar :TColor read GetColorBar write SetColorBar default clBlack;
		property Modul :integer read GetModul write SetModul;
		property Ratio :double read GetRatio write SetRatio;
		property ShowText :TBarcodeOption read GetShowText write SetShowText default bcoNone;
		property Text :string read GetText write SetText;
		property Typ :TBarcodeType read GetTyp write SetTyp default bcCode_2_5_interleaved;
    //inherited properties
    property Picture stored False;
  end;

procedure Register;

implementation

uses
  Math;

procedure Register;
begin
//QMARK - Place it with the TAsBarcode component.
//  RegisterComponents('QMark',[TQRAsBarcode]);
  RegisterComponents('Extras',[TQRAsBarcode]);
//QMARK - End of change
end;

{ TQRAsBarcode }

procedure TQRAsBarcode.BarcodeToCanvas;
begin
  //Clear the existing canvas
  Picture.Assign(nil);
  //Draw the barCode if there is one
  FixupSize;
  Barcode.DrawBarcode(Self.Canvas);
end;

constructor TQRAsBarcode.Create(AOwner :TComponent);
begin
  inherited;
//QMARK - Nice changes. I just removed the comments.
{
// AJS
//  FBarcode := TASBarcode.Create(nil);
  FBarcode := TASBarcode.Create(Self);
// AJS

  FBarcode.OnChange := OnBarcodeChange;
// AJS
  FBarcode.Height := 50; // default
// AJS
}
  FBarcode := TASBarcode.Create(Self);
  FBarcode.OnChange := OnBarcodeChange;
  FBarcode.Height := 50; // default
//QMARK - End of change
end;

//QMARK - Not needed anymore
{
destructor TQRAsBarcode.Destroy;
begin
// AJS
//  FreeAndNil(FBarcode);
//  FBarcode will be destroyed because the Owner (self)
//  is going to be destroyed.
// AJS

  inherited;
end;
}
//QMARK - End of change

procedure TQRAsBarcode.FixupSize;
begin
  if (not (csLoading in ComponentState))then
  begin
    FIgnoreOnChange := True;
    try
      //Adjust the barcode width
      Height := Barcode.CanvasHeight;
      Width := Barcode.CanvasWidth;
    finally
      FIgnoreOnChange := False;
    end;
  end;
end;

function TQRAsBarcode.GetAngle: double;
begin
  Result := FBarcode.Angle;
end;

function TQRAsBarcode.GetBarcode: TASBarcode;
begin
  Result := FBarcode;
end;

function TQRAsBarcode.GetBarcodeHeight: Integer;
begin
  Result := Barcode.Height;
end;

function TQRAsBarcode.GetBarcodeWidth: Integer;
begin
  Result := Barcode.Width;
end;

function TQRAsBarcode.GetCheckSum: boolean;
begin
  Result := Barcode.CheckSum;
end;

function TQRAsBarcode.GetCheckSumMethod: TCheckSumMethod;
begin
  Result := Barcode.CheckSumMethod;
end;

function TQRAsBarcode.GetColor: TColor;
begin
  Result := Barcode.Color;
end;

function TQRAsBarcode.GetColorBar: TColor;
begin
  Result := Barcode.ColorBar;
end;

function TQRAsBarcode.GetModul: integer;
begin
  Result := Barcode.Modul;
end;

function TQRAsBarcode.GetRatio: double;
begin
  Result := Barcode.Ratio;
end;

function TQRAsBarcode.GetShowText: TBarcodeOption;
begin
  Result := Barcode.ShowText;
end;

function TQRAsBarcode.GetText: string;
begin
  Result := Barcode.Text;
end;

function TQRAsBarcode.GetTyp: TBarcodeType;
begin
  Result := Barcode.Typ;
end;

procedure TQRAsBarcode.Loaded;
begin
  inherited;
  BarcodeToCanvas;
end;

procedure TQRAsBarcode.OnBarcodeChange(Sender: TObject);
begin
  if FIgnoreOnChange then EXIT;

  if (not (csLoading in ComponentState)) then
    BarcodeToCanvas;
end;

procedure TQRAsBarcode.Resize;
begin
  inherited;
  FixupSize;
end;

procedure TQRAsBarcode.SetAngle(const Value: double);
begin
  Barcode.Angle := Value;
end;

procedure TQRAsBarcode.SetBarcode(const Value: TASBarcode);
begin
  FBarcode.Assign(Value);
end;

procedure TQRAsBarcode.SetBarcodeHeight(const Value: Integer);
begin
  Barcode.Height := Value;
end;

procedure TQRAsBarcode.SetBarcodeWidth(const Value: Integer);
begin
  Barcode.Width := Value;
end;

procedure TQRAsBarcode.SetCheckSum(const Value: boolean);
begin
  Barcode.CheckSum := Value;
end;

procedure TQRAsBarcode.SetCheckSumMethod(const Value: TCheckSumMethod);
begin
  Barcode.CheckSumMethod := Value;
end;

procedure TQRAsBarcode.SetColor(const Value: TColor);
begin
  Barcode.Color := Value;
end;

procedure TQRAsBarcode.SetColorBar(const Value: TColor);
begin
  Barcode.ColorBar := Value;
end;

procedure TQRAsBarcode.SetModul(const Value: integer);
begin
  Barcode.Modul := Value;
end;

procedure TQRAsBarcode.SetRatio(const Value: double);
begin
  Barcode.Ratio := Value;
end;

procedure TQRAsBarcode.SetShowText(const Value: TBarcodeOption);
begin
  Barcode.ShowText := Value;
end;

procedure TQRAsBarcode.SetText(const Value: string);
begin
  Barcode.Text := Value;
end;

procedure TQRAsBarcode.SetTyp(const Value: TBarcodeType);
begin
  Barcode.Typ := Value;
end;

end.
