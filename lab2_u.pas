{DELPHI 4        ����������� �.�.       ������������ 2
1-����-97              14.03.01 }
unit lab2_u;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;
type
  Tlab_2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    OpenHelp: TButton;
    GroupBox1: TGroupBox;
    RB_pl_1: TRadioButton;
    rb_pl_2: TRadioButton;
    rb_pl_3: TRadioButton;
    GroupBox2: TGroupBox;
    rb_brusok_1: TRadioButton;
    rb_brusok_2: TRadioButton;
    rb_brusok_3: TRadioButton;
    Panel1: TPanel;
    Shape2: TShape;
    Timer1: TTimer;
    l_ugol: TLabel;
    Label7: TLabel;
    Panel2: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    l_1: TLabel;
    l_2: TLabel;
    l_3: TLabel;
    Button2: TButton;
    Button3: TButton;
    Panel3: TPanel;
    Label13: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Label14: TLabel;
    Button4: TButton;
    Label6: TLabel;
    l_nomer_opita: TLabel;
    Shape1: TShape;
    Button5: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure OpenHelpClick(Sender: TObject);
    procedure RB_pl_1Click(Sender: TObject);
    procedure rb_brusok_1Click(Sender: TObject);
    procedure rb_pl_2Click(Sender: TObject);
    procedure rb_pl_3Click(Sender: TObject);
    procedure rb_brusok_2Click(Sender: TObject);
    procedure rb_brusok_3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  end;
var
  lab_2: Tlab_2;
                       implementation
uses osnowa_u, lab_2_wwod_ugol_u, lab_2_inform_u, lab_2_result_u, uGlobal;

const max_ugol   = 60;        // ������������ ���� �������
      max_l      = 300;
      r          = 400;       // ������ ����
      x1         = 40;        // ���������� ����� � ������� ���������
      y1         = 475;       // ������ ���������
      d          = 50;        // ����� ������
      h          = 20;        // ������ ������
      mater:array [1..6] of real=(0.14, 0.15, 0.18, 0.16, 0.21, 0.2);
var   ugol       : real;      // ������� ����
      l          : integer;   // ��������� �� ����� X1,Y1 �� ������ ������
      brusok     : array [1..4,1..2] of integer; // ���������� ������ ������
      move       : boolean;   // ������ ���������� �������
      move_brusok: boolean;   // ���� TRUE ������ ������ ���������
      n          : byte;      // ����� �����
      k          : byte;      // ��������� �� ����������� ������
      n_opit     : array [1..3] of real; // ����� ��������� ���� ��� ������ � ������� ����
      col_brusok : tcolor;
      col_platform: tcolor;

{$R *.DFM}
//=============================================================================
function  end_opit:boolean; // �������� �������� �� ����
begin
  if (ugol>=60)and(l<=20) then end_opit:=true else end_opit:=false;
end;
//=============================================================================
procedure paint_platform(col:tcolor; ug:real);  // ���������� ���������
begin
  with lab_2.Canvas do begin
    pen.Color:=col;
    brush.Color:=col;
    brush.style:=bssolid;
    polygon([ POINT(x1, y1),
              POINT(round(sin((ug+90)*pi/180)*(r-7)+x1), round(cos((ug+90)*pi/180)*(r-7)+y1)),
              POINT(round(sin((ug+90)*pi/180)*(r-7)+x1), round(cos((ug+90)*pi/180)*(r-7)+y1-2)),
              POINT(x1, y1-2) ]);
  end;
end;
//=============================================================================
procedure calculate_brusok(ug:real);   // ������ ������ ������
begin
  brusok[1,1]:=round(sin((ug+90)*pi/180)*l+x1-2);
  brusok[1,2]:=round(cos((ug+90)*pi/180)*l+y1-3);
  brusok[2,1]:=round(sin((ug+90)*pi/180)*(l+d)+x1-2);
  brusok[2,2]:=round(cos((ug+90)*pi/180)*(l+d)+y1-3);
  brusok[3,1]:=round(sin((ug+180)*pi/180)*h+brusok[2,1]);
  brusok[3,2]:=round(cos((ug+180)*pi/180)*h+brusok[2,2]);
  brusok[4,1]:=round(sin((ug+180)*pi/180)*h+brusok[1,1]);
  brusok[4,2]:=round(cos((ug+180)*pi/180)*h+brusok[1,2]);
