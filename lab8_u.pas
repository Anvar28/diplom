unit lab8_u;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin, lab_8_const;
type
  Tlab_8 = class(TForm)
    l11: TLabel;
    l13: TLabel;
    l12: TLabel;
    l9: TLabel;
    l10: TLabel;
    Bevel1: TBevel;
    Button1: TButton;
    p1: TPanel;
    pb1: TPaintBox;
    p2: TPanel;
    p3: TPanel;
    l14: TLabel;
    Label7: TLabel;
    e1: TEdit;
    e2: TEdit;
    e3: TEdit;
    e4: TEdit;
    e5: TEdit;
    SB1: TSpinButton;
    SB2: TSpinButton;
    SB3: TSpinButton;
    SB4: TSpinButton;
    SB5: TSpinButton;
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    e6: TEdit;
    SB6: TSpinButton;
    btnBegin: TButton;
    l7: TLabel;
    l8: TLabel;
    btnProwerka: TButton;
    btnInform: TButton;
    SB: TScrollBox;
    l15: TLabel;
    e7: TEdit;
    e8: TEdit;
    l16: TLabel;
    l17: TLabel;
    e9: TEdit;
    l21: TLabel;
    l22: TLabel;
    e10: TEdit;
    l24: TLabel;
    e11: TEdit;
    l25: TLabel;
    l23: TLabel;
    e12: TEdit;
    e13: TEdit;
    l26: TLabel;
    l27: TLabel;
    e14: TEdit;
    l29: TLabel;
    e15: TEdit;
    l28: TLabel;
    e16: TEdit;
    l30: TLabel;
    e17: TEdit;
    l31: TLabel;
    l32: TLabel;
    e18: TEdit;
    l34: TLabel;
    e19: TEdit;
    l33: TLabel;
    e20: TEdit;
    l35: TLabel;
    e21: TEdit;
    l36: TLabel;
    e22: TEdit;
    e23: TEdit;
    l37: TLabel;
    e24: TEdit;
    l38: TLabel;
    e25: TEdit;
    l39: TLabel;
    e28: TEdit;
    l40: TLabel;
    l18: TLabel;
    l19: TLabel;
    l20: TLabel;
    e27: TEdit;
    e26: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure SBClick(Sender: TObject; Up:boolean);
    procedure SBDownClick(Sender: TObject);
    procedure SBUpClick(Sender: TObject);
    procedure pb1Paint(Sender: TObject);
    procedure btnBeginClick(Sender: TObject);
    procedure btnProwerkaClick(Sender: TObject);
    procedure btnInformClick(Sender: TObject);
    procedure eKeyPress(Sender: TObject; var Key: Char);
    procedure eExit(Sender: TObject);
  public
    z:array[1..4] of byte;
    m1:real;
    B:byte;
    procedure PaintReduktor;      // ðèñîâàíèå ðåäóêòîðà
  end;

var
  lab_8: Tlab_8;
implementation
uses osnowa_u, graph, lab_8_inform_u, lab_8_result_u;
{$R *.DFM}
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.Button1Click(Sender: TObject);
begin
  application.Helpcontext(800);
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  osnowa.ol8.Enabled:=true;
  action:=cafree;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.EditExit(Sender: TObject);
var s:string;
    i:byte;
    e:tedit;
begin
  e:=(sender as TEdit);
  s:=e.name;
  i:=strtoint(s[2]);
  if length(e.text)<>0 then begin
    try
     if strtofloat(e.text)<param[i].min then
        e.text:=floattostr(param[i].min);
     if strtofloat(e.text)>param[i].max then
        e.text:=floattostr(param[i].max);
    except
      showmessage('Ââåäåíî íå ÷èñëî. Ïîâòîðèòå ââîä.');
      e.text:=floattostr(param[i].min);
      e.SetFocus;
    end;
  end else e.text:=floattostr(param[i].min);
  case i of
    1..4 : begin
             z[i]:=strtoint(e.text);
             pb1.Refresh;
           end;
    5    : m1:=strtofloat(e.text);
    6    : b:=strtoint(e.text);
  end;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.FormCreate(Sender: TObject);
