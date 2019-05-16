unit lab_8_inform_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tlab_8_inform = class(TForm)
    Panel1: TPanel;
    btn: TButton;
    l1: TLabel;
    SB: TScrollBox;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    l7: TLabel;
    l8: TLabel;
    l9: TLabel;
    l10: TLabel;
    l11: TLabel;
    l12: TLabel;
    l14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    l108: TLabel;
    l107: TLabel;
    l110: TLabel;
    l109: TLabel;
    l111: TLabel;
    l113: TLabel;
    l114: TLabel;
    l116: TLabel;
    l115: TLabel;
    l117: TLabel;
    l118: TLabel;
    l119: TLabel;
    l120: TLabel;
    l13: TLabel;
    l100: TLabel;
    l101: TLabel;
    l103: TLabel;
    l104: TLabel;
    l105: TLabel;
    l106: TLabel;
    Label1: TLabel;
    l112: TLabel;
    Label2: TLabel;
    l121: TLabel;
    l122: TLabel;
    l123: TLabel;
    l124: TLabel;
    l125: TLabel;
    Label3: TLabel;
    l126: TLabel;
    l128: TLabel;
    l129: TLabel;
    l130: TLabel;
    l131: TLabel;
    l132: TLabel;
    l133: TLabel;
    l134: TLabel;
    l135: TLabel;
    L137: TLabel;
    l138: TLabel;
    l140: TLabel;
    Label4: TLabel;
    l142: TLabel;
    l143: TLabel;
    l145: TLabel;
    l127: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    l156: TLabel;
    Label7: TLabel;
    procedure btnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  lab_8_inform: Tlab_8_inform;

implementation

{$R *.DFM}

procedure Tlab_8_inform.btnClick(Sender: TObject);
begin
  close;
end;

procedure Tlab_8_inform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

end.
