unit lab_2_wwod_ugol_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  Tlab_2_wwod_ugol = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    r    :real;
  end;

var
  lab_2_wwod_ugol: Tlab_2_wwod_ugol;

implementation
uses lab2_u, uGlobal;

{$R *.DFM}

procedure Tlab_2_wwod_ugol.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if length(edit1.Text)>=5 then begin key:=#8; beep; end;
  if key=#13 then button1.SetFocus;
  if key='.' then key:=',';
  if not(key in ['0'..'9',',',#8]) then key:=#0;
end;

procedure Tlab_2_wwod_ugol.Button1Click(Sender: TObject);
var st:string;
    i:integer;
begin
  st:=edit1.Text;
  i:=pos(',', st);
  if i<>0 then st:=copy(st, 1, i+1);
  r:=0;
  try
     r:=strtofloat(st);
     if r>60 then begin
        MyErrorBox('Число слишком большое.');
        edit1.SetFocus;
     end;
     if r<=0 then begin
        MyErrorBox('Число слишком маленькое.');
        edit1.SetFocus;
     end;
  except
    MyErrorBox(st+' это не число. Повторите ввод.');
    edit1.SetFocus;
  end;
  if (r>0)and(r<=60) then close;
end;

procedure Tlab_2_wwod_ugol.Button2Click(Sender: TObject);
begin
  r:=0;
  close;
end;

procedure Tlab_2_wwod_ugol.FormShow(Sender: TObject);
begin
  edit1.SetFocus;
end;

procedure Tlab_2_wwod_ugol.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then button2.Click;
end;

procedure Tlab_2_wwod_ugol.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

end.
