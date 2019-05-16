{DELPHI 4        Хисматуллин А.Р.
1-ПОВТ-97              14.03.01 }
unit osnowa_u;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;
type
  Tosnowa = class(TForm)
    ol1: TButton;
    ol2: TButton;
    ol3: TButton;
    ol4: TButton;
    ol5: TButton;
    ol6: TButton;
    ol7: TButton;
    exit: TButton;
    Panel1: TPanel;
    l_help: TLabel;
    Ab9: TButton;
    ol8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ol1Click(Sender: TObject);
    procedure ButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ButtonEnter(Sender: TObject);
    procedure ol2Click(Sender: TObject);
    procedure ol3Click(Sender: TObject);
    procedure ol4Click(Sender: TObject);
    procedure ol5Click(Sender: TObject);
    procedure ol6Click(Sender: TObject);
    procedure ol7Click(Sender: TObject);
    procedure ol8Click(Sender: TObject);
    procedure Ab9Click(Sender: TObject);
    procedure exitClick(Sender: TObject);
    procedure Ab9MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Ab9Enter(Sender: TObject);
    procedure exitEnter(Sender: TObject);
    procedure exitMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    ind_help:integer;
    procedure print_help(st:string; id:integer);
  end;

var
  osnowa: Tosnowa;
implementation
uses Lab1_u, Lab2_u, lab3_u, lab4_u, lab5_u, lab6_u, lab7_u, lab8_u, about_u;
const st : array [1..10] of string =
('Определить центр тяжести сложной фигуры аналитическим путем.',
 'Определить приближенный коэффициент трения скольжения различных материалов.',
 'Изучить поведение материала при растяжении, получить диаграмму растяжения и установить основные механические характеристики материала образца.',
 'Ознакомится с характером деформации пластичных и хрупких материалов при сжатии.',
 'Ознакомится с методом испытания на срез и определить предел прочности материала на срез.',
 'Научится определять модуль сдвига.',
 'Определить опытным путем характеристику пружины, то есть зависимость между осадкой пружины и её осевой нагрузки.',
 'Научится расчитывать основные параметры редуктора.',
 'Информация о программе.',
 'Выход');
{$R *.DFM}
//=========================================================================
procedure Tosnowa.print_help(st:string; id:integer);
begin
  if osnowa.ind_help<>id then begin
     osnowa.l_help.Caption:=st;
     osnowa.ind_help:=id;
  end;
end;
//=========================================================================
procedure Tosnowa.exitClick(Sender: TObject);
begin
  osnowa.close;
end;
//=========================================================================
procedure Tosnowa.ol1Click(Sender: TObject);
begin
  ol1.Enabled:=false;
  lab_1:=tlab_1.Create(application);
  lab_1.Show;
end;
//=========================================================================
procedure Tosnowa.ButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  ButtonEnter(sender);
end;
//=========================================================================
procedure Tosnowa.ol2Click(Sender: TObject);
begin
  ol2.Enabled:=false;
  lab_2:=tlab_2.Create(application);
  lab_2.Show;
end;
//=========================================================================
procedure Tosnowa.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  print_help('', 0);
end;
//=========================================================================
procedure Tosnowa.FormCreate(Sender: TObject);
begin
  ind_help:=0;
  randomize;
end;
//=========================================================================
procedure Tosnowa.ButtonEnter(Sender: TObject);
var b:byte;
begin
  b:=strtoint((sender as TButton).name[3]);
  print_help(st[b], b);
end;
//=========================================================================
procedure Tosnowa.ol3Click(Sender: TObject);
begin
  ol3.Enabled:=false;
  lab_3:=tlab_3.Create(application);
  lab_3.Show;
end;
//=========================================================================
procedure Tosnowa.ol4Click(Sender: TObject);
begin
  ol4.Enabled:=false;
  lab_4:=tlab_4.Create(application);
  lab_4.Show;
end;
//=========================================================================
procedure Tosnowa.Ab9Click(Sender: TObject);
begin
  about:=Tabout.Create(application);
  about.showmodal;
end;
//=========================================================================
procedure Tosnowa.ol5Click(Sender: TObject);
begin
  ol5.Enabled:=false;
  lab_5:=tlab_5.Create(application);
  lab_5.Show;
end;
//=========================================================================
procedure Tosnowa.ol6Click(Sender: TObject);
begin
  ol6.Enabled:=false;
  lab_6:=tlab_6.Create(application);
  lab_6.Show;
end;
//=========================================================================
procedure Tosnowa.ol7Click(Sender: TObject);
begin
  ol7.Enabled:=false;
  lab_7:=tlab_7.Create(application);
  lab_7.Show;
end;
//=========================================================================
procedure Tosnowa.ol8Click(Sender: TObject);
begin
  ol8.Enabled:=false;
  lab_8:=tlab_8.Create(application);
  lab_8.Show;
end;
//=========================================================================
procedure Tosnowa.Ab9MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  Print_Help(st[9], 9);
end;
//=========================================================================
procedure Tosnowa.Ab9Enter(Sender: TObject);
begin
  Print_Help(st[9], 9);
end;
//=========================================================================
procedure Tosnowa.exitEnter(Sender: TObject);
begin
  Print_Help(st[10], 10);
end;
//=========================================================================
procedure Tosnowa.exitMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  Print_Help(st[10], 10);
end;

end.
