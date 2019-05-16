unit lab5_u;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, jpeg;
type
  Tlab_5 = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Panel1: TPanel;
    Bevel2: TBevel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    rb1: TRadioButton;
    rb2: TRadioButton;
    rb3: TRadioButton;
    rb4: TRadioButton;
    rb12: TRadioButton;
    rb13: TRadioButton;
    rb14: TRadioButton;
    rb15: TRadioButton;
    btnNewOpit: TButton;
    btnPowtor: TButton;
    Panel4: TPanel;
    Label9: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    Image2: TImage;
    Image1: TImage;
    Image3: TImage;
    Timer1: TTimer;
    rb16: TRadioButton;
    rb17: TRadioButton;
    rb18: TRadioButton;
    rb19: TRadioButton;
    Image4: TImage;
    Image5: TImage;
    pb1: TPaintBox;
    Image6: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label8: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rb1Click(Sender: TObject);
    procedure rb12Click(Sender: TObject);
    procedure btnNewOpitClick(Sender: TObject);
    procedure btnPowtorClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  public
    move : boolean;
    rbm  : byte;    // указатель материала
    diam : byte;
    TF   : real;
    Sdwig: byte;
    maxTF: real;
    procedure Init;
    procedure EndLab;
    procedure PaintZagotowka(sdwig:byte);
  end;

var
  lab_5: Tlab_5;
implementation
  uses osnowa_u, graph, lab_5_const, lab_5_inform_u, lab_5_result_u;

{$R *.DFM}
const shag=100;
//=========================================================================
procedure Tlab_5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  osnowa.ol5.Enabled:=true;
  action:=cafree;
end;
//=========================================================================
procedure Tlab_5.FormPaint(Sender: TObject);
begin
  Paint_Siloizmeritel(canvas, sx, sy, sr, shag, ' кH');
  Paint_Strelka(canvas, sx, sy, sr, tf, shag, clblack);
  PaintZagotowka(Sdwig);
  if move then timer1.Enabled:=true;
end;
//=========================================================================
procedure Tlab_5.Timer1Timer(Sender: TObject);
begin
  if not lab_5.active then timer1.Enabled:=false
  else
     if move then begin
        Paint_Strelka(canvas, sx, sy, sr, tf, shag, clbtnface);
        Tf:=Tf+0.1;
        Paint_Strelka(canvas, sx, sy, sr, tf, shag, clblack);
        if tf>maxtf-(0.1*diam) then begin
           image1.Top:=image1.Top+1;
           image3.Top:=image3.Top+1;
           image6.Top:=image6.Top+1;
           sdwig:=sdwig+1;
           PaintZagotowka(Sdwig);
        end;
        if tf>=maxtf then EndLab;
     end;
end;
//=========================================================================
procedure Tlab_5.FormCreate(Sender: TObject);
begin
  pagecontrol1.ActivePage:=TabSheet1;
  rbm:=1;
  diam:=2;
  label13.Caption:=inttostr(diam)+' мм';
  Sdwig:=0;
  init;
end;
//=========================================================================
procedure Tlab_5.rb1Click(Sender: TObject);
var rbm_:byte;
begin
  rbm_:=strtoint((sender as tradiobutton).name[3]);
  if rbm_<>rbm then rbm:=rbm_;
end;
//=========================================================================
procedure Tlab_5.rb12Click(Sender: TObject);
var diam_:byte;
begin
  diam_:=strtoint((sender as tradiobutton).name[4]);
  if diam_<>diam then begin
     image4.Top:=image4.Top+diam-diam_;
     image5.Top:=image5.Top+diam-diam_;
     image1.Top:=image1.Top+diam-diam_;
     image3.Top:=image3.Top+diam-diam_;
     image6.Top:=image6.Top+diam-diam_;
     diam:=diam_;
     PaintZagotowka(0);
     label13.Caption:=inttostr(diam)+' мм';
  end;
