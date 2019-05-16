unit lab6_u;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, Spin;
type
  Tlab_6 = class(TForm)
    l9: TLabel;
    l12: TLabel;
    l1: TLabel;
    l2: TLabel;
    l10: TLabel;
    Bevel1: TBevel;
    Panel1: TPanel;
    Bevel2: TBevel;
    Timer1: TTimer;
    Panel4: TPanel;
    Button3: TButton;
    l3: TLabel;
    e4: TEdit;
    e5: TEdit;
    btnProwerka: TButton;
    btnInform: TButton;
    e6: TEdit;
    e7: TEdit;
    pb2: TPaintBox;
    l20: TLabel;
    l21: TLabel;
    l22: TLabel;
    l23: TLabel;
    Label2: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    Label1: TLabel;
    e1: TEdit;
    sb1: TSpinButton;
    sb2: TSpinButton;
    e2: TEdit;
    btnPowtor: TButton;
    btnNewOpit: TButton;
    e3: TEdit;
    sb3: TSpinButton;
    Panel3: TPanel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    PB1: TPaintBox;
    Bevel7: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label9: TLabel;
    l17: TLabel;
    Label10: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditExit(Sender: TObject);
    procedure sbClick(Sender: TObject; up:boolean);
    procedure sbDownClick(Sender: TObject);
    procedure sbUpClick(Sender: TObject);
    procedure btnNewOpitClick(Sender: TObject);
    procedure btnPowtorClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PB1Paint(Sender: TObject);
    procedure btnInformClick(Sender: TObject);
    procedure btnProwerkaClick(Sender: TObject);
    procedure pb2Paint(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  public
    move:boolean;
    d:real;
    l,nt:byte;
    jp, wp, Mmax, g3, ug,m:real;
    RH, RW:integer;           // высота и ширина рисунка
    CN,N,MT,Gsr:real;             // всего нагрузок и какая текущая нагрузка
    procedure PaintZagotowka(strelka:boolean);
    procedure EndLab;
  end;

var
  lab_6: Tlab_6;

implementation
uses osnowa_u, graph, lab_6_const, lab_6_inform_u, lab_6_result_u;

{$R *.DFM}
//=======================================================================
procedure Tlab_6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  osnowa.ol6.Enabled:=true;
  action:=cafree;
end;
//=======================================================================
procedure Tlab_6.FormPaint(Sender: TObject);
begin
  with canvas do begin
    pen.Color:=clBlue;
    pen.Style:=pssolid;
    brush.style:=bsclear;
  end;
  Paint_Siloizmeritel(canvas, ux, uy, ur, us, ' град');
  Paint_Siloizmeritel(canvas, mx, my, mr, ms, ' Н*мм');
  Paint_Strelka(canvas, ux, uy, ur, ug, us, clblack);
  Paint_Strelka(canvas, mx, my, mr, MT, ms, clblack);
  if move then timer1.Enabled:=true;
end;
//=======================================================================
procedure Tlab_6.FormCreate(Sender: TObject);
begin
  randomize;
  move:=false;
  e1.text:=floattostr(mater[1].min);
  e2.text:=floattostr(mater[2].min);
  e3.text:=floattostr(mater[3].min);
  Rh:=round(mater[1].min*20);
  rw:=30+round(mater[2].min);
  pagecontrol1.ActivePage:=TabSheet1;
  ug:=0;
end;
//=======================================================================
procedure Tlab_6.EditKeyPress(Sender: TObject; var Key: Char);
var st:string;
    i:byte;
begin
  st:=(sender as tedit).name;
  if key='.' then key:=',';
  if key=#13 then begin
     case st[2] of
     '1','2','4'..'6' : begin
                          i:=strtoint(st[2]);
                          (findcomponent('e'+inttostr(i+1)) as tedit).setfocus;
                        end;
     '3' : btnNewOpit.SetFocus;
     '7' : btnProwerka.SetFocus;
     end;
  end;
  if (st[2]='2')and(key=',') then key:=#0;
  if not (key in ['0'..'9',#8,',']) then key:=#0;
end;
//=======================================================================
procedure Tlab_6.EditExit(Sender: TObject);
var st:string;
    e:tedit;
    i:byte;
begin
  e:=(sender as tedit);
  st:=e.name;
  i:=strtoint(st[2]);
  case i of
    4..7:begin
           if length(e.text)=0 then e.text:='0,0';
           try strtofloat(e.text)
           except
              showmessage('Введено не число. Повторите ввод.');
              e.text:='0,0';
              e.setfocus;
           end;
         end;
    1..3:if length(e.text)=0 then e.Text:=floattostr(mater[i].min)
            else try
                   if strtofloat(e.text)<mater[i].min then
                      e.text:=floattostr(mater[i].min);
                   if strtofloat(e.text)>mater[i].max then
                      e.text:=floattostr(mater[i].max);
                 except
                   showmessage('Введено не число. Повторите ввод.');
                   e.text:=floattostr(mater[i].min);
                 end;
  end;
  case i of
    1: begin
         rh:=round(strtofloat(e.text)*20);
         pb2.Refresh;
       end;
    2: begin
         rw:=30+strtoint(e.text);
         pb2.Refresh;
       end;
    3: pb1.Refresh;
  end
end;
//=======================================================================
procedure Tlab_6.sbClick(Sender: TObject; up:boolean);
var st:string;
    i,j:byte;
    dx,r:real;
    e:tedit;
begin
  i:=strtoint((sender as tSpinbutton).name[3]);
  e:=(findcomponent('e'+inttostr(i)) as tedit);
  r:=strtofloat(e.text);
  if r<mater[i].min then r:=mater[i].min;
  if r>mater[i].max then r:=mater[i].max;
  dx:=mater[i].d;
  if not Up then dx:=-dx;
  if ((r>mater[i].min)and(dx<0))or((r<mater[i].max)and(dx>0)) then begin
     r:=r+dx;
     st:=floattostr(r);
     j:=pos(',', st);
     if j<>0 then st:=copy(st, 1, j+1);
     e.text:=st;
  end;
  case i of
    1: begin
         rh:=round(r*20);
         pb2.Refresh;
       end;
    2: begin
         rw:=30+round(r);
         pb2.Refresh;
       end;
    3: pb1.Refresh;
  end
end;
//=======================================================================
procedure Tlab_6.sbDownClick(Sender: TObject);
begin
  SBClick(sender, false);
end;
//=======================================================================
procedure Tlab_6.sbUpClick(Sender: TObject);
begin
  SBClick(sender, true);
end;
//=======================================================================
procedure Tlab_6.btnNewOpitClick(Sender: TObject);
var i:byte;
begin
  btnPowtor.Enabled:=true;
  btnPowtor.click;
  move:=true;
  timer1.enabled:=true;
  btnNewOpit.Enabled:=false;
  for i:=1 to 3 do begin
      (findcomponent('e'+inttostr(i)) as tedit).enabled:=false;
      (findcomponent('sb'+inttostr(i)) as tSpinButton).enabled:=false;
  end;
end;
//=======================================================================
procedure Tlab_6.btnPowtorClick(Sender: TObject);
begin
  panel4.Visible:=false;
  Paint_Strelka(canvas, ux, uy, ur, ug, us, clbtnface);
  Paint_Strelka(canvas, mx, my, mr, MT, ms, clbtnface);
  d:=strtofloat(e1.text);
  l:=strtoint(e2.text);
  CN:=strtoint(e3.text);       // количество опытов
  jp:=(pi*sqr(d)*sqr(d))/32;
  wp:=(pi*d*d*d)/16;
  Mmax:=80*wp;
  g3:=G+(5000-random(10000));
  M:=Mmax/CN;                  // по сколька M прибавлять при каждом опыте
  N:=0;
  ug:=0;
  MT:=0;
  NT:=1;
  Gsr:=0;
  pagecontrol1.ActivePage:=TabSheet2;
  pb1.Canvas.Pen.Color:=clblack;
  timer1.Enabled:=true;
  move:=true;
end;
//=======================================================================
procedure Tlab_6.Timer1Timer(Sender: TObject);
var g1,g2:real;
begin
  if not lab_6.active then timer1.Enabled:=false
  else
     if move then begin
        Paint_Strelka(canvas, mx, my, mr, MT, ms, clbtnface);
        MT:=n*M;
        Paint_Strelka(canvas, ux, uy, ur, ug, us, clbtnface);
        g1:=(M*n*l)/(g3*jp);
        g2:=(g1*180)/pi;
        ug:=g2;
        pb2.Refresh;
        Paint_Strelka(canvas, ux, uy, ur, ug, us, clblack);
        Paint_Strelka(canvas, mx, my, mr, MT, ms, clblack);
        if n>=NT then begin
           with pb1.canvas do begin
              textout(5+x1, round((nt-1)*hZ+2), floattostr(NRound(MT,2)));
              textout(5+x3, round((nt-1)*hZ+2), floattostr(NRound(g2,1)));
              textout(5+x2, round((nt-1)*hZ+2), floattostr(NRound(g1,3)));
           end;
           Gsr:=Gsr+g3;
           inc(nt);
        end;
        if n>=cn then endlab;
        n:=n+0.1;
     end;
end;
//=======================================================================
procedure Tlab_6.PB1Paint(Sender: TObject);
var nnt,i,j:byte;
    nn,nG2,nG1:real;
begin
  j:=strtoint(e3.text);
  i:=j*HZ;
  pb1.Canvas.pen.Color:=clGray;
  nline(pb1.canvas, x1, 0, x1, i);
  nline(pb1.canvas, x2, 0, x2, i);
  nline(pb1.canvas, x3, 0, x3, i);
  nline(pb1.canvas, x4, 0, x4, i);
  for i:=1 to j do nline(pb1.canvas, x1, i*hz, x4, i*hz);
  nn:=0;
  nnt:=1;
  while (nn<=NT) do begin
    if nn>=nnt then begin
      ng1:=(M*nn*l)/(g3*jp);
      ng2:=(ng1*180)/pi;
      with pb1.canvas do begin
         textout(5+x1, round((nnt-1)*hZ+2), floattostr(NRound(M*nn,2)));
         textout(5+x3, round((nnt-1)*hZ+2), floattostr(NRound(ng2,1)));
         textout(5+x2, round((nnt-1)*hZ+2), floattostr(NRound(ng1,3)));
      end;
      inc(nnt);
    end;
    nn:=nn+0.1;
  end;
end;
//=======================================================================
procedure Tlab_6.btnInformClick(Sender: TObject);
begin
  lab_6_inform:=Tlab_6_inform.create(application);
  lab_6_inform.showmodal;
end;
//=======================================================================
procedure Tlab_6.btnProwerkaClick(Sender: TObject);
var i:byte;
begin
  lab_6_result:=Tlab_6_result.create(application);
  case lab_6_result.Newshowmodal(strtofloat(e4.text), strtofloat(e5.text),
                                 strtofloat(e6.text), strtofloat(e7.text),
                                 jp, wp, Mmax/wp, Gsr/cn) of
    0 : e4.SetFocus;
    1 : begin
          btnNewOpit.Enabled:=true;
          for i:=1 to 3 do begin
              (findcomponent('e'+inttostr(i)) as tedit).enabled:=true;
              (findcomponent('sb'+inttostr(i)) as tSpinButton).enabled:=true;
          end;
          for i:=4 to 7 do (findcomponent('e'+inttostr(i)) as tedit).text:='0,0';
          btnPowtor.Enabled:=false;
          panel4.Visible:=false;
          Paint_Strelka(canvas, ux, uy, ur, ug, us, clbtnface);
          Paint_Strelka(canvas, mx, my, mr, MT, ms, clbtnface);
          ug:=0;
          pb2.Refresh;
          mt:=0;
          nt:=0;
          pb1.refresh;
          pagecontrol1.ActivePage:=TabSheet1;
          Paint_Strelka(canvas, ux, uy, ur, ug, us, clblack);
          Paint_Strelka(canvas, mx, my, mr, MT, ms, clblack);
        end;
    2 : close;
  end;
end;
//=======================================================================
procedure Tlab_6.pb2Paint(Sender: TObject);
begin
  paintzagotowka(move);
end;
//=======================================================================
procedure Tlab_6.PaintZagotowka(strelka:boolean);
var h, x2:integer;
begin
  with pb2.Canvas do begin
    pen.Style:=pssolid;
    pen.Color:=clblack;
    h:=rh div 2;
    x2:=rx1+rw;
    moveto(120, ry-h);
    lineto(120,0);
    lineto(0,0);
    lineto(0,120);
    lineto(120,120);
    lineto(120, ry+h-1);
    arc(rx1-h, ry-h, Rx1+h, ry+h, rx1, ry-h, rx1+1, ry+h);
    ellipse(x2-h, ry-h, x2+h, ry+h);
    Nline(pb2.canvas, rx1, ry-h, x2, ry-h);
    Nline(pb2.canvas, rx1, ry+h-1, x2, ry+h-1);
    pen.Style:=psdot;
    pen.color:=clred;
    Nline(pb2.canvas, x2,  ry, round(sin(((270-ug)*pi)/180)*(rh/2))+x2, round(cos(((270-ug)*pi)/180)*(rh/2))+ry);
    NLine(pb2.canvas, rx1-h, ry, (round(sin(((270-ug)*pi)/180)*(rh/2))+x2), round(cos(((270-ug)*pi)/180)*(rh/2))+ry);
    if strelka then begin
       pen.Style:=pssolid;
       pen.Color:=clblue;
       arc(x2-h+10, ry-h+10, x2+h-10, ry+h-10, x2+1, ry+10, x2, ry-10);
       moveto(x2+round(h/4), ry+h-10);
       lineto(x2, ry+h-10);
       lineto(x2+round(h/4), ry+h-16);
    end;
  end;
end;
//=======================================================================
procedure Tlab_6.EndLab;
begin
  move:=false;
  timer1.Enabled:=false;
  panel4.Visible:=true;
  pb2.Refresh;
  btnInform.Click;
end;
//=======================================================================
procedure Tlab_6.Button3Click(Sender: TObject);
begin
  application.Helpcontext(600);
end;
//=======================================================================
end.
