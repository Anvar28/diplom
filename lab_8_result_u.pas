unit lab_8_result_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tlab_8_result = class(TForm)
    Panel1: TPanel;
    btn: TButton;
    sb1: TScrollBox;
    l2: TLabel;
    l6: TLabel;
    l10: TLabel;
    l12: TLabel;
    l108: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    l111: TLabel;
    l8: TLabel;
    l9: TLabel;
    l13: TLabel;
    l11: TLabel;
    l14: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    l200: TLabel;
    l16: TLabel;
    l17: TLabel;
    l18: TLabel;
    l19: TLabel;
    l127: TLabel;
    l20: TLabel;
    Label9: TLabel;
    l140: TLabel;
    l201: TLabel;
    l202: TLabel;
    l203: TLabel;
    l204: TLabel;
    l205: TLabel;
    l206: TLabel;
    l207: TLabel;
    l208: TLabel;
    l209: TLabel;
    l210: TLabel;
    l211: TLabel;
    l212: TLabel;
    l213: TLabel;
    l214: TLabel;
    l218: TLabel;
    l217: TLabel;
    l216: TLabel;
    l215: TLabel;
    l219: TLabel;
    l220: TLabel;
    l221: TLabel;
    l300: TLabel;
    l301: TLabel;
    l302: TLabel;
    l303: TLabel;
    l304: TLabel;
    l305: TLabel;
    l306: TLabel;
    l307: TLabel;
    l308: TLabel;
    l309: TLabel;
    l310: TLabel;
    l311: TLabel;
    l312: TLabel;
    l313: TLabel;
    l314: TLabel;
    l315: TLabel;
    l316: TLabel;
    l317: TLabel;
    l318: TLabel;
    l319: TLabel;
    l320: TLabel;
    l321: TLabel;
    l40: TLabel;
    l400: TLabel;
    l401: TLabel;
    l402: TLabel;
    l403: TLabel;
    l404: TLabel;
    l405: TLabel;
    l406: TLabel;
    l407: TLabel;
    l408: TLabel;
    L409: TLabel;
    l410: TLabel;
    l411: TLabel;
    l412: TLabel;
    l413: TLabel;
    l414: TLabel;
    l415: TLabel;
    l416: TLabel;
    l417: TLabel;
    l418: TLabel;
    l419: TLabel;
    l420: TLabel;
    l421: TLabel;
    l45: TLabel;
    Label5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnClick(Sender: TObject);
  public
    function NewShowModal(z1, z2, z3, z4:byte; m:real; b:byte):byte;
  end;

var
  lab_8_result: Tlab_8_result;

implementation
  uses lab8_u, lab_8_const, graph, uGlobal;

{$R *.DFM}

procedure Tlab_8_result.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

procedure Tlab_8_result.btnClick(Sender: TObject);
begin
  close;
end;

function Tlab_8_result.NewShowModal(z1, z2, z3, z4:byte; m:real; b:byte):byte;
var pr:byte;

  procedure PrintL(y1,y1p:real; l1,l2:Tlabel; dopusk:real);
  const st1='Результат расчитан с допустимой точностью';
        st2='Результат неправильный. Посчитайте его снова.';
  begin
    if (y1>y1p-dopusk)and(y1<y1p+dopusk) then begin
       l1.Font.Color:=clblue;
       l1.Caption:=FloatToStr(y1p);
       l2.Font.Color:=clblue;
       l2.Caption:=st1;
    end
    else begin
       l1.Caption:='Не покажу';
       l1.Font.Color:=clMaroon;
       Pr:=0;
       l2.Font.Color:=clMaroon;
       l2.Caption:=st2;
    end;
  end;

var i:byte;
    st:string;
    r1,r2:real;
begin
  for i:=0 to 21 do begin
      if i<10 then st:='0'+inttostr(i)
      else st:=inttostr(i);
      (findcomponent('l2'+st) as tlabel).caption:=(lab_8.findcomponent('e'+inttostr(i+7)) as tedit).text;
      (findcomponent('l3'+st) as tlabel).caption:='';
      (findcomponent('l4'+st) as tlabel).caption:='';
  end;

  pr:=1;

  r1:=NRound(z2/z1, 2);
  PrintL(strtofloat(lab_8.e7.text), r1, l300, l400, dopusk);
  r2:=NRound(z4/z3, 2);
  PrintL(strtofloat(lab_8.e8.text), r2, l301, l401, dopusk);
  PrintL(strtofloat(lab_8.e9.text), NRound(r1*r2, 2), l302, l402, dopusk);
 // для 1 и 2 колёс
  r1:=NRound(m*z1, 2);
  r2:=NRound(m*z2, 2);
  PrintL(strtofloat(lab_8.e10.text), r1, l303, l403, dopusk);    // делительные диаметры
  PrintL(strtofloat(lab_8.e11.text), r2, l304, l404, dopusk);
  PrintL(strtofloat(lab_8.e14.text), NRound(r1+2*m, 2), l307, l407, dopusk);// диаметры вершин зубьев
  PrintL(strtofloat(lab_8.e15.text), NRound(r2+2*m, 2), l308, l408, dopusk);
  PrintL(strtofloat(lab_8.e18.text), NRound(r1-2.5*m, 2), l311, l411, dopusk);// диаметры впадин зубьев
  PrintL(strtofloat(lab_8.e19.text), NRound(r2-2.5*m, 2), l312, l412, dopusk);
  PrintL(strtofloat(lab_8.e26.text), NRound((r1+r2)/2, 2), l319, l419, dopusk);// межочевое расстояние

 // для 3 и 4 колёс
  r1:=NRound((m*z3)/cos((b*pi)/180), 2);
  r2:=NRound((m*z4)/cos((b*pi)/180), 2);
  PrintL(strtofloat(lab_8.e12.text), r1, l305, l405, dopusk);    // делительные диаметры
  PrintL(strtofloat(lab_8.e13.text), r2, l306, l406, dopusk);
  PrintL(strtofloat(lab_8.e16.text), NRound(r1+2*m, 2), l309, l409, dopusk);// диаметры вершин зубьев
  PrintL(strtofloat(lab_8.e17.text), NRound(r2+2*m, 2), l310, l410, dopusk);
  PrintL(strtofloat(lab_8.e20.text), NRound(r1-2.5*m, 2), l313, l413, dopusk);// диаметры впадин зубьев
  PrintL(strtofloat(lab_8.e21.text), NRound(r2-2.5*m, 2), l314, l414, dopusk);
  PrintL(strtofloat(lab_8.e27.text), NRound((r1+r2)/2, 2), l320, l420, dopusk);// межочевое расстояние

 // общие данные
  PrintL(strtofloat(lab_8.e22.text), NRound(m*2.25, 2), l315, l415, dopusk); // h
  PrintL(strtofloat(lab_8.e23.text), NRound(m, 2), l316, l416, dopusk);      // ha
  PrintL(strtofloat(lab_8.e24.text), NRound(1.25*m, 2), l317, l417, dopusk); // hf
  PrintL(strtofloat(lab_8.e25.text), NRound(0.25*m, 2), l318, l418, dopusk); // c
  PrintL(strtofloat(lab_8.e28.text), NRound(pi*m, 2), l321, l421, dopusk);//p

  showmodal;
  if pr=1 then
     if not MyMessageBox(stRetryLab, 'Информация') then
        pr:=2;
  NewShowModal:=pr;
end;

end.