end;
//=========================================================================
procedure Tlab_5.btnNewOpitClick(Sender: TObject);
var i:byte;
begin
    for i:=1 to 4 do (findcomponent('rb'+inttostr(i)) as tradiobutton).enabled:=false;
    for i:=2 to 9 do (findcomponent('rb1'+inttostr(i)) as tradiobutton).enabled:=false;
    btnNewOpit.Enabled:=false;
    btnPowtor.Enabled:=true;
    image6.Visible:=true;

    MaxTF:=(mater[rbm]*2*(pi*diam*diam)/4)/1000;

    timer1.Enabled:=true;
    move:=true;
end;
//=========================================================================
procedure Tlab_5.Init;
begin
   move:=false;
   timer1.Enabled:=false;
   image1.Top:=71-diam;
   image3.Top:=17-diam;
   image6.top:=71-diam;
   panel4.Visible:=false;
   label14.Caption:='';
   Tf:=0;
   sdwig:=0;
end;
//=========================================================================
procedure Tlab_5.btnPowtorClick(Sender: TObject);
begin
  Paint_Strelka(canvas, sx, sy, sr, tf, shag, clbtnface);
  init;
  Paint_Strelka(canvas, sx, sy, sr, tf, shag, clblack);
  PaintZagotowka(sdwig);
  move:=true;
  timer1.Enabled:=true;
end;
//=========================================================================
procedure Tlab_5.EndLab;
var i:byte;
    st:shortstring;
begin
  timer1.Enabled:=false;
  move:=false;
  beep;

  st:=floattostr(maxtf);
  i:=pos(',', st);
  if i<>0 then st:=copy(st, 1, i+4);
  label14.Caption:=st+' кЌ';
  pagecontrol1.ActivePage:=TabSheet2;
  panel4.Visible:=true;
  image6.Visible:=false;

  button3.Click;
end;
//=========================================================================
procedure Tlab_5.Button3Click(Sender: TObject);
begin
  lab_5_inform:=Tlab_5_inform.create(application);
  lab_5_inform.showmodal;
  edit1.SetFocus;
end;
//=========================================================================
procedure Tlab_5.Button2Click(Sender: TObject);
var r : real;
    result,i:byte;
begin
  result:=4;
  try
    r:=strtofloat(edit1.text);
    lab_5_result:=Tlab_5_result.create(application);
    result:=lab_5_result.NewShowModal(r, MATER[rbm]);
  except
    showmessage('«десь должно быть число.');
    edit1.SetFocus;
  end;
  case result of
    0 : edit1.SetFocus;
    1 : begin
          Paint_Strelka(canvas, sx, sy, sr, tf, shag, clbtnface);
          init;
          for i:=1 to 4 do (findcomponent('rb'+inttostr(i)) as tradiobutton).enabled:=true;
          for i:=2 to 9 do (findcomponent('rb1'+inttostr(i)) as tradiobutton).enabled:=true;
          btnNewOpit.Enabled:=true;
          btnPowtor.enabled:=false;
          sdwig:=0;
          pagecontrol1.ActivePage:=TabSheet1;
          edit1.text:='0,0';
          btnNewOpit.SetFocus;
        end;
    2 : close;
  end;
end;
//=========================================================================
procedure Tlab_5.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then button2.SetFocus;
  if length(edit1.text)>6 then key:=#8;
  if key='.' then key:=',';
  if not(key in ['0'..'9',',',#8]) then key:=#0;
end;
//=========================================================================
procedure Tlab_5.PaintZagotowka(sdwig:byte);
const x11=10;
      x12=45;
      x21=45;
      x22=145;
      x31=145;
      x32=180;
      y1=23;
begin
  pb1.refresh;
  with pb1.Canvas do begin
    pen.Color:=$004E4E4E;
    brush.Color:=$004E4E4E;
    brush.Style:=bssolid;
    rectangle(x11, y1-diam, x12, y1);
    rectangle(x21, y1+sdwig-diam, x22, y1+sdwig);
    rectangle(x31, y1-diam, x32, y1);
  end;
end;
//=========================================================================
procedure Tlab_5.Button1Click(Sender: TObject);
begin
  application.Helpcontext(500);
end;

end.
