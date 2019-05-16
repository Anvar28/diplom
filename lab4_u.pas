unit lab4_u;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, jpeg, ComCtrls, ImgList, lab_4_const;
type
  Tlab_4 = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Panel2: TPanel;
    Image2: TImage;
    Bevel2: TBevel;
    Label6: TLabel;
    btnHelp: TButton;
    Bevel3: TBevel;
    Label7: TLabel;
    Timer1: TTimer;
    Image3: TImage;
    Image1: TImage;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    btnNewLab: TButton;
    btnPowtor: TButton;
    Panel3: TPanel;
    Label8: TLabel;
    Panel4: TPanel;
    rb2: TRadioButton;
    rb1: TRadioButton;
    rb3: TRadioButton;
    rb4: TRadioButton;
    rb5: TRadioButton;
    Panel5: TPanel;
    Label9: TLabel;
    ImageList1: TImageList;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Edit1: TEdit;
    Label13: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label11: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnNewLabClick(Sender: TObject);
    procedure btnPowtorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rb1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure btnHelpClick(Sender: TObject);
  public
    move : boolean;
    exit : boolean;
    kadr : byte;
    Dk   : real;
    Tk   : integer;
    Tl   : integer;
    TF   : real;
    TFd  : real;
    Tfdd : real;
    bm   : Tbitmap;
    rb   : byte;
    mater: array [1..count_mater] of TMater;
    ind_F:byte;

    procedure Init;
    procedure NewLab;
    procedure EndLab;
    procedure LoadPic(file_name:string);
    procedure SetPicInImage1;
    procedure PaintGrafik;
    procedure PrintZnach(x,y:word; znach:string);
  end;
var
  lab_4: Tlab_4;
implementation
  uses osnowa_u, graph, lab_4_inform_u, lab_4_result_u;

{$R *.DFM}
//===================================================================
procedure Tlab_4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bm.Free;
  action:=cafree;
  osnowa.ol4.Enabled:=true;
end;
//===================================================================
procedure Tlab_4.FormPaint(Sender: TObject);
begin
  Paint_Siloizmeritel(canvas, sx, sy, sr, mater[rb].ky*10 ,' кH');
  Paint_Strelka(canvas, sx, sy, sr, tf*(mater[rb].ky/ddy), (mater[rb].ky*10), clblack);
  PaintXOY(canvas, Dx, Dy, Lx, Ly, ddx, ddy, 2, mater[rb].ky, 10, 10, true);
  // таймер выключился при потере фокуса и его надо снова включить
  if move then timer1.Enabled:=true;
  PaintGrafik;
end;
//===================================================================
procedure Tlab_4.Timer1Timer(Sender: TObject);
begin
  // если окно потеряло фокус то выкл. таймер
  if not lab_4.active then timer1.Enabled:=false
  else begin
    Paint_Strelka(canvas, sx, sy, sr, tf*(mater[rb].ky/ddy), (mater[rb].ky*10), clbtnface);
    canvas.pen.Color:=clred;
    canvas.moveto(dx+tl, dy-round(tf));
    TL:=TL+1;
    Tf:=Tf+Tfd;
    canvas.lineto(dx+tl, dy-round(tf));
    Paint_Strelka(canvas, sx, sy, sr, tf*(mater[rb].ky/ddy), (mater[rb].ky*10), clblack);
    Tfd:=Tfd+Tfdd;
    inc(TK);
    if tf>=(kadr+1)*round(dk) then begin
       inc(kadr);
       imagelist1.GetBitmap(kadr, bm);
       image3.Picture.Bitmap:=bm;
       image1.Top:=image1.Top+1;
       image3.Height:=image3.Height-1;
       image3.Top:=image3.Top+1;
    end;
    if (tf>=(PF[rb,1]*ddy)/mater[rb].ky)and(ind_f=0) then begin
       ind_f:=1;
       Tfd:=kf[rb, 2];
       Tfdd:=kf[rb, 4];
    end;
    if tf>=PF[rb,2]/(mater[rb].ky/ddy) then endlab;
  end;
