unit lab_3_result_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tlab_3_result = class(TForm)
    Panel1: TPanel;
    exit: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    L_1: TLabel;
    L_2: TLabel;
    L_3: TLabel;
    L_4: TLabel;
    L_5: TLabel;
    L_6: TLabel;
    L_7: TLabel;
    L_8: TLabel;
    L_9: TLabel;
    L_10: TLabel;
    Label9: TLabel;
    L_11: TLabel;
    L_12: TLabel;
    L_13: TLabel;
    L_14: TLabel;
    L_15: TLabel;
    procedure exitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    function NewShowModal(i:byte):byte;
  end;

var
  lab_3_result: Tlab_3_result;

implementation
uses lab3_u, lab_3_const, uGlobal;

{$R *.DFM}
//=========================================================================
procedure Tlab_3_result.exitClick(Sender: TObject);
begin
  close;
end;
//=========================================================================
procedure Tlab_3_result.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;
//=========================================================================
// возвращает 0 если не все расчеты правильные и необходима снова проверка
// 1 если все расчеты правильны но хотят сделать лабу еще раз
// 2 выход 
function Tlab_3_result.NewShowModal(i:byte):byte;
const st1='Результат неправильный. Посчитайте его снова.';
      st3='Результат рассчитан с допустимой точностью';
var r : array [1..5] of real;
    m:array [1..5] of real;
    pr:byte;
  //=======================================================================
  procedure PrintZnachenia(ind:byte; e1:tedit; l1, l2:Tlabel);
  var st:string;
      i:byte;
  begin
    if (r[ind]>=m[ind]-1)and(r[ind]<=m[ind]+1) then begin
       l2.Font.Color:=clblue;
       l2.Caption:=st3;
       l1.Font.Color:=clblue;
       st:=floattostr(m[ind]);
       i:=pos(',', st);
       if i<>0 then st:=copy(st, 1, i+2);
       case ind of
         1..3 : st:=st+' МПа';
         4,5 : st:=st+' %';
       end;
       l1.caption:=st;
    end
    else begin
       l2.Font.Color:=clmaroon;
       l2.Caption:=st1;
       l1.Font.Color:=clmaroon;
       l1.Caption:='Не покажу';
       pr:=0;
    end;  
  end;
  //=======================================================================

begin
  pr:=1;
{    PT     предел текучести                  = Fm / Ao
     WS     временное сопративление           = Fmax / Ao
     ISR    испытанное сопративление разрыва  = Fраз / A
     OU     относительное удлиннение          = (L - Lo) / Lo
     OS     относительное сужение             = (Ao - A) / Ao }
  m[1]:=(mater[i, 3] / 78.5)*1000;
  m[2]:=(mater[i, 4] / 78.5)*1000;
  m[3]:=(mater[i, 5] / (3.14 * sqr(mater[i, 1])/4))*1000;
  m[4]:=((mater[i, 2] - 100) / 100 )*100;
  m[5]:=((78.5 - (3.14 * sqr(mater[i, 1])/4)) /78.5)*100;

  With lab_3 do
  begin
    l_1.caption := E1.text+' МПа';
    l_2.caption := E2.text+' МПа';
    l_3.caption := E3.text+' МПа';
    l_4.caption := E4.text+' %';
    l_5.caption := E5.text+' %';

    r[1] := StrToFloat(E1.text);
    r[2] := StrToFloat(E2.text);
    r[3] := StrToFloat(E3.text);
    r[4] := StrToFloat(E4.text);
    r[5] := StrToFloat(E5.text);
  end;

  PrintZnachenia(1, lab_3.E1, l_6, l_11);
  PrintZnachenia(2, lab_3.E2, l_7, l_12);
  PrintZnachenia(3, lab_3.E3, l_8, l_13);
  PrintZnachenia(4, lab_3.E4, l_9, l_14);
  PrintZnachenia(5, lab_3.E5, l_10, l_15);
  showmodal;
  if pr=1 then
     if not MyMessageBox(stRetryLab, 'Информация') then
        pr:=2;
  NewShowModal:=pr;
end;

end.
