unit lab_4_inform_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tlab_4_inform = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  lab_4_inform: Tlab_4_inform;

implementation

{$R *.DFM}

procedure Tlab_4_inform.Button1Click(Sender: TObject);
begin
  close;
end;

procedure Tlab_4_inform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=cafree;
end;

end.