end;
//=============================================================================
procedure paint_brusok(col:tcolor);    // ���������� ������
begin
  with lab_2.Canvas do begin
    if col<>clbtnface then
       if move_brusok then pen.Color:=clred else pen.color:=col
    else pen.color:=clbtnface;
    brush.Color:=col;
    brush.style:=bssolid;
    polygon([ POINT(brusok[1,1], brusok[1,2]), POINT(brusok[2,1], brusok[2,2]),
              POINT(brusok[3,1], brusok[3,2]), POINT(brusok[4,1], brusok[4,2])]);
  end;
end;
//=============================================================================
procedure select_k;          // �������� ����������� ������
begin
  if lab_2.rb_pl_1.Checked then begin
     if lab_2.rb_brusok_1.Checked then k:=1;
     if lab_2.rb_brusok_2.Checked then k:=2;
     if lab_2.rb_brusok_3.Checked then k:=3;
  end;
  if lab_2.rb_pl_2.Checked then begin
     if lab_2.rb_brusok_1.Checked then k:=2;
     if lab_2.rb_brusok_2.Checked then k:=4;
     if lab_2.rb_brusok_3.Checked then k:=5;
  end;
  if lab_2.rb_pl_3.Checked then begin
     if lab_2.rb_brusok_1.Checked then k:=3;
     if lab_2.rb_brusok_2.Checked then k:=5;
     if lab_2.rb_brusok_3.Checked then k:=6;
  end;
end;
//=============================================================================
procedure paint_shkala;              // ���������� �����
var i,xt,yt,j:integer;
begin
  with lab_2.canvas do begin
      pen.Color:=clgray;
      brush.style:=bsclear;
      arc(x1-r, y1-r, x1+r, y1+r,  x1+r, y1, x1+230, y1-r);
      arc(x1-r-1, y1-r-1, x1+r+1, y1+r+1,  x1+r, y1, x1+230, y1-r);
      for i:=0 to round(max_ugol/3) do begin         // ��������
          j:=(i*3)+90;                               // �����
          xt:=round(sin(j*pi/178)*(r*1.01)+x1+5);
          yt:=round(cos(j*pi/180)*(r*1.03)+y1-5);
          textout(xt, yt, inttostr(j-90));
      end;
      pen.Color:=clblack;
      ellipse(x1-2,y1-2,x1+2,y1+2);
      moveto(x1,y1);
      lineto(x1-5, y1+10);
      moveto(x1,y1);
      lineto(x1+5, y1+10);
      for i:=90 to 90+max_ugol do begin   // ������ ������
          if i/3=round(i/3) then pen.color:=clblack else pen.color:=clgray;
          moveto(round(sin(i*pi/180)*(r-2)+x1),round(cos(i*pi/180)*(r-2)+y1));
          lineto(round(sin(i*pi/180)*(r+3)+x1),round(cos(i*pi/180)*(r+3)+y1))
      end;
  end;
end;
//=============================================================================
procedure print_n_opit;           // ����� ����� 3-� ������
begin
  lab_2.l_1.Caption:=floattostr(n_opit[1]);
  lab_2.l_2.Caption:=floattostr(n_opit[2]);
  lab_2.l_3.Caption:=floattostr(n_opit[3]);
end;
//=============================================================================
procedure new_lab;                // ����� ����
var i:byte;
begin
  ugol:=0;
  l:=max_l;
  move:=false;
  k:=1;
  move_brusok:=false;
  for i:=1 to 3 do n_opit[i]:=0;
  n:=1;
end;
//====================================================================
procedure Tlab_2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  osnowa.ol2.enabled:=true;
  action:=cafree;     // ������� �����
end;
//=============================================================================
procedure Tlab_2.FormPaint(Sender: TObject);
begin
  paint_shkala;                   // ���������� ���� ����������� �������
  paint_platform({0023235c}col_platform, ugol);
  calculate_brusok(ugol);
  paint_brusok({clteal}col_brusok);
  // ���� ����� ��� ��� ���� �������� ����� ������ ��� ������� �� �� ����������
  // ����� ������ ������ � ���� ����� ��� �������� ����� ������ ���������
  if move then timer1.Enabled:=true;
