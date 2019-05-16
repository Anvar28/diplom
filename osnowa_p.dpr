program osnowa_p;

uses
  Forms,
  osnowa_u in 'osnowa_u.pas' {osnowa},
  Lab1_u in 'Lab1_u.pas' {lab_1},
  lab2_u in 'lab2_u.pas' {lab_2},
  lab_1_win_error_u in 'lab_1_win_error_u.pas' {Lab_1_win_error},
  lab_2_wwod_ugol_u in 'lab_2_wwod_ugol_u.pas' {lab_2_wwod_ugol},
  lab_2_inform_u in 'lab_2_inform_u.pas' {lab_2_inform},
  lab_2_result_u in 'lab_2_result_u.pas' {lab_2_result},
  lab3_u in 'lab3_u.pas' {lab_3},
  lab4_u in 'lab4_u.pas' {lab_4},
  lab5_u in 'lab5_u.pas' {lab_5},
  lab_3_inform_u in 'lab_3_inform_u.pas' {lab_3_inform},
  lab_3_result_u in 'lab_3_result_u.pas' {lab_3_result},
  lab_3_const in 'lab_3_const.pas',
  About_u in 'About_u.pas' {about},
  graph in 'graph.pas',
  lab6_u in 'lab6_u.pas' {lab_6},
  lab7_u in 'lab7_u.pas' {lab_7},
  lab_4_const in 'lab_4_const.pas',
  lab_4_inform_u in 'lab_4_inform_u.pas' {lab_4_inform},
  lab_4_result_u in 'lab_4_result_u.pas' {Lab_4_result},
  lab_5_const in 'lab_5_const.pas',
  lab_5_inform_u in 'lab_5_inform_u.pas' {lab_5_inform},
  lab_5_result_u in 'lab_5_result_u.pas' {lab_5_result},
  lab_6_const in 'lab_6_const.pas',
  lab_7_const in 'lab_7_const.pas',
  lab_7_inform_u in 'lab_7_inform_u.pas' {lab_7_inform},
  lab_7_result_u in 'lab_7_result_u.pas' {lab_7_result},
  lab8_u in 'lab8_u.pas' {lab_8},
  lab_8_const in 'lab_8_const.pas',
  lab_8_inform_u in 'lab_8_inform_u.pas' {lab_8_inform},
  lab_8_result_u in 'lab_8_result_u.pas' {lab_8_result},
  lab_6_inform_u in 'lab_6_inform_u.pas' {lab_6_inform},
  lab_6_result_u in 'lab_6_result_u.pas' {lab_6_result},
  uGlobal in 'uGlobal.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tosnowa, osnowa);
  Application.Run;
end.
