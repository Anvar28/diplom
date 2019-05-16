unit lab_7_result_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tlab_7_result = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    Function NewShowModal(y,yp:real; b,bp:real):byte;
  end;

var
  lab_7_result: Tlab_7_result;

implementation
uses lab7_u, lab_7_const, uGlobal;

{$R *.DFM}

procedure Tlab_7_result.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tlab_7_result.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

Function Tlab_7_result.NewShowModal(y,yp:real; b,bp:real):byte;
var pr:byte;

  procedure PrintL(y1,y1p:real; l1,l2:Tlabel; dopusk:real);
  const st1='Результат расчитан с допустимой точностью';
        st2='Результат неправильный. Посчитайте его снова.';
  begin
    if (y1>y1p-dopusk)and(y1<y1p+dopusk) then begin
       l1.Font.Color:=clblue;
       l1.Caption:=lab_7.FloatToStrInt(y1p, 3);
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

begin
  Label6.Caption:=floattostr(y);
  Label8.Caption:=floattostr(b);
  pr:=1;
  PrintL(y, yp, label7, label11, dopuskO);
  PrintL(b, bp, label9, label12, dopuskP);
  showmodal;
  if pr=1 then
     if not MyMessageBox(stRetryLab, 'Информация') then
        pr:=2;
  NewShowModal:=pr;
end;

end.