end;
//=============================================================================
procedure Tlab_2.FormCreate(Sender: TObject);
begin
  new_lab;
  col_brusok:= $00818181;
  col_platform:= $00818181;
end;
//=============================================================================
procedure Tlab_2.Timer1Timer(Sender: TObject);
var st:string;
    i:integer;
begin
  if not lab_2.active then   // ���� ���� �������� ����� �� ��������� ������
     timer1.Enabled:=false
  else begin
    if move then begin    // ���� ������ ������ ��������� ��
       if (l>20)and       // ��������� ������ �� ��������� ������
          ((sin(ugol*pi/180)/cos(ugol*pi/180))>=mater[k])
       then begin
          l:=l-2;
          move_brusok:=true;
       end;
       paint_brusok(clbtnface);
       if ugol<60 then begin   // ��������� ����� �� ����������� ����
          paint_platform(clbtnface, ugol);
          ugol:=ugol+0.1;
          paint_platform({0023235c}col_platform, ugol);
          st:=floattostr(ugol);
          i:=pos(',',st);
          if i<>0 then st:=copy(st, 1, i+1);
          l_ugol.Caption:=st;
       end;
       calculate_brusok(ugol);
       paint_brusok({clteal}col_brusok);
       if end_opit then begin  // ����� �����
          button3.Click;
       end;
    end;
  end;
end;
//=============================================================================
procedure Tlab_2.Button2Click(Sender: TObject);
begin
  move:=true;
  timer1.Enabled:=true;           // �������� ������
  Button2.enabled:=false;
  button3.Enabled:=true;          // �������� ������
  button3.SetFocus;
  button4.Enabled:=true;
  if n=1 then begin
     RB_pl_1.Enabled:=false;         // ��������� �����������
     RB_pl_2.Enabled:=false;
     RB_pl_3.Enabled:=false;
     RB_brusok_1.Enabled:=false;
     RB_brusok_2.Enabled:=false;
     RB_brusok_3.Enabled:=false;
     select_k;                       // �������� k ����������� ������
  end;
end;
//=============================================================================
procedure Tlab_2.Button3Click(Sender: TObject);
var st:string;
    i:integer;
begin
  move:=false;           // ������ �� ���������
  timer1.Enabled:=false; // ����. ������
  if n_opit[n]<>0 then st:=floattostr(n_opit[n]) else st:=floattostr(ugol);
  i:=pos(',', st);
  if i<>0 then st:=copy(st, 1, i+1);
  lab_2_wwod_ugol:=Tlab_2_wwod_ugol.Create(application);
  lab_2_wwod_ugol.Edit1.Text:=st; // �������� ������� ����
  lab_2_wwod_ugol.ShowModal;      // ���������� ����� ����� ����
  n_opit[n]:=lab_2_wwod_ugol.r;   // ������� ��������� ������������� ���� � ������
  print_n_opit;
  if lab_2_wwod_ugol.r<>0 then begin  // ���� �������
     if MyMessageBox('��������� � ���������� �����?', '������') then begin
        if n<3 then begin  // ���� ������ ������ 3 �� ������� ��������� ����
           paint_platform(clbtnface, ugol);
           ugol:=0;
           paint_platform({0023235c}col_platform, ugol);
           move_brusok:=false;
           paint_brusok(clbtnface);
           l:=max_l;
           calculate_brusok(ugol);
           paint_brusok({clteal}col_brusok);
           l_ugol.Caption:=floattostr(ugol);
           n:=n+1;
           l_nomer_opita.Caption:=inttostr(n);
           button2.Caption:='������ '+inttostr(n)+' ����';
           Button2.enabled:=true;
           Button2.SetFocus;
           button3.Enabled:=false;
           button4.Enabled:=false;
        end else begin    // ���� ������ 3 �� ������� ���� ����������
           l_ugol.Caption:='0';
           lab_2_inform:=Tlab_2_inform.Create(application);
           lab_2_inform.ShowModal;
           panel3.Visible:=true;
           button3.Enabled:=false;
           button4.Enabled:=false;
           edit2.SetFocus;
        end;
     end else
        if not end_opit then begin // ���� ���� ��� �� �������� ��
           timer1.Enabled:=true;   // ���. ������
           move:=true;             // �������� ������� ������
        end;
  end else
     if not end_opit then begin    // ���� ���� ��� �� �������� ��
        timer1.Enabled:=true;      // ���. ������
        move:=true;                // �������� ������� ������
     end;
