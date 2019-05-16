unit lab_2_inform_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tlab_2_inform = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  lab_2_inform: Tlab_2_inform;

implementation

{$R *.DFM}

procedure Tlab_2_inform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tlab_2_inform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=cafree;
end;

end.
