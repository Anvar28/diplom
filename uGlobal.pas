unit uGlobal;

interface
uses
  Windows;

Const
  stRetryLab = '� ������ �� ������� ������������ ������ ��� ���.';

  // ������ �� ����� ������ � �������� � ���������� ��/���
  Function MyMessageBox(aText: String; aCaption: String): Boolean;

  // ������ ���� ������
  Procedure MyErrorBox(aText:String);

implementation

// -----------------------------------------------------------------
// ������ �� ����� ������ � �������� � ���������� ��/���
Function MyMessageBox(aText: String; aCaption: String): Boolean;
Begin
  if MessageBox(0, PChar(aText), PChar(aCaption), MB_YESNO) = IDYES
  then Result := true
  else Result := false;
End;

// -----------------------------------------------------------------
// ������ ���� ������
Procedure MyErrorBox(aText:String);
Begin
  MessageBox(0, PChar(aText), '������', MB_OK or MB_ICONERROR);
End;


end.
