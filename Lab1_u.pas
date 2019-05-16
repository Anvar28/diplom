{DELPHI 4        Хисматуллин А.Р.       Лабораторная 1
1-ПОВТ-97              14.03.01}
unit Lab1_u;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg, Spin;
type
  Tlab_1 = class(TForm)
    Label4: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label7: TLabel;
    l_rec_area: TLabel;
    l_rec_ct_x: TLabel;
    l_rec_ct_y: TLabel;
    Label8: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    l_kr_area: TLabel;
    l_kr_ct_x: TLabel;
    l_kr_ct_y: TLabel;
    p_help: TPanel;
    l_help: TLabel;
    b_analiz: TButton;
    Image2: TImage;
    Image3: TImage;
    Help: TButton;
    Label25: TLabel;
    cb_rec_cut: TCheckBox;
    cb_kr_cut: TCheckBox;
    Panel1: TPanel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    l_x_ct: TLabel;
    l_y_ct: TLabel;
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    l_tr_ct_y: TLabel;
    l_tr_ct_x: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    l_tr_area: TLabel;
    Image1: TImage;
    Label24: TLabel;
    cb_tr_cut: TCheckBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    E1: TEdit;
    e2: TEdit;
    e4: TEdit;
    e5: TEdit;
    e7: TEdit;
    e3: TEdit;
    e6: TEdit;
    sb1: TSpinButton;
    sb2: TSpinButton;
    sb4: TSpinButton;
    sb5: TSpinButton;
    sb3: TSpinButton;
    sb6: TSpinButton;
    sb7: TSpinButton;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GroupBoxMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure b_analizClick(Sender: TObject);
    procedure b_analizMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure cb_tr_cutClick(Sender: TObject);
    procedure cb_rec_cutClick(Sender: TObject);
    procedure cb_kr_cutClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EKeyPress(Sender: TObject; var Key: Char);
    procedure sbClick(Sender: TObject; dr:integer);
    procedure sbDownClick(Sender: TObject);
    procedure sbUpClick(Sender: TObject);
    procedure E1exit(Sender: TObject);
    procedure E3exit(Sender: TObject);
    procedure E1Enter(Sender: TObject);
    procedure FormShow(Sender: TObject);
  end;
var
  lab_1     : Tlab_1;
                          implementation
uses osnowa_u, lab_1_win_error_u;
{===================   глобальные константы   ==========================}
const
      pole_x1      = 30;
      pole_y1      = 80;       // координаты поля перемещения фигур
      pole_x2      = 560;
      pole_y2      = 400;
      color_norm   = clblue; // цвет НЕ вырезаемой фигуры
      color_cut    = clwhite;// цвет вырезанной фигуры
      koord        = 4;      // показывает сколько пикселей содержится в 1 мм.
      turn_norm_st     = 'Поворот произведён.';
      error_turn_st    = 'Поворот фигуры невозможен так как её вершины могут выйти за пределы поля перемещения фигур. Измените размеры фигуры.';
      error_new_size_st= 'Увеличение размеров фигуры невозможно так как одна или несколько её вершин могут выйти за пределы поля перемещения фигур.';
      mousein_pole_st  = 'С помощью мыши вы можете перемещать фигуры.';
      mousein_panel_st = 'Вы можете изменить размеры ';
      mousein_b_analiz = 'Рассчитать центр тяжести составленной плоской фигуры.';

{==============    опиисание объектов    =================================}
type
//  =========   координаты мыши   =========
  mouse_koord = record
    x,y:word;
  end;
//  =========   vfigure   ================
  vfigure = object
  public
    ct     :array [1..2] of real;      // центр тяжести. взят тип real т.к. в треугольнике ct может быть дробным
    aktive :boolean;                   // если true значит фигура перемещается
    procedure mouse_up;                // обрабатывается отпускание фигуры
  end;

//  =========   VTriagle   ================
{ Во всех фигурах координаты вершин с типом real т.к. при повороте фигуры
  необходимо учитывать дробную часть иначе координаты вершин будут смещатся }
  VTriagle = object (vfigure)
  private
    procedure draw(col:tcolor);         // рисует фигуру определённым цветом
  public
    t : array[1..3,1..2] of real;       // координаты вершин треугольника
    ug:integer;                         // угол на который повёрнут треуг.
    constructor init(x,y,o,h:word);             // создание фигуры
    procedure show;                             // прорисовка фигуры
    procedure hide;                             // скрытие фигуры
    function  move(x,y:integer):boolean;  // перемещение фигуры
    function  turn(q:integer):boolean;          // поворот фигуры
    procedure print_ct;                         // печать координат треугольника
    function  new_size(o, h:integer):boolean;   // задание новых размеров треугольника
    function  print_area:real;                  // возвращает и печатает площади
    function  belong(x,y:integer):boolean;      // определяет принадлежность точки к треуг.
  end;

//  =========   vrectangle  ================
  VRectangle = object (vfigure)
  private
    procedure draw(col:tcolor);                 // рисует фигуру определённым цветом
  public
    t: array[1..4,1..2] of real;                // кординаты вершин
    ug:integer;                                 // угол на который повёрнут rec
    constructor init(x,y,a,b:word);             // создание фигуры
    procedure show;                             // прорисовка фигуры
    procedure hide;                             // скрытие фигуры
    function  move(x,y:integer):boolean;        // перемещение фигуры
    function  turn(q:integer):boolean;          // поворот фигуры
    procedure print_ct;                         // печать координат ct
    function  new_size(a, b:integer):boolean;   // задание новых размеров
    function  print_area:real;                  // возвращает и печатает площади
    function  belong(x,y:integer):boolean;      // определяет принадлежность точки к прямоуг.
  end;

//  =========   VKrug   ================
  VKrug = object (vfigure)
  public
    r :word;                                    // радиус
    constructor init(x,y,d:word);               // создание фигуры
    procedure show;                             // прорисовка фигуры
    procedure hide;                             // скрытие фигуры
    function  move(x,y:integer):boolean;        // перемещение фигуры
    procedure print_ct;                         // печать координат ct
    function  new_size(d:integer):boolean;      // задание новых размеров
    function  print_area:real;                  // возвращает и печатает площади
    function  belong(x,y:integer):boolean;      // определяет принадлежность точки к кругу.
  end;
{==============     глобальные переменные для данного модуля  =============}
var   tr:VTriagle;
      rec:vrectangle;
      kr:VKrug;
      ind_help  : byte;      // хранится номер текущей записи которая выводится в l_help
      m :mouse_koord;        // координаты мыши, используются при перетаскивании фигуры
      clearpole:boolean;     // если равна TRUE занчит поле надо очищать
{$R *.DFM}
{+--------------------------------------------------------------+}
{|               Начало программы                               |}
{+--------------------------------------------------------------+}
procedure clear_pole;
  begin
    if clearpole then begin
       lab_1.Canvas.pen.Color:=clbtnface;    // очишаем поле
       lab_1.Canvas.brush.Color:=clbtnface;
       lab_1.Canvas.Rectangle(pole_x1, pole_y1, pole_x2, pole_y2);
       tr.show;
       rec.show;                            // перерисовываем фигуры
       kr.show;
       lab_1.Panel1.Visible:=false;
       clearpole:=false;                    // поле очищенно
    end;
  end;
//================================================================================
procedure print_help(st:string; ind:integer; col:tcolor);
  begin
     lab_1.l_help.font.Color:=col;
     lab_1.l_help.Caption:=st;     // вывод информации
     ind_help:=ind;
  end;
//================================================================================
// функция выдаёт true если точка X Y лежит в облости X1 Y1 X2 Y2
function pointin(x1, y1, x2, y2, mx, my :real):boolean;
  begin
    pointin:=false;
    if (mx>=x1)and(mx<=x2)and(my>=y1)and(my<=y2) then
       pointin:=true;
  end;
//================================================================================
// если можно то здвигает фигуру чтобы она не вылезла за поле и выдаёт TRUE
function figure_in_pole(var n_t; kolwo_point:byte; var n_ct):boolean;
  var new_t  :array [1..4,1..2] of real absolute n_t;
      new_ct :array [1..2] of real absolute n_ct;
      i      :integer;
      max_x, max_y, min_x, min_y:real;
//================================================================================
// сдвиг координат на X Y чтобы фигура не выехала за поле
  procedure inc_new_t(x,y:integer);
    var j:integer;
    begin
      for j:=1 to kolwo_point do begin
         new_t[j,1]:=new_t[j,1]+x;
         new_t[j,2]:=new_t[j,2]+y;
      end;
      new_ct[1]:=new_ct[1]+x;  new_ct[2]:=new_ct[2]+y;
    end;

