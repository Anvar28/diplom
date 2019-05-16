unit lab_2_result_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  Tlab_2_result = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    function NewShowModal(k_tr, k:real):byte;
  end;

var
  lab_2_result: Tlab_2_result;

implementation
uses uGlobal;

{$R *.DFM}

// возвращает 0 если расчет неправильный
// 1 если расчет правильный и делаем еще одну лабу
// 2 выходим
function Tlab_2_result.NewShowModal(k_tr, k:real):byte;
const dopusk = 0.04;
var st1, st2:string;
    col:tcolor;
    pr:byte;
begin
  pr:=0;
  if (k_tr <= k+dopusk)and(k_tr >= k-dopusk) then begin
     st1:='Поздравляю. Вы с достаточной точностью рассчитали коэффициент трения.';
     st2:=floattostr(k);
     col:=clblue;
     pr:=1;
  end else begin
     st1:='Вы неправильно рассчитали коэффициент трения, предлагаю повнимательнее рассчитать коэффициент трения и снова ввести его для проверки.';
     col:=clmaroon;
     st2:='Не покажу';
  end;
  label1.Font.Color:=col;
  label1.Caption:=st1;
  label5.Caption:=floattostr(k_tr);
  label6.Caption:=st2;
  showmodal;
  if pr=1 then
     if not MyMessageBox(stRetryLab, 'Информация') then
        pr:=2;
  NewShowModal:=pr;
end;

procedure Tlab_2_result.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tlab_2_result.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

end.
