unit lab7_u;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, lab_7_const, ComCtrls, Spin;
type
  Tlab_7 = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Panel1: TPanel;
    pb1: TPaintBox;
    Timer1: TTimer;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    PBTable: TPaintBox;
    Label7: TLabel;
    sb1: TSpinButton;
    E_dF: TEdit;
    E_CountG: TEdit;
    E_Dsr: TEdit;
    sb2: TSpinButton;
    sb3: TSpinButton;
    sb4: TSpinButton;
    sb5: TSpinButton;
    E_n: TEdit;
    E_d: TEdit;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    btnNewOpit: TButton;
    btnPowtor: TButton;
    Bevel2: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Panel4: TPanel;
    Label22: TLabel;
    Edit1: TEdit;
    btnProwerka: TButton;
    btnInform: TButton;
    Image1: TImage;
    Bevel6: TBevel;
    Shape1: TShape;
    Label13: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Edit2: TEdit;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Button1: TButton;
    Label49: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PBTablePaint(Sender: TObject);

    procedure sbDownClick(Sender: TObject);
    procedure sbUpClick(Sender: TObject);
    procedure sbClick(Sender: TObject; down:boolean);

    procedure E_KeyPress(Sender: TObject; var Key: Char);

    procedure btnInformClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnNewOpitClick(Sender: TObject);
    procedure pb1Paint(Sender: TObject);
    procedure btnPowtorClick(Sender: TObject);
    procedure E_Exit(Sender: TObject);
    procedure btnProwerkaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  public
    HeightPrugina : real;    // высота пружины
    HP1           : real;
    WidthPrugina  : integer;
    CountW        : byte;       // количество витков в пружине * 2
    CountZapis    : byte;       // количество записей в таблице
    move          : boolean;
    G             : byte;       // количество грузов
    Y             : real;       // приращение нагрузки теоретическое
    Y1            : real;       // приращение нагрузки с погрешностями
    L             : real;
    my1           : array [1..10] of real;
    procedure Paint_Prugina(h:real; w:integer);
    procedure Lineyka;
    procedure SPClick(var e:tedit; dx:real; max, min:real);
    procedure NewDsr;
    procedure NewWitki;
    procedure ExitEdit(var E:tedit; max, min:real);
    procedure EndLab(n:boolean);
    procedure NewY1;
    function  FloatToStrInt(r:real; j:byte):string;
  end;

var
  lab_7: Tlab_7;

implementation
uses osnowa_u, graph, lab_7_inform_u, Lab_7_result_u;

{$R *.DFM}
//=======================================================================
procedure Tlab_7.ExitEdit(var E:tedit; max, min:real);
begin// при выходе из EDIT проверка вхождения числа в определенные пределы
 try
  if strtofloat(E.Text)<=min then E.text:=floattostr(min);
  if strtofloat(E.Text)>=max then E.text:=floattostr(max);
 except
  showmessage('Введено не число. Повторите ввод.');
  e.text:=floattostr(min);
  e.SetFocus;
 end;
end;
//=======================================================================
procedure Tlab_7.E_Exit(Sender: TObject);
var max,min:real;
    e:tedit;
begin
  e:=(sender as tedit);
  if e.name='E_dF' then begin   // выбираем какой компонент нас вызвал
      max:=df_max;
      min:=df_min;
  end;
  if e.name='E_CountG' then begin
      max:=CountG_max;
      min:=CountG_min;
  end;
  if e.name='E_Dsr' then begin
      max:=Dsr_max;
      min:=Dsr_min;
  end;
  if e.name='E_n' then begin
      max:=n_max;
      min:=n_min;
  end;
  if e.name='E_d' then begin
      max:=d_max;
      min:=d_min;
  end;
  if (e.Name='Edit1')or(e.Name='Edit2') then begin
     min:=0.0;
     max:=10000;
  end;
  if length(e.Text)<>0 then ExitEdit(e, max, min)
  else e.Text:=floattostr(min);
  if e.name='E_Dsr' then NewDsr;
  if e.Name='E_n' then NewWitki;