end;
//=============================================================================
procedure Tlab_2.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then button1.SetFocus;
  if length(edit2.Text)>=7 then begin key:=#8; beep; end;
  if key='.' then key:=',';
  if not(key in ['0'..'9',',',#8]) then key:=#0;
end;
//=============================================================================
procedure Tlab_2.Button1Click(Sender: TObject);
var st:string;
    r2:real;
    i, ret:byte;
begin
  st:=edit2.Text;         // �������� ���������� ������������ ������
  try
     r2:=strtofloat(st);
     lab_2_result:=Tlab_2_result.Create(application);
     ret:=lab_2_result.NewShowModal(r2, mater[k]);
     case ret of
      0 : edit2.setfocus;
      1 : begin
            paint_platform(clbtnface, ugol);
            paint_brusok(clbtnface);
            new_lab;
            paint_platform(col_platform, ugol);
            calculate_brusok(ugol);
            paint_brusok(col_brusok);
            RB_pl_1.Enabled:=true;         // ��������� �����������
            RB_pl_2.Enabled:=true;
            RB_pl_3.Enabled:=true;
            RB_brusok_1.Enabled:=true;
            RB_brusok_2.Enabled:=true;
            RB_brusok_3.Enabled:=true;
            for i:=1 to 3 do n_opit[i]:=0;
            print_n_opit;
            button2.Enabled:=true;
            button3.Enabled:=false;
            n:=1;
            l_nomer_opita.Caption:=inttostr(n);
            button2.Caption:='������ 1 ����';
            panel3.Visible:=false;
            l_ugol.Caption:='0';
            edit2.Text:='0,0';
          end;
      2 : close;
     end;
  except
     MyErrorBox(PChar(st+' ��� �� �����.'+#13#10+'��������� ����.'));
     edit2.SetFocus;
  end;
end;
//=============================================================================
procedure Tlab_2.Button4Click(Sender: TObject);
begin
  move_brusok:=false;           // ��������� ����
  move:=true;
  timer1.Enabled:=true;
  paint_platform(clbtnface, ugol);
  paint_brusok(clbtnface);
  ugol:=0;
  l:=max_l;
  paint_platform({0023235c}col_platform, ugol);
  calculate_brusok(ugol);
  paint_brusok({clteal}col_brusok);
end;
//=============================================================================
procedure Tlab_2.OpenHelpClick(Sender: TObject);
begin
  application.Helpcontext(200);
end;
//=============================================================================
procedure Tlab_2.RB_pl_1Click(Sender: TObject);
begin
  col_platform:= $00818181;
  paint_platform(col_platform,0);
end;
//=============================================================================
procedure Tlab_2.rb_brusok_1Click(Sender: TObject);
begin
  col_brusok:= $00818181;
  paint_brusok(col_brusok);
end;
//=============================================================================
procedure Tlab_2.rb_pl_2Click(Sender: TObject);
begin
  col_platform:= $0000005B;
  paint_platform(col_platform,0);
end;
//=============================================================================
procedure Tlab_2.rb_pl_3Click(Sender: TObject);
begin
  col_platform:= $00E1E1E1;
  paint_platform(col_platform,0);
end;
//=============================================================================
procedure Tlab_2.rb_brusok_2Click(Sender: TObject);
begin
  col_brusok:= $0000005B;
  paint_brusok(col_brusok);
end;
//=============================================================================
procedure Tlab_2.rb_brusok_3Click(Sender: TObject);
begin
  col_brusok:= $00E1E1E1;
  paint_brusok(col_brusok);
end;
//=============================================================================
procedure Tlab_2.Button5Click(Sender: TObject);
begin
  lab_2_inform:=Tlab_2_inform.Create(application);
  lab_2_inform.ShowModal;
  edit2.setfocus;
end;

end.
