unit Space2D;

interface

uses Windows;

function Rotate2D(p:TPoint; alpha:double): TPoint;
function Translate2D(a, b:TPoint): TPoint;
procedure Rotate2Darray(var p:array of TPoint; alpha:double);
procedure Translate2Darray(var p:array of TPoint; shift:TPoint);


implementation

uses Math;

{
  Rotate a Point by Angle 'alpha'
}
function Rotate2D(p:TPoint; alpha:double): TPoint;
var
  sinus, cosinus : Extended;
begin
(*
  sinus   := sin(alpha);
  cosinus := cos(alpha);
*)
  { twice as fast than calc sin() and cos() }
  SinCos(alpha, sinus, cosinus);

  result.x := Round(p.x*cosinus + p.y*sinus);
  result.y := Round(-p.x*sinus + p.y*cosinus);
end;

{
  Move Point "a" by Vector "b"
}
function Translate2D(a, b:TPoint): TPoint;
begin
  result.x := a.x + b.x;
  result.y := a.y + b.y;
end;

procedure Rotate2Darray(var p:array of TPoint; alpha:double);
var
   i : Integer;
begin
   for i:=Low(p) to High(p) do
      p[i] := Rotate2D(p[i], alpha);
end;

procedure Translate2Darray(var p:array of TPoint; shift:TPoint);
var
   i : Integer;
begin
   for i:=Low(p) to High(p) do
      p[i] := Translate2D(p[i], shift);
end;




end.