end;
//=======================================================================
procedure Tlab_7.E_KeyPress(Sender: TObject; var Key: Char);
var e:tedit;
begin
  e:=(sender as tedit);
  if key='.' then key:=',';
  if not(key in ['0'..'9',',',#8,#13]) then key:=#0;
  if key=',' then if (e.Name='E_CountG')or(e.Name='E_n') then key:=#0;
  if key=#13 then begin
     if e.name='E_dF' then E_CountG.SetFocus;
     if e.name='E_CountG' then E_Dsr.SetFocus;
     if e.name='E_Dsr' then begin
        E_n.SetFocus;
        NewDsr;
     end;
     if e.name='E_n'  then begin
        E_d.SetFocus;
        NewWitki;
     end;
     if e.name='E_d' then btnNewOpit.SetFocus;
     if e.Name='Edit1' then edit2.SetFocus;
     if e.name='Edit2' then btnProwerka.setfocus;
  end;
end;
//=======================================================================
Procedure Tlab_7.SPClick(var e:tedit; dx:real; max, min:real);
var r:real;
    i:byte;
    st:string;
begin
  r:=strtofloat(e.text);  // обработка нажатий SpinButton
  if ((r>min)and(dx<0))or((r<max)and(dx>0)) then begin
     r:=r+dx;
     st:=floattostr(r);
     i:=pos(',', st);
     if i<>0 then st:=copy(st, 1, i+1);
     e.Text:=st;
  end;
end;
//=======================================================================
procedure Tlab_7.sbClick(Sender: TObject; down:boolean);
var max,min:real;
    e:tedit;
    sb:tspinbutton;
    d:real;
begin
  sb:=(sender as TspinButton);
  if sb.name='sb1' then begin   
      max:=df_max;
      min:=df_min;
      d:=dfd;
      e:=e_df;
  end;
  if sb.name='sb2' then begin
      max:=CountG_max;
      min:=CountG_min;
      d:=countgd;
      e:=e_countG;
  end;
  if sb.name='sb3' then begin
      max:=Dsr_max;
      min:=Dsr_min;
      d:=dsrd;
      e:=e_dsr;
  end;
  if sb.name='sb4' then begin
      max:=n_max;
      min:=n_min;
      d:=nd;
      e:=e_n;
  end;
  if sb.name='sb5' then begin
      max:=d_max;
      min:=d_min;
      d:=dd;
      e:=e_d;
  end;
  if down then d:=-d;
  SPClick(e, d, max, min);
  if sb.name='sb3' then NewDsr;
  if sb.Name='sb4' then NewWitki;
end;
//=======================================================================
procedure Tlab_7.sbDownClick(Sender: TObject);
begin
  sbClick(sender, true);               // нажатие sb 1..5 вниз
end;
//=======================================================================
procedure Tlab_7.sbUpClick(Sender: TObject);
begin
  sbClick(sender, false);              // нажатие sb 1..5 вверх
end;
//=======================================================================
procedure Tlab_7.NewDsr;
var i:integer;
begin
  i:=round(strtofloat(e_dsr.text)*2+50); // новый диаметр пружины
  if i<>WidthPrugina then Paint_Prugina(HeightPrugina, i);
end;
//=======================================================================
procedure Tlab_7.NewWitki;
var i:byte;
begin
  i:=round(strtofloat(e_n.text)*2);     // изменилось количество витков
  if CountW<>i then begin
     countW:=i;
     Pb1.Refresh;
  end;
end;
//=======================================================================
//=======================================================================
procedure Tlab_7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  osnowa.ol7.Enabled:=true;
  action:=cafree;
end;
//=======================================================================
procedure Tlab_7.Paint_Prugina(h:real; w:integer);
var i:byte;
    r1, r2:real;
    x1, x2, xn1, xn2:integer;
begin
      r1:=HeightPrugina / countW;
      r2:=h / countW;
      with pb1.canvas do begin
        pen.Width:=2;
        pen.Color:=clwhite;
        // стираем верхнюю и нижнюю линии
        // нижняя стирается потому что при увеличении размера пружины нижний виток должен тоже изменятся
        NLine(pb1.canvas, Xprugina, YPrugina-round(r1*countW), XPrugina-widthPrugina, YPrugina-round(r1*countW));
        NLine(pb1.canvas, Xprugina, Yprugina, XPrugina-widthPrugina, Yprugina);
        for i:=1 to countW+1 do begin
            if i/2=round(i/2) then begin
               x1:=XPrugina;
               x2:=XPrugina-widthPrugina;
               xn1:=XPrugina;
               xn2:=XPrugina-w;
            end
            else begin
               x1:=XPrugina-widthPrugina;
               x2:=XPrugina;
               xn1:=XPrugina-w;
               xn2:=XPrugina;
            end;
            if i<=countW then begin
               pen.Color:=clwhite;  // стираем одну линию пружины
               moveto(x2, YPrugina-round(r1*(i-1)));
               lineto(x1, YPrugina-round(r1*i));
            end;
            if i>=2 then begin   // рисуем новую линию
               pen.Color:=clblack;
               moveto(xn1, YPrugina-round(r2*(i-2)));
               lineto(xn2, YPrugina-round(r2*(i-1)));
            end;
        end;                                     // рисуем верхнюю и нижнюю линии
        NLine(pb1.canvas, Xprugina, YPrugina-round(r2*countW),
              XPrugina-w, YPrugina-round(r2*countW));
        NLine(pb1.canvas, Xprugina, Yprugina, XPrugina-w, Yprugina);
      end;
   HeightPrugina:=h;
   WidthPrugina:=w;
end;
//=======================================================================
procedure Tlab_7.Lineyka;
var i:integer;
begin
  with pb1.Canvas do begin
    pen.Width:=1;
    pen.color:=clblue;
    brush.Style:=bsclear;
    moveto(Lx, Ly);
    lineto(Lx+55, Ly);
    rectangle(Lx+10, Ly-(Ldy*round(LcountD/Lm))-20, Lx+45, Ly+1);
    textout(Lx+20, Ly-(Ldy*round(LCountD/Lm))-18, 'мм');
    for i:=1 to round(LCountD/Lm) do begin
        moveto(Lx+10, Ly-i*Ldy);
        lineto(Lx+15, Ly-i*Ldy);
        textout(Lx+17, Ly-i*Ldy-5, inttostr(LCountD-i*Lm+0));
    end;
  end;
end;
//=======================================================================
procedure Tlab_7.Timer1Timer(Sender: TObject);
var b:boolean;
begin
  if not lab_7.active then timer1.Enabled:=false
  else
     if move then begin
        Paint_Prugina(HeightPrugina-y1/5, WidthPrugina);
        image1.Top:=352-round(heightPrugina)-21;
        b:=false;
        if HeightPrugina<MinHeightPrugina then b:=true;
        if (HP1-Y1>=HeightPrugina)or b then begin
           inc(G);
           PBTable.Canvas.TextOut(10,    ((g-1)*heightZapis)+3,  floattostr(strtofloat(e_df.text)*(g-1)));
           PBTable.Canvas.TextOut(x1+10, ((g-1)*heightZapis)+3,  FloatToStr(l));
           canvas.lineto(Gx+round(L/ldy*lm), Gy-round((strtofloat(e_df.text)*(g-1))/Gky * Gdy));
           if g<>1 then
              PBTable.Canvas.TextOut(x2+10, ((g-2)*heightZapis)+12, FloatToStr(NRound(y1/ldy*lm, 1)));
           Hp1:=HeightPrugina;
           if (G-1>=strtoint(E_CountG.text))or b then EndLab(b)
           else NewY1;
        end;
     end;
end;
//=======================================================================
procedure Tlab_7.FormCreate(Sender: TObject);
begin
  randomize;
  widthPrugina:=round(dsr_min*2+50);              // ширина пружины
  CountW:=n_min*2;                                  // количество витков минимальное
  E_dF.Text:=floattostr(dF_min);
  E_CountG.Text:=floattostr(CountG_min);          // выставляем в полях мин значения
  E_Dsr.Text:=floattostr(Dsr_min);
  E_n.Text:=floattostr(n_min);
  E_d.Text:=floattostr(d_min);
  pagecontrol1.ActivePage:=TabSheet1;
  heightPrugina:=round(LCountD/Lm*Ldy)
end;
//=======================================================================
procedure Tlab_7.PBTablePaint(Sender: TObject);

  procedure LineTable(x1, y1, x2, y2:integer);
  begin
    PBTable.canvas.moveto(x1, y1);
    PBTable.canvas.lineto(x2, y2);
  end;

var l:real;
    j:byte;
    i,c,o:byte;
begin
  with PBTable.canvas do begin                // прорисовка таблицы
     pen.Color:=clgray;
     j:=strtoint(e_CountG.text);
     LineTable(x1, 0, x1, (j+1)*HeightZapis);
     LineTable(x2, 0, x2, (j+1)*HeightZapis);
     o:=Round(HeightZapis/2);
     for i:=0 to j do begin
         c:=(i+1)*HeightZapis;
         LineTable(0, c, x2, c);
         LineTable(x2, c-o, x3, c-o);
     end;
  end;
  l:=0;     // прорисовка значений таблицы
  for i:=1 to g do begin
      PBTable.Canvas.TextOut(10,    ((i-1)*heightZapis)+3,  floattostr(strtofloat(e_df.text)*(i-1)));
      PBTable.Canvas.TextOut(x1+10, ((i-1)*heightZapis)+3,  FloatToStr(l));
      l:=l+NRound(my1[i]/ldy*lm, 1);
      if i<>g then
         PBTable.Canvas.TextOut(x2+10, ((i-1)*heightZapis)+12, FloatToStr(NRound(my1[i]/ldy*lm, 1)));
  end;
end;
//=======================================================================
procedure Tlab_7.btnInformClick(Sender: TObject);
begin
  lab_7_inform:=Tlab_7_inform.create(application);  // выдача окна информации
  lab_7_inform.showmodal;
  edit1.SetFocus;
end;
//=======================================================================
procedure Tlab_7.FormPaint(Sender: TObject);
var i:byte;
    l:real;
begin
  PaintXOY(canvas, Gx, Gy, Glx, Gly, Gdx, Gdy, Gkx, Gky, Gkxd, Gkyd, false); // прорисовка графика
  if move then timer1.Enabled:=true;   // включаем таймер если он выключился
  // прорисовка графика
  with canvas do begin
    pen.Color:=clred;
    pen.Style:=pssolid;
    moveto(Gx, Gy);
  end;
  l:=0;
  for i:=1 to g do begin
      canvas.lineto(Gx+round(L/ldy*lm), Gy-round((strtofloat(e_df.text)*(i-1))/Gky * Gdy));
      l:=l+my1[i];
  end;
end;
//=======================================================================
procedure Tlab_7.btnNewOpitClick(Sender: TObject);
begin
  E_dF.Enabled:=false;             sb1.Enabled:=false; //выключаем все что
  E_CountG.Enabled:=false;         sb2.Enabled:=false; //моут изменить
  E_Dsr.Enabled:=false;            sb3.Enabled:=false;
  E_d.Enabled:=false;              sb4.Enabled:=false;
  E_n.Enabled:=false;              sb5.Enabled:=false;
  btnNewOpit.enabled:=false;                           // и саму себя тоже
  btnPowtor.Enabled:=true;
  btnPowtor.Click;                                     // как будто нажали повтор
  label13.Caption:=e_df.Text+' H';
  label23.Caption:=e_Dsr.Text+' мм';
  label25.Caption:=e_n.Text;
  label27.Caption:=e_d.Text+' мм';
end;
//=======================================================================
procedure Tlab_7.pb1Paint(Sender: TObject);
begin
  Paint_Prugina(HeightPrugina, WidthPrugina);
  Lineyka;
end;
//=======================================================================
procedure Tlab_7.btnPowtorClick(Sender: TObject);
var dsr1,d1:real;
begin
  Paint_Prugina(round(LCountD/Lm*Ldy), widthPrugina); // прорисовка пружины во всю длину
  move:=true;                        // включаем движение и таймер
  Timer1.Enabled:=true;
  image1.visible:=true;
  panel4.visible:=false;
  dsr1:=strtofloat(e_Dsr.text);
  d1:=strtofloat(e_d.text);          // рассчитываем Y теоретический
  y:=(8*strtofloat(e_dF.text)*dsr1*dsr1*dsr1*strtofloat(e_n.text))/(80000*sqr(d1)*sqr(d1));
  L:=0;
  G:=0;
  Hp1:=HeightPrugina;
  pagecontrol1.ActivePage:=TabSheet2;
  with canvas do begin
    pen.style:=pssolid;
    pen.color:=clred;
    moveto(Gx, Gy);
  end;
end;
//=======================================================================
procedure Tlab_7.EndLab(n:boolean);
begin
  move:=false;
  Timer1.Enabled:=false;
  if n then
     ShowMessage('Пружина дальше сжиматься не может.'+#13#10+'Добавление грузов невозможно.');
  Panel4.Visible:=true;
  Image1.Visible:=false;
  btnInform.Click;
end;
//=======================================================================
Procedure Tlab_7.NewY1;
var r:real;
begin
  r:=(1-random(3))/10;
  y1:=NRound((y+r)/Lm*Ldy, 1);
  my1[g]:=y1;
  L:=L+NRound(y1/ldy*lm, 1);
end;
//=======================================================================
function Tlab_7.FloatToStrInt(r:real; j:byte):string;
var st:string;
    i:byte;
begin
  st:=floattostr(r);
  i:=pos(',',st);
  if i<>0 then st:=copy(st, 1, i+j);
  FloatToStrInt:=st;
end;
//=======================================================================
procedure Tlab_7.btnProwerkaClick(Sender: TObject);
var r1:real;
    i:byte;
begin
  Lab_7_result:=TLab_7_result.create(application);
  r1:=0;
  for i:=1 to g-1 do r1:=r1+NRound((my1[i]/Ldy)*Lm, 1);
  r1:=r1/(g-1);
  r1:=NRound(abs((y-r1)/y*100), 1);
  case Lab_7_result.NewShowModal(strtofloat(edit1.Text), y, strtofloat(edit2.Text), r1) of
    0 : edit1.SetFocus;
    1 : begin
          E_dF.Enabled:=true;
          sb1.Enabled:=true;
          E_CountG.Enabled:=true;
          sb2.Enabled:=true;
          E_Dsr.Enabled:=true;
          sb3.Enabled:=true;
          E_d.Enabled:=true;
          sb4.Enabled:=true;
          E_n.Enabled:=true;
          sb5.Enabled:=true;
          panel4.visible:=false;
          label33.Caption:='';
          label13.Caption:='';
          label23.Caption:='';
          label25.Caption:='';
          label27.Caption:='';
          edit1.Text:='0';
          edit2.Text:='0';
          btnNewOpit.Enabled:=true;
          btnPowtor.Enabled:=false;
          Paint_Prugina(round(LCountD/Lm*Ldy), WidthPrugina);
          pagecontrol1.ActivePage:=TabSheet1;
          g:=0;
        end;
    2 : close;
  end;
end;
//=======================================================================
procedure Tlab_7.Button1Click(Sender: TObject);
begin
  application.Helpcontext(700);
end;

end.