var i:byte;
begin
  for i:=1 to 6 do begin
      (FindComponent('E'+inttostr(i)) as tedit).text:=floattostr(param[i].min);
      case i of
        1..4 : z[i]:=round(param[i].min);
        5    : m1:=param[i].min;
        6    : B:=round(param[i].min);
      end;
  end;
  pb1.Canvas.brush.Style:=bsclear;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.EditKeyPress(Sender: TObject; var Key: Char);
   //——————————————————————————————————————————————————————————————————————
  procedure GoToNextEdit(sender:TObject; i:byte);
  begin
    case i of
      1..5 : (FindComponent('E'+inttostr(i+1)) as tedit).SetFocus;
      6    : btnBegin.SetFocus;
    end;
  end;

var s:string;
begin
  s:=(sender as TEdit).name;
  case s[2] of
    '1'..'4' : if key in [',','.'] then key:=#0;
    '5'..'6' : if key='.' then key:=',';
  end;
  if key=#13 then GoToNextEdit(sender, strtoint(s[2]));
  if not(key in ['0'..'9',',',#8]) then key:=#0;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.SBClick(Sender: TObject; Up:boolean);
var dx,r:real;
    s:string;
    j,i:byte;
    e:tedit;
begin
  s:=(sender as TSpinButton).name;
  j:=strtoint(s[3]);
  e:=(FindComponent('E'+inttostr(j)) as tedit);
  r:=strtofloat(e.text);
  dx:=param[j].d;
  if not Up then dx:=-dx;
  if ((r>param[j].min)and(dx<0))or((r<param[j].max)and(dx>0)) then begin
     r:=r+dx;
     s:=floattostr(r);
     i:=pos(',', s);
     if i<>0 then s:=copy(s, 1, i+1);
     e.text:=s;
     case j of
       1..4 : begin z[j]:=strtoint(e.text); pb1.Refresh; end;
       5    : m1:=strtofloat(e.text);
       6    : b:=strtoint(e.text);
     end;
  end;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.SBDownClick(Sender: TObject);
begin
  SBClick(sender, false);
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.SBUpClick(Sender: TObject);
begin
  SBClick(sender, true);
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.PaintReduktor;

  procedure Krestik(x,y:word);
  begin
    pb1.canvas.moveto(x-4,y-4);
    pb1.canvas.lineto(x+5,y+5);
    pb1.canvas.moveto(x-4,y+4);
    pb1.canvas.lineto(x+5,y-5);
  end;

var dz:array [1..4] of word;
    wz:array [1..3] of word;
    i:byte;
    x2,x1,y1:integer;
    x11,y11:integer;
begin
  for i:=1 to 4 do dz[i]:=round(z[i]*2);//round(round(m1*z[i])/mastab);
  wz[1]:=round(dz[1]/2);
  wz[2]:=dz[1]+round(dz[2]/2);
  wz[3]:=wz[2]+round(dz[3]/2+dz[4]/2);
  with pb1.canvas do begin
    pen.Color:=clblack;
    x1:=0;
    x2:=dz[1]+round(dz[2]/2)-round(dz[3]/2);
    if x2<0 then begin
       x1:=-x2;
       x2:=0;
    end;
    y1:=r1y+ho;
    brush.Color:=$00A6DBA9;
    rectangle(r1x+x1, y1, r1x+dz[1]+x1+1, y1+hk);
    brush.Color:=$00E2D994;
    rectangle(r1x+dz[1]+x1, y1, r1x+dz[1]+dz[2]+x1, y1+hk);
    brush.Color:=$00E294BF;
    rectangle(r1x+x2, y1+h1+hk, r1x+dz[3]+x2+1, y1+2*hk+h1);
    brush.Color:=$008181E0;
    rectangle(r1x+dz[3]+x2, y1+h1+hk, r1x+dz[3]+dz[4]+x2, y1+2*hk+h1);
    y11:=round(hk/2);
    x11:=r1x+x1;
    brush.Color:=clwhite;
    krestik(x11+wz[1], y1+y11);
    krestik(x11+wz[2], y1+y11);
    krestik(x11+wz[2], y1+h1+hk+y11);
    krestik(x11+wz[3], y1+h1+hk+y11);
    textout(x11+wz[1]+5, y1-13, 'Z1');
    textout(x11+wz[2]+5, y1-13, 'Z2');
    textout(x11+wz[2]+5, y1+h1+hk-13, 'Z3');
    textout(x11+wz[3]+5, y1+h1+hk-13, 'Z4');
    nline(pb1.canvas, r1x+dz[1]+x1+3, y1+2, r1x+dz[1]+x1+3, y1+hk-2);
    nline(pb1.canvas, r1x+dz[1]+x1+6, y1+2, r1x+dz[1]+x1+6, y1+hk-2);
    nline(pb1.canvas, r1x+dz[1]+x1+9, y1+2, r1x+dz[1]+x1+9, y1+hk-2);
    nline(pb1.canvas, r1x+dz[1]+x1-3, y1+2, r1x+dz[1]+x1-3, y1+hk-2);
    nline(pb1.canvas, r1x+dz[1]+x1-6, y1+2, r1x+dz[1]+x1-6, y1+hk-2);
    nline(pb1.canvas, r1x+dz[1]+x1-9, y1+2, r1x+dz[1]+x1-9, y1+hk-2);

    nline(pb1.canvas, r1x+dz[3]+x2+3, y1+h1+hk+2, r1x+dz[3]+x2+6, y1+h1+2*hk-2);
    nline(pb1.canvas, r1x+dz[3]+x2+6, y1+h1+hk+2, r1x+dz[3]+x2+9, y1+h1+2*hk-2);
    nline(pb1.canvas, r1x+dz[3]+x2+9, y1+h1+hk+2, r1x+dz[3]+x2+12, y1+h1+2*hk-2);
    nline(pb1.canvas, r1x+dz[3]+x2-3, y1+h1+hk+2, r1x+dz[3]+x2-6, y1+h1+2*hk-2);
    nline(pb1.canvas, r1x+dz[3]+x2-6, y1+h1+hk+2, r1x+dz[3]+x2-9, y1+h1+2*hk-2);
    nline(pb1.canvas, r1x+dz[3]+x2-9, y1+h1+hk+2, r1x+dz[3]+x2-12, y1+h1+2*hk-2);
    pen.color:=clblue;
    y11:=r1y+p;
    x11:=x1+r1x-3;
    nline(pb1.canvas, x11+wz[1], y11, x11+wz[1], y11+p);
    nline(pb1.canvas, x11+wz[2], y11, x11+wz[2], y11+p);
    nline(pb1.canvas, x11+wz[1], r1y+2*ho+hk-p, x11+wz[1], r1y+2*ho+hk-2*p);
    nline(pb1.canvas, x11+wz[2], r1y+2*ho+2*hk+h1-p, x11+wz[2], r1y+2*ho+2*hk+h1-2*p);
    nline(pb1.canvas, x11+wz[3], r1y+hk+h1+p, x11+wz[3], r1y+hk+h1+2*p);
    nline(pb1.canvas, x11+wz[3], r1y+2*ho+2*hk+h1-p, x11+wz[3], r1y+2*ho+2*hk+h1-2*p);
    x11:=x1+r1x+3;
    nline(pb1.canvas, x11+wz[1], r1y+p, x11+wz[1], r1y+2*p);
    nline(pb1.canvas, x11+wz[2], r1y+p, x11+wz[2], r1y+2*p);
    nline(pb1.canvas, x11+wz[1], r1y+2*ho+hk-p, x11+wz[1], r1y+2*ho+hk-2*p);
    nline(pb1.canvas, x11+wz[2], r1y+2*ho+2*hk+h1-p, x11+wz[2], r1y+2*ho+2*hk+h1-2*p);
    nline(pb1.canvas, x11+wz[3], r1y+hk+h1+p, x11+wz[3], r1y+hk+h1+2*p);
    nline(pb1.canvas, x11+wz[3], r1y+2*ho+2*hk+h1-p, x11+wz[3], r1y+2*ho+2*hk+h1-2*p);
    x11:=x1+r1x;
    nline(pb1.canvas, x11+wz[1],   r1y,   x11+wz[1], r1y+ho+hk+ho);
    nline(pb1.canvas, x11+wz[2],   r1y,   x11+wz[2], r1y+2*ho+2*hk+h1);
    nline(pb1.canvas, x11+wz[3],   r1y+hk+h1,   x11+wz[3], r1y+2*ho+2*hk+h1);

    pen.color:=clblack;
    brush.Color:=$00E294BF;
    ellipse(r1x+x2, R2y-round(dz[3]/2), r1x+dz[3]+x2+1, R2y+round(dz[3]/2));
    brush.Color:=$008181E0;
    ellipse(r1x+dz[3]+x2, R2y-round(dz[4]/2), r1x+dz[3]+dz[4]+x2, R2y+round(dz[4]/2));
    ellipse(r1x+wz[3]+x1-1, R2y-1, r1x+x1+wz[3]+1, R2y+1);
    brush.Color:=$00A6DBA9;
    ellipse(r1x+x1, R2y-round(dz[1]/2), r1x+x1+dz[1], R2y+round(dz[1]/2));
    brush.Color:=$00E2D994;
    ellipse(r1x+dz[1]+x1, R2y-round(dz[2]/2), r1x+dz[1]+dz[2]+x1+1, R2y+round(dz[2]/2));
    ellipse(r1x+wz[2]+x1-2, R2y-1, r1x+x1+wz[2], R2y+1);
    ellipse(r1x+x1+wz[1]-1, R2y-1, r1x+x1+wz[1]+1, R2y+1);
  end;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.pb1Paint(Sender: TObject);
begin
  PaintReduktor;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.btnBeginClick(Sender: TObject);
var i:byte;
begin
  for i:=1 to 6 do begin
      (FindComponent('E'+inttostr(i)) as tedit).enabled:=false;
      (FindComponent('SB'+inttostr(i)) as tSpinButton).enabled:=false;
  end;
  for i:=7 to 28 do
      (FindComponent('E'+inttostr(i)) as tedit).text:='0,0';
  p3.Visible:=true;
  btnBegin.Enabled:=false;
  btnInform.Click;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.btnProwerkaClick(Sender: TObject);
var i:byte;
begin
  lab_8_result:=Tlab_8_result.create(application);
  case lab_8_result.NewShowModal(z[1], z[2], z[3], z[4], m1, b) of
    0 : e7.SetFocus;
    1 : begin
          p3.Visible:=false;
          for i:=1 to 6 do begin
              (FindComponent('E'+inttostr(i)) as tedit).enabled:=true;
              (FindComponent('E'+inttostr(i)) as tedit).text:=floattostr(param[i].min);
              (FindComponent('SB'+inttostr(i)) as tSpinButton).enabled:=true;
              case i of
                   1..4 : z[i]:=round(param[i].min);
                   5    : m1:=param[i].min;
                   6    : B:=round(param[i].min);
              end;
          end;
          pb1.Refresh;
          btnBegin.Enabled:=true;
        end;
    2 : close;
  end;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.btnInformClick(Sender: TObject);
begin
  lab_8_inform:=Tlab_8_inform.create(application);
  lab_8_inform.showmodal;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.eKeyPress(Sender: TObject; var Key: Char);
begin
  if key='.' then key:=',';
  if not (key in ['0'..'9',',',#8]) then key:=#0;
end;
//—————————————————————————————————————————————————————————————————————————
procedure Tlab_8.eExit(Sender: TObject);
begin
  try
    strtofloat((sender as tedit).text);
  except
    showmessage('Ââåäåíî íå ÷èñëî. Ïîâòîðèòå ââîä.');
    (sender as tedit).setfocus;
  end;
end;
//—————————————————————————————————————————————————————————————————————————
end.