end;
//===================================================================
procedure Tlab_4.NewLab;
var i,j:integer;
begin
  rb1.Enabled:=false;
  rb2.Enabled:=false;
  rb3.Enabled:=false;
  rb4.Enabled:=false;
  rb5.Enabled:=false;
  btnNewLab.Enabled:=false;
  btnPowtor.Enabled:=true;
  btnPowtor.setfocus;
  j:=rb*10;
  imagelist1.Clear;
  // загружаем картинки
  for i:=j to j+mater[rb].kadr do LoadPic('4'+inttostr(i));
  if exit then close;
  kadr:=1;
  Dk:=(pf[rb, 2]*(ddy/mater[rb].ky))/mater[rb].kadr;
  Tk:=0;
  move:=true;
  timer1.Enabled:=true;
  Tl:=0;
  TF:=0;
  Tfd:=kf[rb, 1];
  Tfdd:=kf[rb, 3];
  ind_F:=0;
end;
//===================================================================
procedure Tlab_4.EndLab;
var st:string;
    i:byte;
begin
  timer1.Enabled:=false;
  move:=false;

  imagelist1.GetBitmap(mater[rb].kadr, bm);
  image3.Picture.Bitmap:=bm;

  PrintZnach(dx+tl, dy-round(tf), floattostr(pf[rb, 2]));
  pagecontrol1.ActivePage:=TabSheet2;
  st:=floattostr(PF[rb, 2])+' кН';
  i:=pos(',', st);
  if i<>0 then st:=copy(st, 1, i+1);
  label11.Caption:=st;
  button2.Click;
end;
//===================================================================
procedure Tlab_4.btnNewLabClick(Sender: TObject);
begin
  newLab;
end;
//===================================================================
procedure Tlab_4.btnPowtorClick(Sender: TObject);
begin
  kadr:=1;
  move:=true;
  timer1.Enabled:=true;
  Paint_Strelka(canvas, sx, sy, sr, tf*(mater[rb].ky/ddy), (mater[rb].ky*10), clbtnface);
  Tl:=0;
  TF:=0;
  Tfd:=kf[rb, 1];
  Tfdd:=kf[rb, 3];
  ind_F:=0;
  clearwin(canvas, Dx-23, Dy-ly-5, dx+Lx, dy+20, clbtnface, clbtnface);
  PaintXOY(canvas, Dx, Dy, Lx, Ly, ddx, ddy, 2, mater[rb].ky, 10, 10, true);
  panel5.Visible:=false;
  if mater[rb].t then begin
     image3.Height:=199;
     image3.Top:=111;
     image1.Top:=17;
  end
  else begin
     image3.Height:=99;
     image3.Top:=211;
     image1.Top:=117;
  end;
  imagelist1.GetBitmap(0, bm);
  image3.Picture.Bitmap:=bm;
end;
//===================================================================
procedure Tlab_4.FormCreate(Sender: TObject);
  //=============================================
  procedure NewMater(ind:byte; t_:boolean; k_:byte;
                     ky_:byte);
  begin
    mater[ind].t:=t_;
    mater[ind].kadr:=k_;
    mater[ind].ky:=ky_;
  end;
  //=============================================
begin
  NewMater(1, true,  9, 25);
  NewMater(2, true,  9, 15);
  NewMater(3, false, 4, 2);
  NewMater(4, false, 1, 1);
  NewMater(5, false, 1, 10);

  bm:=tbitmap.Create;

  exit:=false;
  rb:=1;
  init;
