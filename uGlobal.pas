unit uGlobal;

interface
uses
  Windows;

Const
  stRetryLab = 'А сейчас мы сделаем лабораторную работу еще раз.';

  // Выдает на экран окошко с вопросом и возвращает да/нет
  Function MyMessageBox(aText: String; aCaption: String): Boolean;

  // Выдает окно ошибки
  Procedure MyErrorBox(aText:String);

implementation

// -----------------------------------------------------------------
// Выдает на экран окошко с вопросом и возвращает да/нет
Function MyMessageBox(aText: String; aCaption: String): Boolean;
Begin
  if MessageBox(0, PChar(aText), PChar(aCaption), MB_YESNO) = IDYES
  then Result := true
  else Result := false;
End;

// -----------------------------------------------------------------
// Выдает окно ошибки
Procedure MyErrorBox(aText:String);
Begin
  MessageBox(0, PChar(aText), 'Ошибка', MB_OK or MB_ICONERROR);
End;


end.
