unit lab_5_inform_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tlab_5_inform = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  lab_5_inform: Tlab_5_inform;

implementation

{$R *.DFM}

procedure Tlab_5_inform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tlab_5_inform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

end.