// figure_in_pole
  begin
    figure_in_pole:=false;
    // выбираем макс и мин для последуюшего сравнения
    max_x:=new_t[1,1];    min_x:=new_t[1,1];
    max_y:=new_t[1,2];    min_y:=new_t[1,2];
    for i:=1 to kolwo_point do begin
        if max_x<new_t[i,1] then max_x:=new_t[i,1];
        if min_x>new_t[i,1] then min_x:=new_t[i,1];
        if max_y<new_t[i,2] then max_y:=new_t[i,2];
        if min_y>new_t[i,2] then min_y:=new_t[i,2];
    end;
    // скольжение фигуры по краям поля если фигура может выйти из поля
    if (max_x>=pole_x2) and (pole_x2-max_x+min_x>=pole_x1)
       then inc_new_t(pole_x2-round(max_x), 0);
    if (min_x<=pole_x1) and (pole_x1-min_x+max_x<=pole_x2)
       then inc_new_t(pole_x1-round(min_x), 0);
    if (max_y>=pole_y2) and (pole_y2-max_y+min_y>=pole_y1)
       then inc_new_t(0, pole_y2-round(max_y));
    if (min_y<=pole_y1) and (pole_y1-min_y+max_y<=pole_y2)
       then inc_new_t(0, pole_y1-round(min_y));
    // проверка фигуры
    if (max_x-min_x<=pole_x2-pole_x1)and(max_y-min_y<=pole_y2-pole_y1)
       then figure_in_pole:=true;
  end;
//================================================================================
// поворот координат
procedure turn_koord(var buf; kolwo_point:byte; ctx, cty:real; q:real);
  var u: array [1..2,1..2] of real;
      new_t: array [1..4,1..2] of real absolute buf;
      p: array [1..2] of real;
      i:byte;
  begin
    q:=(q*pi)/180; // преобразование градусов в радианы
    // заполняем матрицу поворота
    u[1,1]:=cos(q);   u[1,2]:=sin(q);
    u[2,1]:=-sin(q);  u[2,2]:=cos(q);
    {поворот вершин вокруг точки 0,0}
    for i:=1 to kolwo_point do begin
        p[1]:=new_t[i,1] * u[1,1] + new_t[i,2] * u[2,1];
        p[2]:=new_t[i,1] * u[1,2] + new_t[i,2] * u[2,2];
        new_t[i,1]:=p[1];
        new_t[i,2]:=p[2];
    end;
    // смещение координат на ct
    for i:=1 to kolwo_point do begin
        new_t[i,1]:=new_t[i,1]+round(ctx);
        new_t[i,2]:=new_t[i,2]+round(cty);
    end;
  end;   { turn_koord }
//================================================================================
// функция поворота фигур на определённый угол
// buf массив координат фигуры
// kolwo_point количество вершин фигуры
// ctx cty координаты центра тяжести фигуры
// q угол поворота
function turn_fig(var buf; kolwo_point:byte; var ct; q:real):boolean;
  var n_t  :array [1..4,1..2] of real absolute buf;
      n_ct :array [1..2] of real absolute ct;
      i    :integer;
  begin
    turn_fig:=false;
    {смещение всех координат на ct т.к. поворот возможен только в точке 0,0}
    for i:=1 to kolwo_point do begin
        n_t[i,1]:=n_t[i,1]-round(n_ct[1]);
        n_t[i,2]:=n_t[i,2]-round(n_ct[2]);
    end;
    turn_koord(n_t, kolwo_point, n_ct[1], n_ct[2], q); // поворот фигуры
    // проверка не вышла ли фигура за границы при повороте если не вышла
    // мы записываем новые координаты
    if figure_in_pole(n_t, kolwo_point, n_ct) then begin
       clear_pole;   // очищаем поле если нужно
       turn_fig:=true;
    end;
  end;     {turn_fig}
//================================================================================
// задание новых размеров для треугольника и прямоугольника
function new_size_figure(var buf_t; kolwo_point:byte; var buf_ct; ug:integer):boolean;
  var koord:array [1..4,1..2] of real absolute buf_t;
      ct   :array [1..2] of real absolute buf_ct;
  begin
    new_size_figure:=false;
    turn_koord(koord, kolwo_point, ct[1], ct[2], ug);    // поворот фигуры
    if figure_in_pole(koord, kolwo_point, ct) then begin // проверка и сдвиг фигуры
       new_size_figure:=true;
       clear_pole;  // очищаем поле если нужно
    end;
  end;   { new_size_figure }
//================================================================================
// функция выбирает приращение необходиое для передвижения фигуры
function inc_min(var buf_koord; kolwo_point:byte; x1:integer; xy_:byte):integer;
  var t:array [1..4,1..2] of real absolute buf_koord;  // массив координат
      xy, i, pole_xy1, pole_xy2:integer;
  begin
      if xy_=1 then begin    // определяем по какой оси приращение
         pole_xy1:=pole_x1;
         pole_xy2:=pole_x2;
      end else begin
         pole_xy1:=pole_y1;
         pole_xy2:=pole_y2;
      end;

      xy:=round(t[1,xy_]);
      if x1<0 then begin    // определяем напровление движения мыши
         for i:=2 to kolwo_point do   // ищем вершину фигуры ближе всего лежащую
             if xy>t[i,xy_] then  xy:=round(t[i,xy_]);// к линии POLE_x1 или POLE_y1
         if pole_xy1-xy>x1 then x1:=pole_xy1-xy;// выбираем приращение
      end else begin
         for i:=2 to kolwo_point do
             if xy<t[i,xy_] then  xy:=round(t[i,xy_]);
         if pole_xy2-xy<x1 then x1:=pole_xy2-xy;
      end;
      inc_min:=x1;
  end;    {inc_min}
//================================================================================
{функция выдаёт true если точка point и точка zt (центр тяжести фигуры) лежат
 с одной стороны прямой. x1 y1 x2 y2 координаты каких либо двух точек прямой }
{по данной фомуле можно расчитать координату Y точки при известной X   }
{    X*Y1 + X1*Y2 - X2*Y1 - X*Y2 }
{ Y=---------------------------- }
{        X1-X2                   }
{по следующей формуле можно расчитать координату X при известной Y     }
{     X2*Y - X1*Y - X2*Y1 + X1*Y2  }
{   X=---------------------------- }
{             Y2-Y1                }
function point2_line(x1, y1, x2, y2, tx, ty, px, py:integer):boolean;
  label end_;
    {py_- координата Y пересечения линии || оси Y с графиком при х=px
     ty_- координата Y пересечения линии || оси Y c графиком при x=ztx
     px_- координаты Х пересечения линии || оси Х с графиком при y=py
     tx_- координаты Х пересечения линии || оси Х с графиком при y=zty}
  var py_, ty_:integer;
      px_, tx_:integer;
  begin
      point2_line:=false;
      if (tx=px)and(ty=py) then begin point2_line:=true; goto end_; end;
      {если y1=y2 то     ty_=py_=y1=y2   иначе ty_ py_ расчитываем по формулам }
      if y1=y2 then begin
         ty_:=y1-ty;   {ty_ здесь это длина отрезка ty_ ty }
         py_:=y1-py;   {py_ здесь это длина отрезка py_ py }
         if ((py_>=0)and(ty_>0))or((py_<=0)and(ty_<0)) then
            point2_line:=true;
         goto end_;
      end;
      {если x1=x2 то     tx_=px_=x1=x2   иначе tx_ px_ расчитываем по формулам}
      if x1=x2 then begin
         tx_:=x1-tx;
         px_:=x1-px;
         if ((px_>=0)and(tx_>0))or((px_<=0)and(tx_<0)) then
            point2_line:=true;
         goto end_;
      end;
      px_:=round((x2*py - x1*py - x2*y1 + x1*y2) / (y2-y1));
      tx_:=round((x2*ty - x1*ty - x2*y1 + x1*y2) / (y2-y1));
      py_:=round((px*y1 + x1*y2 - x2*y1 - px*y2) / (x1-x2));
      ty_:=round((tx*y1 + x1*y2 - x2*y1 - tx*y2) / (x1-x2));
      py_:= py_ -py;
      ty_:= ty_ -ty;
      px_:= px_ -px;
      tx_:= tx_ -tx;
      //если знаки у py_, ty_ и px_, tx_  одинаковые то значит они лежат с
      //одной стороны прямой, а если разные то с разных сторон прямой
      if (((py_>=0)and(ty_>0))or((py_<=0)and(ty_<0)))and
         (((px_>=0)and(tx_>0))or((px_<=0)and(tx_<0))) then
         point2_line:=true;
      end_:
  end;    { point2_line }
//================================================================================
// функция определяет лежит ли точка на линии
function point_lies_line(x1, y1, x2, y2, x3, y3:integer):boolean;
  begin
    point_lies_line:=false;
    if ((x2-x1)*(y3-y1))-((y2-y1)*(x3-x1))=0 then point_lies_line:=true;
  end;  { point_lies_line }
