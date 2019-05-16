unit lab3_u;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, jpeg;
type
  Tlab_3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Button1: TButton;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label7: TLabel;
    Timer1: TTimer;
    Label6: TLabel;
    Panel3: TPanel;
    Label8: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    e1: TEdit;
    e2: TEdit;
    e3: TEdit;
    e4: TEdit;
    e5: TEdit;
    btnProwerka: TButton;
    Label21: TLabel;
    Label22: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Label20: TLabel;
    btnNewLab: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    btnPowtor: TButton;
    Panel2: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    L_D: TLabel;
    L_Dl: TLabel;
    L_Dr: TLabel;
    L_Dlr: TLabel;
    L_Fm: TLabel;
    L_Fmax: TLabel;
    L_Fraz: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    btnInform: TButton;
    Panel4: TPanel;
    Image1: TImage;
    Shape2: TShape;
    Shape4: TShape;
    Shape3: TShape;
    Image2: TImage;
    PaintBox1: TPaintBox;
    Label13: TLabel;
    Label19: TLabel;
    Label26: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnNewLabClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure btnPowtorClick(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure btnProwerkaClick(Sender: TObject);
    procedure btnInformClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure e1Exit(Sender: TObject);
  private
    procedure Paint_Gafik_OXY;                     // прорисовка осей графика
    procedure Refresh_Grafik;                      // прорисовка графика
    procedure Clear_Grafik;                        // очистка графика
    procedure Paint_Resize_Zagotowka;              // прорисовка размеров заготовки
    procedure EndLab;                              // конец лабы
    procedure PrintTF(X, Y, ind_znacenie :integer; F:real); // прорисовка одного значений на диаграмме
  public
    ind_mater : byte;              // номер индекса материала
    TF    : real;                  // текущая сила
    TL    : integer;               // текущая длина
    TFd   : real;                  // насколько необходимо увеличивать TF
    TFdd  : real;                  // насколько необходимо увеличивать TFd для скругления графика
    MRy   : integer;               // координата Y места разрыва
    move  : boolean;               // необходимость анимации объектов
    end_opit:boolean;              // конец опыта
    ind_F : byte;
    WZ, WZd : real;                // ширина заготовки в месте разрыва
  end;

var
  lab_3: Tlab_3;
                            implementation
uses osnowa_u, lab_3_inform_u, lab_3_result_u, lab_3_const, graph;
{$R *.DFM}
//=========================================================================
procedure Tlab_3.Paint_Gafik_OXY;          // прорисовка осей графика
begin
  PaintXOY(canvas, Dx, Dy, Lx, Ly, Ddx, Ddy, 3, 5, 10, 10, false);
end;
//=========================================================================
procedure Tlab_3.Refresh_Grafik;     // прорисовка графика
var i, nind_f:byte;
    NF, nfd, nfdd:real;
begin
  if (ind_mater<>0)and(end_opit or move) then begin
     nFd:=mater[ind_mater, 6];
     nFdd:=mater[ind_mater, 9];
     nF:=0;
     nind_F:=0;
     i:=0;
     while i<=tl do begin
         canvas.pen.color:=clred;
         canvas.moveto(DX+i, Dy-round(nf*(Ddy/5)));
         inc(i);
         nF:=nF+nFd;
         nFd:=nFd+nFdd;
         canvas.lineto(DX+i, Dy-round(nf*(Ddy/5)));

         if (nF>=mater[ind_mater, 3])and(nind_f=0) then begin
            nFd:=0.05;
            nFdd:=0.01;
            nind_F:=1;
            PrintTF(DX+i, Dy-round(nf*(Ddy/5)), 1, mater[ind_mater, 3]);
         end;
         if (nF>=mater[ind_mater, 3]+1)and(nind_f=1) then begin
            nFd:=mater[ind_mater, 7];
            nFdd:=mater[ind_mater, 10];
            nind_F:=2;
         end;
         if (nF>=mater[ind_mater, 4])and(nind_f=2) then begin
            nFd:=mater[ind_mater, 8];
            nFdd:=mater[ind_mater, 11];
            PrintTF(DX+i, Dy-round(nf*(Ddy/5)), 2, mater[ind_mater, 4]);
            nind_F:=3;
         end;
     end;
     if (Dl+TL div 6)>=mater[ind_mater, 2] then PrintTF(DX+TL, Dy-round(nf*(Ddy/5)), 3, mater[ind_mater, 5]);
  end;
end;
//=========================================================================
procedure Tlab_3.Clear_Grafik;
begin
  ClearWin(canvas, Dx+1, Dy-Ly, Dx+Lx, Dy-1, clbtnface, clbtnface);
end;
//=========================================================================
procedure Tlab_3.Paint_Resize_Zagotowka;
const NDx=35;
      NDy=48;
      NDlx=70;
      NDly=35;
      NDl =150+image_dl;
var i:integer;
begin
  with paintbox1.canvas do begin
    pen.Color:=clblack;
    pen.style:=pssolid;
    brush.Style:=bsclear;
    // рисуем начальный диаметр
    nline(paintbox1.canvas, ndx, ndy, ndx+55, ndy);
    StrelkaLR(paintbox1.canvas, ndx+25, ndy, false);
    StrelkaLR(paintbox1.canvas, ndx+46, ndy, true);
    diametr(paintbox1.canvas, ndx, ndy, '10');
    // рисуем диаметр после разрыва
    nline(paintbox1.canvas, ndx, MRy+15, ndx+55, MRy+15);
    strelkaLR(paintbox1.canvas, ndx+40, MRy+15, true);
    strelkaLR(paintbox1.canvas, ndx+30, MRy+15, false);
    diametr(paintbox1.canvas, ndx, MRy+13, floattostr(mater[ind_mater,1]));
    // рисуем начальную длину заготовки
    nline(paintbox1.canvas, Ndlx, ndly, ndlx+70, ndly);
    nline(paintbox1.canvas, Ndlx, ndly+ndl, ndlx+50, ndly+ndl);
    StrelkaTB(paintbox1.canvas, ndlx+25, ndly, true);
    StrelkaTB(paintbox1.canvas, ndlx+25, ndly+ndl, false);
    nline(paintbox1.canvas, Ndlx+25, ndly, ndlx+25, ndly+ndl);
    textout(ndlx+27, ndly+100, '100');
    nline(paintbox1.canvas, ndlx+45, ndly+112, ndlx+30, ndly+112);
    lineto(ndlx+26, ndly+116);
    // рисуем длину после разрыва
    i:=ndly+round(mater[ind_mater, 2]*2)+image_dl-50;
    nline(paintbox1.canvas, ndlx, i, ndlx+70, i);
    StrelkaTB(paintbox1.canvas, ndlx+60, ndly, true);
    StrelkaTB(paintbox1.canvas, ndlx+60, i, false);
    nline(paintbox1.canvas, ndlx+60, ndly, ndlx+60, i);
    textout(ndlx+62, ndly+100, floattostr(mater[ind_mater,2]));
    nline(paintbox1.canvas, ndlx+80, ndly+112, ndlx+65, ndly+112);
    lineto(ndlx+61, ndly+116);
    // рисуем разрыв образца
    pen.color:=clwhite;
    nline(paintbox1.canvas, ndx+30, MRy+14, ndx+40, MRy+14);
    nline(paintbox1.canvas, ndx+30, MRy+16, ndx+40, MRy+16);
  end;
end;
//=========================================================================
procedure Tlab_3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  osnowa.ol3.Enabled:=true;
  action:=cafree;                  // удаляем форму
end;
//=========================================================================
procedure Tlab_3.FormCreate(Sender: TObject);
begin
  move:=false;
  end_opit:=false;
  TF:=0;
  pagecontrol1.ActivePage:=TabSheet1;
end;
//=========================================================================
procedure Tlab_3.FormPaint(Sender: TObject);
begin
  Paint_Siloizmeritel(lab_3.canvas, sx, sy, sr, 50, 'кН');
  Clear_Grafik;
  Paint_Gafik_OXY;
  // если перед тем как потерять фокус таймер был включен то он выключился
  // после потери фокуса и надо снова его включить для продолжения ЛР
  if move then timer1.Enabled:=true;
  Refresh_Grafik;
  Paint_Strelka(lab_3.Canvas, sx, sy, sr, TF, 50, clblack);
end;
//=========================================================================
procedure Tlab_3.btnNewLabClick(Sender: TObject);
begin
  btnNewLab.Enabled:=false;
  btnPowtor.Enabled:=true;
  radiobutton1.Enabled:=false;
  radiobutton2.Enabled:=false;
  radiobutton3.Enabled:=false;
  panel3.Visible:=false;
  e1.Text:='0,0';
  e2.Text:='0,0';
  e3.Text:='0,0';
  e4.Text:='0,0';
  e5.Text:='0,0';
  L_Dr.Caption:='';
  L_Dlr.Caption:='';
  L_Fm.Caption:='';
  L_Fmax.Caption:='';
  L_Fraz.Caption:='';
  // выбираем материал
  if radiobutton1.Checked then ind_mater:=1
  else
     if radiobutton2.Checked then ind_mater:=2
     else ind_mater:=3;
  btnPowtor.Click;
end;
//=========================================================================
procedure Tlab_3.Timer1Timer(Sender: TObject);
begin
  // если форма потеряла фокус то отключаем таймер. При прорисовки формы
  // таймер снова включится
  if not lab_3.active then timer1.Enabled:=false
  else begin
    if move then begin

       if (Dl+TL div 6)>=mater[ind_mater, 2] then EndLab;   // конец опыта

       with canvas do begin
         paint_strelka(lab_3.Canvas, sx, sy, sr, TF, 50, clbtnface);
         pen.color:=clred;
         moveto(DX+TL, Dy-round(Tf*(Ddy/5)));
         TL:=TL+1;
         TF:=TF+TFd;
         TFd:=TFd+TFdd;
         lineto(DX+TL, Dy-round(Tf*(Ddy/5)));
         paint_strelka(lab_3.Canvas, sx, sy, sr, TF, 50, clblack);

         if (tl/3)=round(tl/3) then image2.Top:=image2.Top+1;

         if (TF>=mater[ind_mater, 3])and(ind_f=0) then begin
            TFd:=0.05;
            TFdd:=0.01;
            ind_F:=1;
            PrintTF(DX+TL, Dy-round(Tf*(Ddy/5)), 1, mater[ind_mater, 3]);
         end;
         if (TF>=mater[ind_mater, 3]+1)and(ind_f=1) then begin
            TFd:=mater[ind_mater, 7];
            TFdd:=mater[ind_mater, 10];
            ind_F:=2;
         end;
         if (TF>=mater[ind_mater, 4])and(ind_f=2) then begin
            TFd:=mater[ind_mater, 8];
            TFdd:=mater[ind_mater, 11];
            PrintTF(DX+TL, Dy-round(Tf*(Ddy/5)), 2, mater[ind_mater, 4]);
            ind_F:=3;
            WZd:=0.11;
         end;
         if shape4.Left<>30+round(WZ) then begin
            shape4.Left:=30+round(WZ);
            shape3.Left:=111-round(WZ);
            MRY:=MRY+round(WZ);
            shape4.top:=MRy;
            shape3.top:=MRy;
         end;
         WZ:=WZ+WZd;
       end;
    end;
  end;
end;
//=========================================================================
procedure Tlab_3.PaintBox1Paint(Sender: TObject);
begin
  if end_opit then Paint_Resize_Zagotowka;
end;
//=========================================================================
procedure Tlab_3.btnPowtorClick(Sender: TObject);
begin
  paint_strelka(lab_3.Canvas, sx, sy, sr, TF, 50, clbtnface);
  end_opit:=false;
  move:=true;
  paintbox1.Invalidate ;
  //paintbox1.Refresh;
  image2.Top:=270;
  Clear_Grafik;
  Paint_Gafik_OXY;
  TFd:=mater[ind_mater, 6];
  TFdd:=mater[ind_mater, 9];
  TF:=0;
  TL:=0;
  WZ:=0;
  WZd:=0;
  ind_F:=0;
  // выбираем расположение места разрыва
  MRy:=80+random(100);
  shape4.Top:=MRy;
  shape3.top:=MRy;
  shape4.Left:=30;
  shape3.Left:=111;
  timer1.Enabled:=true;
end;
//=====================================================================
procedure Tlab_3.EndLab;
begin
  PrintTF(DX+TL, Dy-round(Tf*(Ddy/5)), 3, mater[ind_mater, 5]);
  move:=false;
  timer1.Enabled:=false;
  end_opit:=true;
  paintbox1.Refresh;
  btnNewLab.Enabled:=true;
  btnPowtor.Enabled:=false;
  radiobutton1.Enabled:=true;
  radiobutton2.Enabled:=true;
  radiobutton3.Enabled:=true;
  L_Dr.Caption:=floattostr(mater[ind_mater, 1])+' мм.';
  L_Dlr.Caption:=floattostr(mater[ind_mater, 2])+' мм.';
  L_Fm.Caption:=floattostr(mater[ind_mater, 3])+' кН.';
  L_Fmax.Caption:=floattostr(mater[ind_mater, 4])+' кН.';
  L_Fraz.Caption:=floattostr(mater[ind_mater, 5])+' кН.';
  pagecontrol1.ActivePage:=TabSheet2;
  panel3.Visible:=true;
  lab_3_inform:=Tlab_3_inform.create(application);
  lab_3_inform.showmodal;
  e1.SetFocus;
end;
//=====================================================================
procedure Tlab_3.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if key='.' then key:=',';
  if key=#13 then begin
     case (sender as tedit).name[2] of
       '1'..'4': (findcomponent('e'+inttostr(strtoint((sender as tedit).name[2])+1)) as tedit).setfocus;
       '5' : btnProwerka.SetFocus;
     end;
  end;
  if not(key in ['0'..'9', ',', #8]) then key:=#0;
end;
//=====================================================================
procedure Tlab_3.PrintTF(X, Y, ind_znacenie :integer; F:real);
begin
    with canvas do begin
      pen.Color:=clBlack;
      brush.Style:=bsclear;
      ellipse(x-1, y-1, x+2, y+2);
      textout(x-5, y-20, floattostr(F));
    end;
end;
//=====================================================================
procedure Tlab_3.btnProwerkaClick(Sender: TObject);
var n:byte;
begin
  lab_3_result:=Tlab_3_result.Create(application);
  n:=lab_3_result.NewShowModal(ind_Mater);
  case n of
   0 : e1.setfocus;
   1 : begin
         end_opit:=false;
         move:=false;
         panel3.Visible:=false;
         L_Dr.Caption:='';
         L_Dlr.Caption:='';
         L_Fm.Caption:='';
         L_Fmax.Caption:='';
         L_Fraz.Caption:='';
         pagecontrol1.ActivePage:=TabSheet1;
         paintbox1.Refresh;
         image2.Top:=270;
         shape4.Left:=30;
         shape3.Left:=111;
         Clear_Grafik;
         Paint_Gafik_OXY;
         paint_strelka(lab_3.Canvas, sx, sy, sr, TF, 50, clbtnface);
         tf:=0;
       end;
   2 : close;
  end;
end;
//=====================================================================
procedure Tlab_3.btnInformClick(Sender: TObject);
begin
  lab_3_inform:=Tlab_3_inform.create(application);
  lab_3_inform.showmodal;
end;
//=====================================================================
procedure Tlab_3.Button1Click(Sender: TObject);
begin
  application.Helpcontext(300);
end;
//=====================================================================
procedure Tlab_3.e1Exit(Sender: TObject);
begin
  try
    strtofloat((sender as tedit).text);
  except
    showmessage('Ошибка ввода.');
    (sender as tedit).setfocus;
  end;
end;

end.

