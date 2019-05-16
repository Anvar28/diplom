unit lab_4_result_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TLab_4_result = class(TForm)
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
  Lab_4_result: TLab_4_result;

implementation
uses lab_4_const, uGlobal;
{$R *.DFM}

procedure TLab_4_result.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TLab_4_result.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
end;

// ���������� 0 ���� ��������� ��������� ������ � ��������
// 1 ���� ����� ������ ��� ���� ����
// 2 ����� ������.
function TLab_4_result.NewShowModal(r1, r2:real):byte;
var st,st2:string;
    col:tcolor;
    pr:byte;
begin
  pr:=0;
  label5.Caption:=floattostr(r1)+' ���';
  if (r1>=r2-dopusk)and(r1<=r2+dopusk) then begin
     pr:=1;
     col:=clblue;
     st:='�� ���������� ������ ��������� � ����������� ���������.';
     st2:=floattostr(r2)+' ���';
  end
  else begin
     col:=clMaroon;
     st:='�� ���������� ������ ��������� �����������. ���������� ���������� ��� �����, � ����� ������� ��� ��������.';
     st2:='�� ������';
  end;
  label7.Font.Color:=col;
  label6.Caption:=st2;
  label7.Caption:=st;
  showmodal;
  if pr=1 then
     if not MyMessageBox(stRetryLab, '����������') then
        pr:=2;
  NewShowModal:=pr;
end;

end.