//================================================================================
// проверка на соприкосновение фигур
function all_figure_abuted:boolean;
  //================================================================================
  procedure win_error(st:string; id_help:integer);    // окно ошибки
    begin
      lab_1_win_error.l_error.Caption:=st;
      lab_1_win_error.help_con:=id_help;
      lab_1_win_error.ShowModal;
    end;    { win_error }
//================================================================================
// фукция пробегает по линии и вызывает специальные функции
// возвращает 0 если точка лежит внутри какой либо фигуры т.е. произошла ошибка
// возвращает 1 если точка лежит на какой либо линии другой фигуры или на периметре круга
// возвращает 2 если текущая точка не соприкосается с какой либо линией другой фигуры
  function prow_line(x1, y1, x2, y2:integer; func:byte):byte;
    var x,y:integer;
    //================================================================================
// проверка вырезанного треугольника
    function prow_tr_cut:byte;
      label end_func_error;
      var fl_tr_kr, fl_tr_rec:boolean;
      begin
        fl_tr_kr:=false;
        fl_tr_rec:=false;

        if kr.belong(x,y) then begin   // если текущая точка линии находится в круге то
           if lab_1.cb_kr_cut.Checked then begin // если круг вырезаемый то ошибка
              win_error('Ошибка при построении.'#10#13'Вырезаемый треугольник не должен лежать внутри вырезаемого круга.',1360);
              prow_tr_cut:=0;          // функция возвратит FALSE
              goto end_func_error;     // переходим на конец функции
           end;
           fl_tr_kr:=true;     // если круг не вырезаемый то выставляем флаг что точка лежит внутри круга т.е. всё нормально
        end;

        if rec.belong(x,y) then begin  // если текущая точка линии находится в прямоуг. то
           if lab_1.cb_rec_cut.Checked then begin  // если прямоуг. вырезаемый то ошибка
              win_error('Ошибка при построении.'#10#13'Вырезаемый треугольник не должен лежать внутри вырезаемого прямоугольника.',1350);
              prow_tr_cut:=0;  // функция возвратит FALSE
              goto end_func_error; // переходим на конец функции
           end;
           fl_tr_rec:=true;     // если прямоуг. не вырезаемый то выставляем флаг что точка лежит внутри круга т.е. всё нормально
        end;

        if (not fl_tr_kr)and(not fl_tr_rec) then begin // если точка не в круге или не в прямоугольнике то ошибка
           win_error('Ошибка при построении.'#10#13'Вырезаемый треугольник должен полностью находится в какой либо фигуре.',1340);
           prow_tr_cut:=0; // функция возвратит FALSE
        end else
        // если вырезаемый треуг. лежит внутри невырезаемого круга или прямоуг.
            prow_tr_cut:=1; // то функция возвращает TRUE

        end_func_error:       // метка на конец функции
      end;  { prow_trnot_cut }
    //====================================================================
    //проверка невырезаемого треугольника
    function prow_tr_not_cut:byte;
      label end_func_error;
      begin
        prow_tr_not_cut:=2;

        if rec.belong(x,y) then begin  // если точка в прямоуг.
           // если точка касается какой либо линии прямоуг. то
           if point_lies_line(round(rec.t[1,1]), round(rec.t[1,2]), round(rec.t[2,1]), round(rec.t[2,2]), x, y)or
              point_lies_line(round(rec.t[2,1]), round(rec.t[2,2]), round(rec.t[3,1]), round(rec.t[3,2]), x, y)or
              point_lies_line(round(rec.t[3,1]), round(rec.t[3,2]), round(rec.t[4,1]), round(rec.t[4,2]), x, y)or
              point_lies_line(round(rec.t[4,1]), round(rec.t[4,2]), round(rec.t[1,1]), round(rec.t[1,2]), x, y)
           then prow_tr_not_cut:=1 // нормальный выход
           else // если точка не лежит на какой либо прямой прямоуг. то
              // если прямоуг. НЕ вырезаемый и точка НЕ лежит в круге то
              if (not lab_1.cb_rec_cut.Checked) and (not kr.belong(x,y)) then begin
                 prow_tr_not_cut:=0;   // функция возвращает FALSE. Выдача окна ошибки
                 win_error('Ошибка при построении.'#10#13'Треугольник не должен лежать в прямоугольнике.',1320);
                 goto end_func_error;   // переход на конец функции
              end;
        end;

        if kr.belong(x,y) then begin  // если точка в круге то
           // если точка на периметре круга то
           if kr.r=round(sqrt(sqr(x-round(kr.ct[1]))+sqr(y-round(kr.ct[2]))))
           then prow_tr_not_cut:=1    // нормальный выход
           else // если точка не лежит на периметре круга то
              // если круг НЕ вырезаемый и точка НЕ лежит в прямоуг. то
              if (not lab_1.cb_kr_cut.Checked) and (not rec.belong(x,y)) then begin
                 prow_tr_not_cut:=0;   // функция возвращает FALSE. Выдача окна ошибки
                 win_error('Ошибка при построении.'#10#13'Треугольник не должен лежать в круге.',1330);
                 goto end_func_error;  
              end;
        end;
        end_func_error:
      end;   { prow_tr_not_cut:boolean }
    //====================================================================
    // проверка вырезанного прямоугольника
    function prow_rec_cut:byte;
      label end_func_error;
      var fl_rec_kr :boolean;
      begin
        fl_rec_kr:=false;

        if kr.belong(x,y) then begin   // если текущая точка линии находится в круге то
           if lab_1.cb_kr_cut.Checked then begin // если круг вырезаемый то ошибка
              win_error('Ошибка при построении.'#10#13'Вырезаемый прямоугольник не должен лежать внутри вырезаемого круга.',1400);
              prow_rec_cut:=0;         // функция возвратит FALSE
              goto end_func_error;     // переходим на конец функции
           end;
           fl_rec_kr:=true;     // если круг не вырезаемый то выставляем флаг что точка лежит внутри круга т.е. всё нормально
        end;

        if (not fl_rec_kr)and(not tr.belong(x,y)) then begin // если точка не в круге или не в треуг. то ошибка
           win_error('Ошибка при построении.'#10#13'Вырезаемый прямоугольник должен полностью находится в какой либо фигуре.',1390);
           prow_rec_cut:=0;      // функция возвратит FALSE
        end else
        // если вырезаемый прямоуг. лежит внутри невырезаемого круга или треуг.
           prow_rec_cut:=1;      // то функция возвращает TRUE
        end_func_error:          // метка на конец функции
      end;  { prow_rec_cut }
    //====================================================================
    //проверка невырезаемого прямоугольника
    function prow_rec_not_cut:byte;
      begin
        prow_rec_not_cut:=2;

        // если точка в теруг. то возыращаем TRUE
        // здесь нет необходимости проверять ошибку как ниже c кругом т.к. эта проверка есть в треугольнике
        if tr.belong(x,y) then
           if (tr.belong(round(rec.ct[1]), round(rec.ct[2])))and(not kr.belong(x,y)) then begin
               prow_rec_not_cut:=0;   // функция возвращает FALSE. Выдача окна ошибки
               win_error('Ошибка при построении.'#10#13'Треугольник не должен лежать в прямоугольнике.',1320);
           end else prow_rec_not_cut:=1;

        if kr.belong(x,y) then begin  // если точка в круге то
           // если точка на периметре круга то
           if kr.r=round(sqrt(sqr(x-round(kr.ct[1]))+sqr(y-round(kr.ct[2]))))
           then prow_rec_not_cut:=1 // нормальный выход
           else // если точка не лежит на периметре круга то
              // если круг НЕ вырезаемый и точка НЕ лежит в треуг. то
              if (not lab_1.cb_kr_cut.Checked) and (not tr.belong(x,y)) then begin
                 prow_rec_not_cut:=0;   // функция возвращает FALSE. Выдача окна ошибки
                 win_error('Ошибка при построении.'#10#13'Прямоугольник не должен лежать в круге.',1380);
              end;
        end;
      end;   { prow_rec_cut:boolean }
    //===================================================================================
    { prow_line }
    var i,deltax,deltay,numpixels,d:integer;
        dinc1,dinc2,xinc1,xinc2,yinc1,yinc2:integer;
        quit,q:byte;
    begin
      quit:=2;                // а здесь начинается алгоритм Брозенхема
      deltax:=abs(x2-x1);
      deltay:=abs(y2-y1);
      if deltax>=deltay then begin
         numpixels:=deltax+1;      {x-независимая переменная}
         d:=(2*deltay)-deltax;
         dinc1:=deltay * 2;
         dinc2:=(deltay-deltax)*2;
         xinc1:=1;
         xinc2:=1;
         yinc1:=0;
         yinc2:=1;
      end else begin
         numpixels:=deltay+1;      {y-независимая переменная}
         d:=(2*deltax)-deltay;
         dinc1:=deltax *2;
         dinc2:=(deltax-deltay)*2;
         xinc1:=0;
         xinc2:=1;
         yinc1:=1;
         yinc2:=1;
      end;
      if x1>x2 then begin  {убедиться, что x и y перемещаются в правильном направлении}
         xinc1:=-xinc1;
         xinc2:=-xinc2;
      end;
      if y1>y2 then begin
         yinc1:=-yinc1;
         yinc2:=-yinc2;
      end;
      x:=x1;  y:=y1;  i:=1;                      {начать рисование в <x1,y1>}
      repeat
          {вызов функций}
          if func=1 then begin                                // вызов функций треугольника
             if lab_1.cb_tr_cut.Checked then q:=prow_tr_cut   // проверка линии вырезаемого треугольника
             else q:=prow_tr_not_cut;                         // проверка линии не вырезаемого треугольника
          end else begin                                      // вызов функций прямоугольника
             if lab_1.cb_rec_cut.Checked then q:=prow_rec_cut // проверка линии вырезаемого прямоугольника
             else q:=prow_rec_not_cut;                        // проверка линии не вырезаемого прямоугольника}
          end;
          if q<quit then quit:=q; // при quit=0 пойдем на аварийный выход
          if d<0 then begin
             d:=d+dinc1;
             x:=x+xinc1;
             y:=y+yinc1;
          end else begin
             d:=d+dinc2;
             x:=x+xinc2;
             y:=y+yinc2;
          end;
          inc(i);
      until (i=numpixels)or(quit=0);
      prow_line:=quit;
    end;   { prow_line }
  //==================================================================================
// проверка треугольника
  function test_tr:boolean;
    var s:array [1..3]of byte;
        j,a:byte;
    begin
      test_tr:=true;
      for a:=1 to 3 do begin    // i нужно записи в него прошлого результата
          s[a]:=0;              // и проверки если он равен 0 то дальше можно
          j:=a+1;               // не провераять
          if j=4 then j:=1;
          s[a]:=prow_line(round(tr.t[a,1]), round(tr.t[a,2]), round(tr.t[j,1]), round(tr.t[j,2]), 1);
          if s[a]=0 then begin test_tr:=false; break; end;
      end;
      // если треуг. не соприкасается не с одной фигурой и если хоть
      // одна НЕ вырезаемая фигура лежит вне треуг. то ошибка
      if ((s[1]=2)and(s[2]=2)and(s[3]=2))and
         (not tr.belong(round(rec.ct[1]), round(rec.ct[2])))and // здесь достаточно проверить центры тяжести
         (not tr.belong(round(kr.ct[1]), round(kr.ct[2])))      // других фигур т.к. если ц.т. фигуры лежит внутри треуг.
         then begin                                             // то значит вся фигура лежит в треуг. иначе была бы выданна ошибка
         test_tr:=false;
         win_error('Ошибка при построении.'#10#13'Треугольник должен соприкасаться с какой либо фигурой.',1310);
      end;
    end;   { test_tr }
  //===================================================================================
// проверка прямоугольника
  function test_rec:boolean;
    var s:array [1..4]of byte;
        j,a:byte;
    begin
      test_rec:=true;
      for a:=1 to 4 do begin
          s[a]:=0;
          j:=a+1;
          if j=5 then j:=1;
          s[a]:=prow_line(round(rec.t[a,1]), round(rec.t[a,2]), round(rec.t[j,1]), round(rec.t[j,2]), 2);
          if s[a]=0 then begin test_rec:=false; break; end;
      end;
      //если прямоуг. не касается какой либо фигуры то
      if (s[1]=2)and(s[2]=2)and(s[3]=2)and(s[4]=2)and      // более подробные
         (not rec.belong(round(tr.ct[1]), round(tr.ct[2])))and // обьяснения в такойже
         (not rec.belong(round(kr.ct[1]), round(kr.ct[2])))    // функ треугольника
         then begin
         test_rec:=false;       // возвращаем FALSE и выдаем ошибку
         win_error('Ошибка при построении.'#10#13'Прямоугольник должен соприкасаться с какой либо фигурой.',1370);
      end;
    end;   { test_rec }
   //=========================================================================
// проверка круга
  function test_kr:boolean;
    label end_test_error;
    var x,y,i:integer;
        fl_kr_tr, fl_kr_rec :boolean;    // если точка лежит в треуг. или прямоуг. то TRUE
    begin
       test_kr:=true;
       fl_kr_tr:=false;
       fl_kr_rec:=false;

       for i:=1 to 360 do begin  // пробегаем по всему кругу
           x:=round(kr.ct[1])+round(sin(i*pi/180)*kr.r);
           y:=round(kr.ct[2])+round(cos(i*pi/180)*kr.r);

           if lab_1.cb_kr_cut.Checked then begin // Круг вырезаемый

              // если текущая точка вырезаемого круга не входит в
              // прямоугольник или треугольник то выдаём ошибку и выходим
              if (not tr.belong(x,y))and(not rec.belong(x,y)) then begin
                 win_error('Ошибка при построении.'#10#13'Вырезаемый круг должен полностью находится в какой либо фигуре.',1420);
                 test_kr:=false;                 // процедура выдаёт ошибку
                 goto end_test_error;            // и переходит к выходу
              end;
   // НЕ ВЫРЕЗАЕМЫЙ круг
           end else begin

              if tr.belong(x,y) then begin  // если точка в треугольнике то
                 if (tr.belong(round(kr.ct[1]), round(kr.ct[2])))and(not rec.belong(x,y)) then begin
                    test_kr:=false;  // функция возвращает FALSE. Выдача окна ошибки
                    win_error('Ошибка при построении.'#10#13'Треугольник не должен лежать в круге.',1330);
                    goto end_test_error;
                 end;
                 fl_kr_tr:=true; // выставляем флаг что круг касается треуг.
                 break;          // прерываем цикл
              end;

              if rec.belong(x,y) then begin // если точка в прямоуг. то
                 if (rec.belong(round(kr.ct[1]), round(kr.ct[2])))and(not tr.belong(x,y)) then begin
                    test_kr:=false;  // функция возвращает FALSE. Выдача окна ошибки
                    win_error('Ошибка при построении.'#10#13'Прямоугольник не должен лежать в круге.',1380);
                    goto end_test_error;
                 end;
                 fl_kr_rec:=true; // выставляем флаг что круг касается прямоуг.
                 break;          // прерываем цикл
              end;

           end;
       end;// END FOR

       // если круг НЕ вырезаемый и он не касается какой либо фигуры и
       // если фигуры не лежат в круге то ошибка. Более подробно TEST_TR
       if (not lab_1.cb_kr_cut.Checked)and(not fl_kr_tr)and(not fl_kr_rec)and
          (not kr.belong(round(tr.ct[1]), round(tr.ct[2])))and
          (not kr.belong(round(rec.ct[1]), round(rec.ct[2])))
          then begin
          test_kr:=false;  // функция возвращает FALSE. Выдача окна ошибки
          win_error('Ошибка при построении.'#10#13'Круг должен соприкасаться с какой либо фигурой.',1410);
       end;
       end_test_error:
    end;   { test_kr }

{ all_figure_abuted    всели фигуры соприкосаются }
  var test:boolean;
  begin
    test:=test_tr;                  // проверка треугольника
    if test then test:=test_rec;    // проверка прямоугольника
    if test then test:=test_kr;     // проверка круга
    all_figure_abuted:=test;        // выдача результата проверки
  end;   { all_figure_abuted    всели фигуры соприкосаются }

//=========================================================================
procedure paint_koord_line; // прорисовка осей координат
  var i:integer;
  begin
    with lab_1.Canvas do begin
       Pen.color:=clblack;
       brush.Style:=bsclear;
       moveto(pole_x1-1, pole_y1-1);    // прорисовываем поле перемещения фигур
       rectangle(pole_x1-1, pole_y1-1, pole_x2+2, pole_y2+2);
       for i:=1 to 13 do begin          // рисуем штрихи и цифры на оси Х
           moveto(pole_x1+i*10*koord, pole_y2+1);
           lineto(pole_x1+i*10*koord, pole_y2+4);
           textout(pole_x1+i*10*koord-3, pole_y2+5, inttostr(i));
       end;
       for i:=1 to 8 do begin           // рисуем штрихи и цифры на оси Y
           moveto(pole_x1-3, pole_y2-i*10*koord);
           lineto(pole_x1, pole_y2-i*10*koord);
           textout(pole_x1-20, pole_y2-i*10*koord-5, inttostr(i));
       end;
    end;
  end;     {paint_koord_line}

{+----------------------------------------------------------------+}
{|                     VFigure                                    |}
{+----------------------------------------------------------------+}
procedure vfigure.mouse_up;      // отпускание фигуры
  begin
    if aktive then aktive:=false; // опускаем флаг захвата фигуры
  end;    //vfigure.mouse_up

{+----------------------------------------------------------------+}
{|                     VTriagle                                   |}
{+----------------------------------------------------------------+}
constructor VTriagle.init(x, y, o, h :word);
  var h1,h2:integer;
  begin
    o:=round((o/2)*koord);
    h:=h*koord;
    h1:=round(h*2/3);// 0.66666666667 отношение h1/h
    h2:=h-h1;                  // h1 это растояние по y от cty до t[3,2]
    t[1,1]:=round(x-o);        // h2 это растояние по y от cty до t[1,2] и t[2,2]
    t[1,2]:=round(y-h2);
    t[2,1]:=round(x+o);
    t[2,2]:=round(y-h2);
    t[3,1]:=round(x);
    t[3,2]:=round(y+h1);
    ct[1]:=(t[1,1]+t[2,1]+t[3,1])/3;
    ct[2]:=(t[1,2]+t[2,2]+t[3,2])/3;
    aktive:=false;
    ug:=0;
  end;      //VTriagle.init
//=========================================================================
procedure VTriagle.show;
  var c:tcolor;
  begin
    if lab_1.cb_tr_cut.Checked
       then c:=color_cut   // если фигура вырезается то
       else c:=color_norm; // выводим её соответствующим цветом
    draw(c);
  end;    //VTriagle.show
//=========================================================================
procedure VTriagle.hide;
  begin
    draw(clbtnface);
  end;    //VTriagle.hide
//=========================================================================
function VTriagle.move(x,y:integer):boolean;
  var x1, y1, i :integer;
  begin
    move:=false;
    if aktive and (x>=0) and (y>=0) then begin
       if (x<>m.x)or(y<>m.y) then begin
          x1:=(x-m.x);
          y1:=(y-m.y);
          if x1<>0 then begin
             // выбираем минимальное приращение т.е.насколько
             // нарастить координаты, на сколько передвинулась мыш
             // или на растояние которое осталось до границы поля
             // это необходимо чтобы фигура какбы скользила по границы
             x1:=inc_min(t, 3, x1, 1);
             m.x:=x;    // обновляем m
          end;
          // сравниваем приращение координат по оси Y
          // расчёт такойже как по Х
          if y1<>0 then begin
             y1:=inc_min(t, 3, y1, 2);
             m.y:=y;
          end;
          // если фигуру надо сдвигать то сдвигаем
          if (x1<>0)or(y1<>0) then begin
             hide;
             for i:=1 to 3 do begin
                 t[i,1]:=t[i,1]+x1;
                 t[i,2]:=t[i,2]+y1;
             end;
             ct[1]:=ct[1]+x1;  ct[2]:=ct[2]+y1;
             show;           // рисуем новую фигуру
             print_ct;       // печатаем новые координаты
             rec.show;       // прорисовываем другие фигуры
             kr.show;
             move:=true;  // фигура сдвинута
          end;
       end;
    end;
  end;    //VTriagle.move
//=========================================================================
function VTriagle.turn(q:integer):boolean;
  var turn_:boolean;
      i:integer;
      new_t:array [1..3,1..2] of real;
      new_ct:array [1..2] of real;
  begin
    if (q>=-360)and(q<=360) then begin
       q:=-q;             // это чтобы увеличение угла было против часовой стрелки
       q:=q-ug;           // запоминаем угол на который повернута фигура
       for i:=1 to 3 do begin
           new_t[i,1]:=t[i,1];
           new_t[i,2]:=t[i,2];
       end;
       new_ct[1]:=ct[1]; new_ct[2]:=ct[2];
       turn_:=turn_fig(new_t, 3, new_ct, q); // поворачиваем фигуру
       turn:=turn_;
       // если turn_=true  т.е. ни одна из вершин
       // не вышла за пределы поля перемещения фигур то фигура успешно повёрнута
       if turn_ then begin
          hide; // скрываем фигуру
          for i:=1 to 3 do begin  // записываем новые кординаты
              t[i,1]:=new_t[i,1];
              t[i,2]:=new_t[i,2];
          end;
          ct[1]:=new_ct[1];  ct[2]:=new_ct[2];
          show;
          rec.show;          // прорисовка других фигур
          kr.show;
          print_ct;
          print_help(turn_norm_st, -1, clblue);// вывод информации об успешном повороте фигуры
          ug:=ug+q;
       end else
          print_help(error_turn_st, -1, clred);// вывод информации о невозможности поворота фигуры
    end;
  end;    //VTriagle.turn
//=========================================================================
procedure VTriagle.print_ct;
  var st:string;
      i:integer;
  begin
      // печать координат центра тяжести
      st:=floattostr((pole_y2-ct[2])/koord);
      i:=pos(',',st);         // ищем запятую чтобы выводить 2 знака
      st:=copy(st,1,i+2);     // после неё
      lab_1.l_tr_ct_x.Caption:='X = '+floattostr((ct[1]-pole_x1)/koord)+' мм';
      lab_1.l_tr_ct_y.Caption:='Y = '+st+' мм';
  end;  {VTriagle.print_ct}
//=========================================================================
function VTriagle.new_size(o, h:integer):boolean;
  var h1, h2, i:integer;
      new_t    :array [1..3,1..2] of real;
      new_ct   :array [1..2] of real;
  begin
    if (o>=10)and(o<=100)and(h>=10)and(h<=80) then begin
    // изменяем размеры для временного массива в начале координат
       o:=round((o/2)*koord);             //         o                             -
       h:=h*koord;                        //   |<-------->|                        -
       h1:=round(h*2/3);                  //   |          |                        -
       h2:=h-h1;                          //   +----------+----------+  - - - -+   -
       new_t[1,1]:=-o;                    //  t1\         |         /t2        | h2-
       new_t[1,2]:=-h2;                   //     \        |        /           |   -
       new_t[2,1]:=o;                     //      \       *- - - -/- - - - - --+   -
       new_t[2,2]:=-h2;                   //       \      |ct    /             |   -
       new_t[3,1]:=0;                     //        \     |     /              |   -
       new_t[3,2]:=h1;                    //         \    |    /               |   -
       new_ct[1]:=ct[1];  new_ct[2]:=ct[2];

       if new_size_figure(new_t, 3, new_ct, ug) // если фигуру можно повернуть то
       then begin
          hide;
          for i:=1 to 3 do begin                  // записываем новые координаты
              t[i,1]:=new_t[i,1];
              t[i,2]:=new_t[i,2];
          end;
          ct[1]:=new_ct[1];  ct[2]:=new_ct[2];
          show;
          rec.show;
          kr.show;
          print_area;
          print_ct;
          new_size:=true;
       end else begin
          print_help(error_new_size_st, -1, clred); // выводим предупреждения
          new_size:=false;
       end;
    end;
  end;   {VTriagle.new_size}
//=========================================================================
function VTriagle.print_area:real;
  var area_st:string;
      i      :integer;
      area   :real;
  begin
    // расчёт и вывод площади треугольника.
    area:=0.5 * strtoint(lab_1.e1.text) * strtoint(lab_1.e2.text);
    if lab_1.cb_tr_cut.Checked then area:=-area;// если фигура вырезаемая то площадь отрицательная
    print_area:=area;
    area_st:=floattostr(area);
    i:=pos(',', area_st);
    if i<>0 then area_st:=copy(area_st, 1, i+2);
    lab_1.l_tr_area.Caption:=area_st;
  end;    //VTriagle.print_area
//=========================================================================
// определяем входит ли точка в объект
function  VTriagle.belong(x,y:integer):boolean;
  begin
    belong:=false;
    if point2_line(round(t[1,1]), round(t[1,2]), round(t[2,1]), round(t[2,2]),
                   round(ct[1]), round(ct[2]), x, y) and
       point2_line(round(t[2,1]), round(t[2,2]), round(t[3,1]), round(t[3,2]),
                   round(ct[1]), round(ct[2]), x, y) and
       point2_line(round(t[3,1]), round(t[3,2]), round(t[1,1]), round(t[1,2]),
                   round(ct[1]), round(ct[2]), x, y)
    then belong:=true;
  end;    {VTriagle.belong}
//=========================================================================
procedure VTriagle.draw(col:tcolor);
  begin
    with lab_1.Canvas do begin
       Pen.Color:=col;       
       pen.Style:=pssolid;
       MoveTo(round(t[1,1]), round(t[1,2]));
       LineTo(round(t[2,1]), round(t[2,2]));
       LineTo(round(t[3,1]), round(t[3,2]));
       LineTo(round(t[1,1]), round(t[1,2]));
       brush.color:=col;
       brush.style:=bssolid;
       ellipse(round(ct[1]-2), round(ct[2]-2), round(ct[1]+2), round(ct[2]+2));
    end;
  end;    { VTriagle.draw }
{+----------------------------------------------------------------+}
{|                     VRectangle                                 |}
{+----------------------------------------------------------------+}
constructor VRectangle.init(x, y, a, b :word);
  var dx, dy :integer;
  begin
    dx:=round(a/2)*koord;
    dy:=round(b/2)*koord;
    t[1,1]:=x-dx;    t[1,2]:=y-dy;
    t[2,1]:=x+dx;    t[2,2]:=y-dy;         // расчёт координат вершин на основание
    t[3,1]:=x+dx;    t[3,2]:=y+dy;     // координат ct, основания и высоты
    t[4,1]:=x-dx;    t[4,2]:=y+dy;
    ct[1]:=x;        ct[2]:=y;
    aktive:=false;
    ug:=0;
  end;      //VRectangle.init
//=========================================================================
procedure VRectangle.show;
  var c:tcolor;
  begin
    if lab_1.cb_rec_cut.Checked
       then c:=color_cut   // если фигура вырезается то
       else c:=color_norm; // выводим её соответствующим цветом
    draw(c);
  end;    //VRectangle.show
//=========================================================================
procedure VRectangle.hide;
  begin
    draw(clbtnface);
  end;    //VRectangle.hide
//=========================================================================
function VRectangle.move(x,y:integer):boolean;
  var x1, y1, i :integer;
  begin
    move:=false;
    if aktive and (x>=0) and (y>=0) then begin
       if (x<>m.x)or(y<>m.y) then begin
          x1:=(x-m.x);
          y1:=(y-m.y);
          if x1<>0 then begin
             x1:=inc_min(t, 4, x1, 1);
             m.x:=x;
          end;
          if y1<>0 then begin
             y1:=inc_min(t, 4, y1, 2);
             m.y:=y;
          end;
          if (x1<>0)or(y1<>0) then begin
             hide;
             for i:=1 to 4 do begin
                 t[i,1]:=t[i,1]+x1;
                 t[i,2]:=t[i,2]+y1;
             end;
             ct[1]:=ct[1]+x1;   ct[2]:=ct[2]+y1;
             show;
             print_ct;
             tr.show;
             kr.show;
             move:=true;  // фигура сдвинута
          end;
       end;
    end;
  end;    //VRectangle.move
//=========================================================================
function VRectangle.turn(q:integer):boolean;
  var turn_:boolean;
      i:integer;
      new_t:array [1..4,1..2] of real;
      new_ct:array[1..2] of real;
  begin
    if (q>=-360)and(q<=360) then begin
       q:=-q;
       q:=q-ug;
       for i:=1 to 4 do begin
           new_t[i,1]:=t[i,1];
           new_t[i,2]:=t[i,2];
       end;
       new_ct[1]:=ct[1]; new_ct[2]:=ct[2];
       turn_:=turn_fig(new_t, 4, new_ct, q);
       turn:=turn_;
       if turn_ then begin
          hide; // скрываем фигуру
          for i:=1 to 4 do begin  // записываем новые кординаты
              t[i,1]:=new_t[i,1];
              t[i,2]:=new_t[i,2];
          end;
          ct[1]:=new_ct[1];  ct[2]:=new_ct[2];
          show;
          tr.show;
          kr.show;
          print_ct;
          print_help(turn_norm_st, -1, clblue);// вывод информации об успешном повороте фигуры
          ug:=ug+q;
       end else
          print_help(error_turn_st, -1, clred);// вывод информации о невозможности поворота фигуры
    end;
  end;    //VRectangle.turn
//=========================================================================
procedure VRectangle.print_ct;
  begin
      lab_1.l_rec_ct_x.Caption:='X = '+floattostr((ct[1]-pole_x1)/koord)+' мм';
      lab_1.l_rec_ct_y.Caption:='Y = '+floattostr((pole_y2-ct[2])/koord)+' мм';
  end;   {VRectangle.print_ct}
//=========================================================================
function VRectangle.new_size(a, b:integer):boolean;
  var dx, dy, i:integer;
      new_t :array [1..4,1..2] of real;
      new_ct   :array [1..2] of real;
  begin
    if (a>=10)and(a<=100)and(b>=10)and(b<=80) then begin
       dx:=round((a/2)*koord);
       dy:=round((b/2)*koord);
       new_t[1,1]:=-dx;       new_t[1,2]:=-dy;
       new_t[2,1]:=dx;        new_t[2,2]:=-dy;
       new_t[3,1]:=dx;        new_t[3,2]:=dy;
       new_t[4,1]:=-dx;       new_t[4,2]:=dy;
       new_ct[1]:=ct[1];      new_ct[2]:=ct[2];

       if new_size_figure(new_t, 4, new_ct, ug) 
       then begin
          hide;
          for i:=1 to 4 do begin                  // записываем новые координаты
              t[i,1]:=new_t[i,1];
              t[i,2]:=new_t[i,2];
          end;
          ct[1]:=new_ct[1];  ct[2]:=new_ct[2];
          show;
          tr.show;
          kr.show;
          print_area;
          print_ct;
          new_size:=true;
       end else begin
          print_help(error_new_size_st, -1, clred); // выводим предупреждения
          new_size:=false;
       end;
    end;
  end;   {VRectangle.new_size}
//=========================================================================
function VRectangle.print_area:real;
  var area:real;
  begin
    area:=strtoint(lab_1.e4.Text)*strtoint(lab_1.e5.Text);
    if lab_1.cb_rec_cut.Checked then area:=-area;// если фигура вырезаемая то площадь отрицательная
    print_area:=area;
    lab_1.l_rec_area.Caption:=floattostr(area);
  end;    //VRectangle.print_area
//=========================================================================
function  VRectangle.belong(x,y:integer):boolean;
  begin
    belong:=false;
    if point2_line(round(t[1,1]), round(t[1,2]), round(t[2,1]), round(t[2,2]),
                   round(ct[1]), round(ct[2]), x, y) and
       point2_line(round(t[2,1]), round(t[2,2]), round(t[3,1]), round(t[3,2]),
                   round(ct[1]), round(ct[2]), x, y) and
       point2_line(round(t[3,1]), round(t[3,2]), round(t[4,1]), round(t[4,2]),
                   round(ct[1]), round(ct[2]), x, y) and
       point2_line(round(t[4,1]), round(t[4,2]), round(t[1,1]), round(t[1,2]),
                   round(ct[1]), round(ct[2]), x, y)
    then belong:=true;
  end;    {VRectangle.belong}
//=========================================================================
procedure VRectangle.draw(col:tcolor);
  begin
    with lab_1.Canvas do begin
       Pen.color:=col;
       MoveTo(round(t[1,1]), round(t[1,2]));   LineTo(round(t[2,1]), round(t[2,2]));
       LineTo(round(t[3,1]), round(t[3,2]));   LineTo(round(t[4,1]), round(t[4,2]));
       LineTo(round(t[1,1]), round(t[1,2]));
       brush.color:=col;
       brush.style:=bssolid;
       ellipse(round(ct[1]-2), round(ct[2]-2), round(ct[1]+2), round(ct[2]+2));
    end;
  end;    { VRectangle.draw }
{+----------------------------------------------------------------+}
{|                     VKrug                                      |}
{+----------------------------------------------------------------+}
constructor VKrug.init(x, y, d:word);
  begin
    ct[1]:=x;
    ct[2]:=y;
    r:=round(d/2)*koord;
    aktive:=false;
end;      //VKrug.init
//=========================================================================
procedure VKrug.show;
  var c:tcolor;
  begin
    with lab_1.Canvas do begin
       if lab_1.cb_kr_cut.Checked
       then c:=color_cut   // если фигура вырезается то
       else c:=color_norm; // выводим её соответствующим цветом
       pen.color:=c;
       brush.style:=bsclear;
       ellipse(round(ct[1])-r, round(ct[2])-r, round(ct[1])+r+1, round(ct[2])+r+1);
       brush.color:=c;
       brush.style:=bssolid;
       ellipse(round(ct[1]-2), round(ct[2]-2), round(ct[1]+2), round(ct[2]+2));
    end;
  end;    //VKrug.show
//=========================================================================
procedure VKrug.hide;
  begin
    with lab_1.Canvas do begin
       Pen.color:=clBtnFace;
       brush.style:=bsclear;
       ellipse(round(ct[1]-r), round(ct[2]-r), round(ct[1]+r+1), round(ct[2]+r)+1);
       brush.color:=clBtnFace;
       brush.style:=bssolid;
       ellipse(round(ct[1]-2), round(ct[2]-2), round(ct[1]+2), round(ct[2]+2));
    end;
  end;    //VKrug.hide
//=========================================================================
// перемещение фигуры
function VKrug.move(x,y:integer):boolean;
  var x1, y1 :integer;
      x2, y2 :integer;
  begin
    move:=false;
    if aktive and (x>=0) and (y>=0) then begin
       if (x<>m.x)or(y<>m.y) then begin
          x1:=(x-m.x);
          y1:=(y-m.y);
          if x1<>0 then begin
             if x1<0 then begin
                x2:=round(ct[1])-r;
                if pole_x1-x2>x1 then x1:=pole_x1-x2;
             end else begin
                x2:=round(ct[1])+r;
                if pole_x2-x2<x1 then x1:=pole_x2-x2;
             end;
             m.x:=x;
          end;
          if y1<>0 then begin
             if y1<0 then begin
                y2:=round(ct[2])-r;
                if pole_y1-y2>y1 then y1:=pole_y1-y2;
             end else begin
                y2:=round(ct[2])+r;
                if pole_y2-y2<y1 then y1:=pole_y2-y2;
             end;
             m.y:=y;
          end;
          if (x1<>0)or(y1<>0) then begin
             hide;
             ct[1]:=ct[1]+x1;  ct[2]:=ct[2]+y1;
             show;
             print_ct;
             tr.show;
             rec.show;
             move:=true;  // фигура сдвинута
          end;
       end;
    end;
  end;    //VKrug.move
//=========================================================================
procedure VKrug.print_ct;
  begin
    lab_1.l_kr_ct_x.Caption:='X = '+floattostr((ct[1]-pole_x1)/koord)+' мм';
    lab_1.l_kr_ct_y.Caption:='Y = '+floattostr((pole_y2-ct[2])/koord)+' мм';
  end;    {VKrug.print_ct}
//=========================================================================
function VKrug.new_size(d:integer):boolean;
  var r_:integer;
  begin
    if (d>=10)and(d<=80) then begin
       r_:=round((d*koord)/2);  // определяем радиус из диаметра
       hide;
       // наращивание или уменьшение координаты ct чтобы kr был в пределах поля
       if ct[1]-r_<pole_x1 then ct[1]:=ct[1]+(r_-ct[1]+pole_x1);
       if ct[1]+r_>pole_x2 then ct[1]:=ct[1]-(r_+ct[1]-pole_x2);
       if ct[2]-r_<pole_y1 then ct[2]:=ct[2]+(r_-ct[2]+pole_y1);
       if ct[2]+r_>pole_y2 then ct[2]:=ct[2]-(r_+ct[2]-pole_y2);
       r:=r_;
       show;
       tr.show;
       rec.show;
       print_ct;
       print_area;
       clear_pole;
       new_size:=true;
    end else new_size:=false;
  end;    {VKrug.new_size}
//=========================================================================
function VKrug.print_area:real;
  var area_st:string;
      i      :integer;
      area   :real;
  begin
    area:=pi*sqr(strtoint(lab_1.e7.text)/2);
    if lab_1.cb_kr_cut.Checked then area:=-area;// если фигура вырезаемая то площадь отрицательная    
    print_area:=area;
    area_st:=floattostr(area);          // площадь S=PI * D/2
    i:=pos(',', area_st);
    if i<>0 then  area_st:=copy(area_st, 1, i+2);
    lab_1.l_kr_area.Caption:=area_st;
  end;    //VKrug.print_area
//=========================================================================
function  VKrug.belong(x,y:integer):boolean;
  begin
    if r>=round(sqrt(sqr(x-round(ct[1]))+sqr(y-round(ct[2]))))
       then belong:=true
       else belong:=false;
  end;    //VKrug.belong
//=========================================================================
{+--------------------------------------------------------------+}
{|               Процедуры к данной форме                       |}
{+--------------------------------------------------------------+}
procedure Tlab_1.FormPaint(Sender: TObject);
begin
    paint_koord_line;             // прорисовка координатных осей
    tr.show;
    rec.show;                     // прорисовка объектов
    kr.show;
    clearpole:=true;
    clear_pole;
end;
//=========================================================================
procedure Tlab_1.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var p:byte;
    a:real;
begin
  p:=0;
  a:=10000;
  if tr.belong(x,y) then begin
     p:=1;
     a:=abs(tr.print_area);
  end;
  if (rec.belong(x,y))and(a>=abs(rec.print_area)) then begin
     p:=2;
     a:=abs(rec.print_area);
  end;
  if (kr.belong(x,y))and(a>=abs(kr.print_area)) then
     p:=3;
  if p<>0 then begin
     m.x:=x;
     m.y:=y;
     if p=1 then tr.aktive:=true;
     if p=2 then rec.aktive:=true;
     if p=3 then kr.aktive:=true;
  end;
  clear_pole;         //если щелкнули по полю то очищаем поле если надо
end;
//=========================================================================
procedure Tlab_1.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
label end_;
begin
  if pointin(pole_x1, pole_y1, pole_x2, pole_y2, x, y) then begin
    if ind_help<>1 then print_help(mousein_pole_st, 1, clblue);     // вывод информации
  end else print_help('', 0, clblue);
  if tr.move(x,y) then goto end_;   // переход необходим чтобы не
  if rec.move(x,y) then goto end_;  // брать две фигуры одновременно
  kr.move(x,y);
  end_:
end;
//=========================================================================
procedure Tlab_1.FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  tr.mouse_up;
  rec.mouse_up;
  kr.mouse_up;
end;
//=========================================================================
procedure Tlab_1.GroupBoxMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var b:byte;
    st:string;
begin
  b:=strtoint((sender as tgroupbox).name[9]);
  if ind_help<>(b+1) then begin
     case b of
       1 : st:='или угол поворота треугольника.';
       2 : st:='или угол поворота прямоугольника.';
       3 : st:='круга.';
     end;
     print_help(mousein_panel_st+st, b+1, clblue);
  end;
end;
//=========================================================================
procedure Tlab_1.b_analizMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if ind_help<>5 then print_help(mousein_b_analiz, 5, clblue);
end;
//=========================================================================
procedure Tlab_1.b_analizClick(Sender: TObject);
  //=========================================================================
  procedure set_color(col:tcolor);
    begin
      lab_1.Canvas.pen.Color:=col;
      lab_1.Canvas.brush.Color:=col;
    end;    { set_color }
  //=========================================================================
  procedure paint_tr;
    var col:tcolor;
    begin
      if lab_1.cb_tr_cut.Checked then col:=clbtnface
      else col:=color_norm;
      set_color(col);
      lab_1.canvas.polygon([point(round(tr.t[1,1]), round(tr.t[1,2])),
                            point(round(tr.t[2,1]), round(tr.t[2,2])),
                            point(round(tr.t[3,1]), round(tr.t[3,2]))]);
    end;    { paint_tr }
  //=========================================================================
  procedure paint_rec;
    var col:tcolor;
    begin
      if lab_1.cb_rec_cut.Checked then col:=clbtnface
      else col:=color_norm;
      set_color(col);
      lab_1.canvas.polygon([point(round(rec.t[1,1]), round(rec.t[1,2])),
                            point(round(rec.t[2,1]), round(rec.t[2,2])),
                            point(round(rec.t[3,1]), round(rec.t[3,2])),
                            point(round(rec.t[4,1]), round(rec.t[4,2]))]);
    end;   { paint_rec }
  //=========================================================================
  procedure paint_kr;
    var col:tcolor;
    begin
      if lab_1.cb_kr_cut.Checked then col:=clbtnface
      else col:=color_norm;
      set_color(col);
      lab_1.canvas.ellipse(round(kr.ct[1])-kr.r, round(kr.ct[2])-kr.r,
                           round(kr.ct[1])+kr.r+1, round(kr.ct[2])+kr.r+1);
    end;    { paint_kr }
{ b_analizClick }
var tr_area, rec_area, kr_area:real;
    x,y:real;
    st:string;
    i:integer;
begin
  if all_figure_abuted then begin   // проверка на соприкасание фигур
     tr_area:=abs(tr.print_area);
     rec_area:=abs(rec.print_area);
     kr_area:=abs(kr.print_area);
     lab_1.canvas.brush.Style:=bssolid;
  // максимальная площадь
     // если площадь треуг. больше прямоуг. и круга то рисуем его
     if (tr_area>=rec_area)and(tr_area>=kr_area) then paint_tr
        else // если площадь прямоуг. больше круга то вырисовываем прямоуг. иначе круг
             if rec_area>=kr_area then paint_rec
                else paint_kr;
  // средняя площадь
     if ((tr_area>=rec_area)and(tr_area<=kr_area))or((tr_area<=rec_area)and(tr_area>=kr_area))
        then paint_tr
        else
            if ((rec_area>=kr_area)and(rec_area<=tr_area)or(rec_area<=kr_area)and(rec_area>=tr_area))
               then paint_rec
               else paint_kr;
  // минимальная площадь
     if (tr_area<=rec_area)and(tr_area<=kr_area) then paint_tr
        else // если площадь прямоуг. больше круга то вырисовываем прямоуг. иначе круг
             if rec_area<=kr_area then paint_rec
                else paint_kr;
   // рисуем все центры тяжести
     set_color(clwhite);
     lab_1.Canvas.ellipse(round(kr.ct[1])-2, round(kr.ct[2])-2, round(kr.ct[1])+2, round(kr.ct[2])+2);
     lab_1.Canvas.ellipse(round(rec.ct[1])-2, round(rec.ct[2])-2, round(rec.ct[1])+2, round(rec.ct[2])+2);
     lab_1.Canvas.ellipse(round(tr.ct[1])-2, round(tr.ct[2])-2, round(tr.ct[1])+2, round(tr.ct[2])+2);
   // вычисляем координаты центра тяжести всей фигуры
     tr_area:=tr.print_area;
     rec_area:=rec.print_area;
     kr_area:=kr.print_area;
     x:=(tr_area*tr.ct[1]+rec_area*rec.ct[1]+kr_area*kr.ct[1])/(tr_area+rec_area+kr_area);
     y:=(tr_area*tr.ct[2]+rec_area*rec.ct[2]+kr_area*kr.ct[2])/(tr_area+rec_area+kr_area);
   // рисуем ц.т.
     set_color(clred);
     lab_1.Canvas.ellipse(round(x)-2, round(y)-2, round(x)+2, round(y)+2);
   // преобразовываем и печатаем кординаты
     st:=floattostr((x-pole_x1)/koord);
     i:=pos(',',st);
     st:=copy(st, 1, i+2);
     l_x_ct.Caption:=st+' мм';

     st:=floattostr((pole_y2-y)/koord);
     i:=pos(',',st);
     st:=copy(st, 1, i+2);
     l_y_ct.Caption:=st+' мм';

     panel1.Visible:=true;
     clearpole:=true;				// поле необходимо очистить
  end;
end;
//=========================================================================
procedure Tlab_1.cb_tr_cutClick(Sender: TObject);
begin                    // треугольник вырезаемый
  tr.show;
  if cb_tr_cut.Checked and cb_rec_cut.Checked // если треуг. и какая либо
     then cb_kr_cut.enabled:=false               // другая фигура вырезаемые
     else cb_kr_cut.enabled:=true;               // то третья фигура не может
  if cb_tr_cut.Checked and cb_kr_cut.Checked  // быть вырезаемой
     then cb_rec_cut.enabled:=false else cb_rec_cut.enabled:=true;
  clear_pole;
  tr.print_area;
end;
//=========================================================================
procedure Tlab_1.cb_rec_cutClick(Sender: TObject);
begin                    // прямоугольник вырезаемый
  rec.show;
  if cb_rec_cut.Checked and cb_kr_cut.Checked
     then cb_tr_cut.enabled:=false else cb_tr_cut.enabled:=true;
  if cb_rec_cut.Checked and cb_tr_cut.Checked
     then cb_kr_cut.enabled:=false else cb_kr_cut.enabled:=true;
  clear_pole;
  rec.print_area;
end;
//=========================================================================
procedure Tlab_1.cb_kr_cutClick(Sender: TObject);
begin                    // круг вырезаемый
  kr.show;
  if cb_kr_cut.Checked and cb_rec_cut.Checked
     then cb_tr_cut.enabled:=false else cb_tr_cut.enabled:=true;
  if cb_kr_cut.Checked and cb_tr_cut.Checked
     then cb_rec_cut.enabled:=false else cb_rec_cut.enabled:=true;
  clear_pole;
  kr.print_area;
end;
//=========================================================================
procedure Tlab_1.HelpClick(Sender: TObject);
begin
  application.Helpcontext(100);
end;
//=========================================================================
procedure Tlab_1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  osnowa.ol1.enabled:=true;
  lab_1_win_error.free;          // удаляем форму ошибок
  action:=cafree;
end;
//=========================================================================
procedure Tlab_1.FormCreate(Sender: TObject);
var i:integer;
begin
  lab_1_win_error:=tlab_1_win_error.create(application); // создаем форму вывода ошибок
  i:=(pole_x2-pole_x1) div 2;
  tr.init(100, i, 10, 10);
  rec.init(200, i, 10, 10);
  kr.init(300, i, 10);
  clearpole:=false;
end;
//=========================================================================
procedure Tlab_1.EKeyPress(Sender: TObject; var Key: Char);
var b:byte;
begin
  if key=#13 then begin
     b:=strtoint((sender as tedit).name[2]);
     if b=7 then b:=0;
     (findcomponent('e'+inttostr(b+1)) as tedit).setfocus;
  end;
  if not(key in ['0'..'9',#8,'-']) then begin key:=#0; beep; end;
  if (not((sender as tedit).name[2] in ['3','6']))and(key='-') then
     begin key:=#0; beep; end;
end;
//=========================================================================
procedure Tlab_1.sbClick(Sender: TObject; dr:integer);
var e:tedit;
    b:byte;
    i1,i2:integer;
    r:boolean;
begin
  e:=(findcomponent('e'+(sender as tspinbutton).name[3]) as tedit);
  b:=strtoint(e.name[2]);
  i1:=strtoint(e.text);
  i2:=i1+dr;
  r:=false;
  case b of
    1,4 : begin
                if i2<10 then i2:=10;
                if i2>100 then i2:=100;
                e.Text:=inttostr(i2);
                case b of
                  1 : r:=tr.new_size(i2, strtoint(e2.text));
                  4 : r:=rec.new_size(i2, strtoint(e5.text));
                end;
    end;
    2,5,7 : begin
                if i2<10 then i2:=10;
                if i2>80 then i2:=80;
                e.Text:=inttostr(i2);
                case b of
                  2 : r:=tr.new_size(strtoint(e1.text), i2);
                  5 : r:=rec.new_size(strtoint(e4.text), i2);
                  7 : r:=kr.new_size(i2);
                end;
    end;
    3,6 : begin
                if (i2<-360)or(i2>360) then i2:=0;
                e.Text:=inttostr(i2);
                case b of
                  3 : r:=tr.turn(i2);
                  6 : r:=rec.turn(i2);
                end;
    end;
  end;
  if not r then e.Text:=inttostr(i1);
end;
//=========================================================================
procedure Tlab_1.sbDownClick(Sender: TObject);
begin
  SbClick(sender, -1);
end;
//=========================================================================
procedure Tlab_1.sbUpClick(Sender: TObject);
begin
  SbClick(sender, 1);
end;
//=========================================================================
procedure Tlab_1.E1exit(Sender: TObject);

  function ReturnSize(x1,y1,x2,y2:real):integer;
  begin
    ReturnSize:=round(sqrt(sqr(x2-x1)+sqr(y2-y1))/koord);
  end;

var i:integer;
    e:tedit;
begin
  e:=(sender as tedit);
  if e.Text='' then e.Text:='10';
  i:=strtoint(e.text);
  if i<10 then i:=10;
  case e.name[2] of
    '1','4': begin
      if i>100 then i:=100;
      case e.name[2] of
        '1' : if not tr.new_size(i, strtoint(e2.text)) then
                 i:=returnSize(tr.t[1,1], tr.t[1,2], tr.t[2,1], tr.t[2,2]);
        '4' : if not rec.new_size(i, strtoint(e5.text)) then
                 i:=returnSize(rec.t[1,1], rec.t[1,2], rec.t[2,1], rec.t[2,2]);
      end;
    end;
    '2','5','7' : begin
      if i>80 then i:=80;
      case e.name[2] of
        '2' : if not tr.new_size(strtoint(e1.text), i) then
                 i:=round((returnSize(tr.ct[1], tr.ct[2], tr.t[3,1], tr.t[3,2])*3)/2);
        '5' : if not rec.new_size(strtoint(e4.text), i) then
                 i:=returnSize(rec.t[2,1], rec.t[2,2], rec.t[3,1], rec.t[3,2]);
        '7' : if not kr.new_size(i) then
                 i:=kr.r*2;
      end;
    end;
  end;
  e.text:=inttostr(i);
end;
//=========================================================================
procedure Tlab_1.E3exit(Sender: TObject);
var i,u:integer;
    e:tedit;
    r:boolean;
begin
  e:=(sender as tedit);
  if e.Text='' then e.Text:='0';
  i:=strtoint(e.text);
  if i<-360 then i:=-360;
  if i>360 then i:=360;
  r := false;
  u := 0;
  case e.name[2] of
     '3' : begin r:=tr.turn(i); u:=tr.ug; end;
     '6' : begin r:=rec.turn(i); u:=rec.ug; end;
  end;
  if r then e.text:=inttostr(i) else e.text:=inttostr(-u);
end;
//=========================================================================
procedure Tlab_1.E1Enter(Sender: TObject);
begin
  clear_pole;
end;
//=========================================================================
procedure Tlab_1.FormShow(Sender: TObject);
begin
  tr.print_area;
  rec.print_area;
  kr.print_area;
  tr.print_ct;
  rec.print_ct;
  kr.print_ct;
end;

end.
