unit lab_1_win_error_u;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TLab_1_win_error = class(TForm)
    Ok: TButton;
    Help: TButton;
    Panel1: TPanel;
    Image1: TImage;
    l_error: TLabel;
    procedure OkClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
  public
    help_con:integer;
  end;

var
  Lab_1_win_error: TLab_1_win_error;
implementation

{$R *.DFM}

procedure TLab_1_win_error.OkClick(Sender: TObject);
begin
  close;
end;

procedure TLab_1_win_error.HelpClick(Sender: TObject);
begin
  application.Helpcommand(help_context, help_con);
end;

end.
