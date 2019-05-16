unit lab_5_result_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tlab_5_result = class(TForm)
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
    function NewShowModal(r1, r2:real):byte;
  end;

var
  lab_5_result: Tlab_5_result;

implementation
uses lab_5_const, uGlobal;

{$R *.DFM}

procedure Tlab_5_result.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tlab_5_result.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

// ���������� 0 ������ ������ ���������� ��� ��� � ����� ��������
// ���������� 1 ������ ������ ����� ������������ ������
// ���������� 2 ������ ��������� ��� ���� 
function Tlab_5_result.NewShowModal(r1, r2:real):byte;
var st1,st2:string;
    col:tcolor;
    pr:byte;
begin
  pr:=0;
  if (r1>=r2-dopusk)and(r1<=r2+dopusk) then begin
     st1:='�� � ����������� ��������� ���������� ������ ��������� ��� �����.';
     st2:=floattostr(r2)+' ���';
     col:=clblue;
     pr:=1;
  end
  else begin
     st1:='�� ���������� ������ ��������� ��� ����� �����������. ���������� ���������� ��� �����, � ����� ������� ��� ��������.';
     st2:='�� ������';
     col:=clmaroon;
  end;
  label6.Caption:=st2;
  label7.Font.Color:=col;
  label7.Caption:=st1;
  label5.Caption:=floattostr(r1)+' ���';
  showmodal;
  if pr=1 then
     if not MyMessageBox(stRetryLab, '����������') then
        pr:=2;
  newShowModal:=pr;
end;

end.
