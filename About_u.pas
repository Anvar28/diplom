unit About_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tabout = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  about: Tabout;

implementation

{$R *.DFM}

procedure Tabout.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tabout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

end.
