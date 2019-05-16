unit lab_5_const;
interface
const
      MaterCount = 4;
     // константы силоизмерителя
      Sx = 360;    // координата х силоизмерителя
      Sy = 165;    // координата y силоизмерителя
      Sr = 60;     // радиус силоизмерителя

      // допуск для проверки
      Dopusk = 10;

      mater:array [1..MaterCount] of real =
( 520, 400, 360, 120);
implementation

end.
