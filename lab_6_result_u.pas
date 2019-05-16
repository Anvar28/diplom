unit lab_6_result_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  Tlab_6_result = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label20: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    l7: TLabel;
    l8: TLabel;
    l9: TLabel;
    l11: TLabel;
    l12: TLabel;
    Label15: TLabel;
    l13: TLabel;
    l14: TLabel;
    l15: TLabel;
    l16: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    function NewShowModal(ejp,ewp,et,egsr, jp,wp,t,Gsr:real):byte;
  end;

var
  lab_6_result: Tlab_6_result;

implementation
uses graph, lab_6_const, uGlobal;


{$R *.DFM}

procedure Tlab_6_result.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tlab_6_result.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  action:=cafree;
end;

function Tlab_6_result.NewShowModal(ejp,ewp,et,egsr, jp,wp,t,Gsr:real):byte;
var pr:byte;

  procedure PrintL(y1p,y1:real; l1,l2:Tlabel; dopusk:real);
  const st1='Результат расчитан с допустимой точностью';
        st2='Результат неправильный. Посчитайте его снова.';
  begin
    if (y1>y1p-dopusk)and(y1<y1p+dopusk) then begin
       l1.Font.Color:=clblue;
       l1.Caption:=floattostr(Nround(y1p, 3));
       l2.Font.Color:=clblue;
       l2.Caption:=st1;
       l1.Caption:=floattostr(Nround(y1p, 3));
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
  pr:=1;
  l4.Caption:=floattostr(ejp);
  l5.Caption:=floattostr(ewp);
  l6.Caption:=floattostr(et);
  l7.Caption:=floattostr(egsr);
  PrintL(jp, ejp, l8, l13, dopusk);
  PrintL(wp, ewp, l9, l14, dopusk);
  PrintL(t, et, l11, l15, dopusk);
  PrintL(gsr, egsr, l12, l16, 1000);
  showmodal;
  if pr=1 then
     if not MyMessageBox(stRetryLab, 'Информация') then
        pr:=2;
  Newshowmodal:=pr;
end;

end.
