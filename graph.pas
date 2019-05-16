unit graph;

interface
uses
 SysUtils, Graphics;

// рисование линии
procedure NLine(c:Tcanvas; x1, y1, x2, y2:word);
// очистка прямоугольной облости
procedure ClearWin(c:Tcanvas; x1, y1, x2, y2:word; CP,CB:tcolor);
// рисование стрелки True влево False вправо
procedure StrelkaLR(c:Tcanvas; x,y:word; b:boolean);
// рисование стрелки TRUE вверх False вниз
procedure StrelkaTB(c:Tcanvas; x,y:word; b:boolean);
// рисование знака диаметра и размера диаметра
procedure diametr(c:Tcanvas; x,y:word; diam:string);

// прорисовка силоизверителя
procedure Paint_Siloizmeritel(can:Tcanvas; Sx,Sy:word; Sr:byte; K:integer;  d:string);
// прорисовка стрелки силоизмерителя
procedure Paint_Strelka(can:Tcanvas; sx,sy:word; sr:byte; s1:real; s2:integer; col:tcolor);

{ прорисовка осей и сетки графика
 Х Y координаты точки 0,0 графика
 lx ly длина оси X и Y

    ^
    |
    |
Ly  |
    |
    |
    |
    |    A1   A2   A3
  --+----+----+----+----+->
x,y |    |<dx>|

 A1:=1*kx;  A2:=2*kx ... Akxd:=kxd*kx
 }
procedure PaintXOY(c:tcanvas; x,y, lx,ly:word; dx,dy:byte; kx,ky, kxd,kyd:byte; b:boolean);

// округление чисел
function NRound(r:real; n:byte):real;
{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}
implementation
//=========================================================================
procedure NLine(c:Tcanvas; x1, y1, x2, y2:word);
begin
    c.moveto(x1,  y1);
    c.lineto(x2,  y2);
end;
//=========================================================================
procedure StrelkaLR(c:Tcanvas; x,y:word; b:boolean);
var i:integer;
begin
    if b then i:=1 else i:=-1;
    nline(c, x+5*i, y-5, x, y);
    c.lineto(x+6*i, y+6);
end;
//=========================================================================
procedure StrelkaTB(c:Tcanvas; x,y:word; b:boolean);
var i:integer;
begin
    if b then i:=1 else i:=-1;
    nline(c, x-5, y+5*i, x, y);
    c.lineto(x+6, y+6*i);
end;
//=========================================================================
procedure diametr(c:Tcanvas; x,y:word; diam:string);
begin
    c.ellipse(x-8, y-8, x-2, y-2); // знак диаметра
    nline(c, x-3, y-10, x-8, y);
    c.textout(x, y-12, diam);
end;
//=========================================================================
procedure Paint_Siloizmeritel(can:Tcanvas; Sx,Sy:word; Sr:byte; K:integer; d:string);
var i,j:integer;
    k1:integer;
    st:string;
    r:real;
begin
  with can do begin
    pen.Color:=clBlue;
    pen.Style:=pssolid;
    brush.style:=bsclear;
    ellipse(Sx-sr, sy-sr, sx+sr, sy+sr);
    ellipse(Sx-sr-1, sy-sr-1, sx+sr+1, sy+sr+1);
    pen.Color:=clblack;
    k1:=round(k/10);
    j:=0;
    for i:=0 to 50 do begin
      if i/5=round(i/5) then begin
        textout(round(sin((i+5)*6*pi/180)*(sr+13))+sx-7,
                round(cos((i+5)*6*pi/180)*(sr+10))+sy-7,
                inttostr(k-(j*k1)));
        moveto(round(sin((i+5)*6*pi/180)*(sr-3))+sx, round(cos((i+5)*6*pi/180)*(sr-3))+sy);
        lineto(round(sin((i+5)*6*pi/180)*(sr+2))+sx, round(cos((i+5)*6*pi/180)*(sr+2))+sy);
        inc(j);
      end else
        pixels[round(sin((i+5)*6*pi/180)*(sr-3))+sx, round(cos((i+5)*6*pi/180)*(sr-3))+sy]:=clblack;
    end;
    r:=k/50;
    st:=floattostr(r);
    i:=pos(',', st);
    if i<>0 then st:=copy(st, 1, i+1);
    textout(sx-30, sy+sr+7, '1дел = '+st+d);
  end;
end;
//=========================================================================
procedure Paint_Strelka(can:Tcanvas; sx,sy:word; sr:byte; s1:real; s2:integer; col:tcolor);
var s3:real;
begin
  with can do begin
     pen.Color:=col;
     pen.Style:=pssolid;
     ellipse(Sx-2, Sy-2, Sx+3, Sy+3);
     moveto(Sx, Sy);
     s3:=(300/s2)*s1;
     lineto(round(sin((330-(s3))*pi/180)*(sr-10))+sx, round(cos((330-(s3))*pi/180)*(sr-10))+sy) ;
  end;
end;
//=========================================================================
procedure ClearWin(c:Tcanvas; x1, y1, x2, y2:word; CP,CB:tcolor);
begin
  with c do begin
     pen.color:=CP;
     brush.color:=CB;
     pen.style:=pssolid;
     brush.style:=bssolid;
     rectangle(x1, y1, x2, y2);
  end;
end;
//=========================================================================
procedure PaintXOY(c:tcanvas; x,y, lx,ly:word; dx,dy:byte; kx,ky, kxd,kyd:byte; b:boolean);
var i:integer;
    st:string;
begin
  with c do begin
    pen.color:=clblue;
    pen.Style:=pssolid;
    brush.Color:=clbtnface;
    NLine(c, x-10, y, x+lx+5, y);
    NLine(c, x, y+10, x, y-ly-5);
    textout(x-10, y+3, '0');
    pen.color:=clgray;
    pen.Style:=psdot;
    if b then st:='-' else st:='';
 {X}for i:=1 to kxd do begin
        nline(c, x+(i*dx), y+3, x+(i*dx), y-ly);
        textout(x+(i*dx)-5, y+5, st+inttostr(i*kx));
    end;
 {Y}for i:=1 to kyd do begin
        nline(c, x-3, y-(i*dy), x+lx, y-(i*dy));
        textout(x-23, y-(i*dy)-5, inttostr(i*ky));
    end;
  end;
end;
//=========================================================================
function NRound(r:real; n:byte):real;
var z:integer;
begin
  if r>0 then begin
     z:=round(exp(n*ln(10)));
     r:=r*z;
     r:=round(r);
     Result := r/z;
  end
  else Result := 0;
end;
//=======================================================================
end.