end;
//===================================================================
procedure Tlab_4.LoadPic(file_name:string);
begin
   if not exit then begin
      try
         bm.LoadFromFile('data\'+file_name+'.dtv');
         imagelist1.AddMasked(bm, clred);
      except
         showmessage('У вас не хватает файла '+file_name+'.  Работать не буду.');
         exit:=true;
      end;
   end;
end;
//===================================================================
Procedure Tlab_4.Init;
var i:byte;
begin
  panel5.Visible:=false;
  imagelist1.Clear;
  for i:=1 to count_mater do loadpic('4'+inttostr(i)+'0');
  SetPicInImage1;
  rb1.Enabled:=true;
  rb2.Enabled:=true;
  rb3.Enabled:=true;
  rb4.Enabled:=true;
  rb5.Enabled:=true;
  btnNewLab.Enabled:=true;
  btnPowtor.Enabled:=false;
  pagecontrol1.ActivePage:=TabSheet1;
end;
//===================================================================
procedure Tlab_4.FormShow(Sender: TObject);
begin
  if exit then close;
end;
//===================================================================
procedure Tlab_4.rb1Click(Sender: TObject);
var st,st1:string;
    rb_:byte;
begin
  rb_:=strtoint((sender as tradiobutton).name[3]);
  if rb<>rb_ then begin
     rb:=rb_;
     SetPicInImage1;
     clearwin(canvas, Dx-23, Dy-ly-5, dx+Lx, dy+20, clbtnface, clbtnface);
     PaintXOY(canvas, Dx, Dy, Lx, Ly, ddx, ddy, 2, mater[rb].ky, 10, 10, true);
     clearwin(canvas, sx-sr-20, sy-sr-15, sx+sr+25, sy+sr+20, clbtnface, clbtnface);
     Paint_Siloizmeritel(canvas, sx, sy, sr, mater[rb].ky*10 ,' кH');
     Paint_Strelka(canvas, sx, sy, sr, 0, (mater[rb].ky*10), clblack);
     if mater[rb].t then begin
        st:='цилиндр';
        st1:='d=20 мм.  Lo=40 мм.';
     end
     else begin
        st:='куб';
        st1:='a=20  b=20  Lo=20 мм.'
     end;
     label23.Caption:=st;
     label14.Caption:=st1;
  end;
end;
//===================================================================
procedure Tlab_4.SetPicInImage1;
begin
  imagelist1.GetBitmap(rb-1, bm);
  if mater[rb].t then begin
     image3.Height:=199;
     image3.Top:=111;
     image1.Top:=17;
  end
  else begin
     image3.Height:=99;
     image3.Top:=211;
     image1.Top:=117;
  end;
  image3.Picture.Bitmap:=bm;
end;
//===================================================================
procedure Tlab_4.PaintGrafik;
var i:integer;
    nTF, nTFd, nTFdd:real;
    nind_f:byte;
begin
  canvas.pen.Color:=clred;
  canvas.pen.style:=pssolid;
  nTF:=0;
  i:=0;
  nTfd:=kf[rb, 1];
  nTfdd:=kf[rb, 3];
  nind_F:=0;
  while i<tl do begin
    if ntf>=PF[rb,2]/(mater[rb].ky/ddy) then
       PrintZnach(dx+i, dy-round(ntf), floattostr(pf[rb, 2]));;

    canvas.moveto(dx+i, dy-round(ntf));
    inc(i);
    nTf:=nTf+nTfd;
    canvas.lineto(dx+i, dy-round(ntf));
    nTfd:=nTfd+nTfdd;
    if (ntf>=PF[rb,1]/(mater[rb].ky/ddy))and(nind_f=0) then begin
       nind_f:=1;
       nTfd:=kf[rb, 2];
       nTfdd:=kf[rb, 4];
    end;
  end;
end;
//===================================================================
procedure Tlab_4.PrintZnach(x,y:word; znach:string);
begin
  canvas.pen.Color:=clblack;
  canvas.Ellipse(x-1, y-1, x+2, y+2);
  canvas.TextOut(x+5, y-5, znach);
end;
//===================================================================
procedure Tlab_4.Button2Click(Sender: TObject);
begin
  lab_4_inform:=Tlab_4_inform.create(application);
  lab_4_inform.ShowModal;
  panel5.Visible:=true;
  edit1.SetFocus;
end;
//===================================================================
procedure Tlab_4.Button1Click(Sender: TObject);
var r1:real;
    r2:real;
    n:byte;
begin
  try
    r1:=strtofloat(edit1.text);
    lab_4_result:=Tlab_4_result.create(application);
    if mater[rb].t then r2:=314 else r2:=400;
    r2:=PF[rb, 2]*1000/r2;
    n:=lab_4_result.NewShowModal(r1, r2);
    case n of
     0 : edit1.SetFocus;
     1 : begin
           clearwin(canvas, Dx-23, Dy-ly-5, dx+Lx, dy+20, clbtnface, clbtnface);
           PaintXOY(canvas, Dx, Dy, Lx, Ly, ddx, ddy, 2, mater[rb].ky, 10, 10, true);
           tl:=0;
           Paint_Strelka(canvas, sx, sy, sr, tf*(mater[rb].ky/ddy), (mater[rb].ky*10), clbtnface);
           tf:=0;
           Paint_Strelka(canvas, sx, sy, sr, 0, (mater[rb].ky*10), clblack);
           init;
           label11.Caption:='';
           edit1.Text:='0,0';
           btnNewLab.SetFocus;
         end;
      2 : close;
    end;
  except
    showmessage('В поле необходимо ввести число.');
    edit1.SetFocus;
  end;
end;
//===================================================================
procedure Tlab_4.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then button1.SetFocus;
  if key='.' then key:=',';
  if not(key in ['0'..'9',#8,',']) then key:=#0;
end;
//===================================================================
procedure Tlab_4.btnHelpClick(Sender: TObject);
begin
  application.Helpcontext(400);
end;

end.
