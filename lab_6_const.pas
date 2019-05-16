unit lab_6_const;
interface
const
      dopusk = 1;
     // константы углоизмерителя
      Ux = 123;
      Uy = 420;
      Ur = 60;
      Us = 20;

     // скручивающий момент
      Mx = 368;
      My = 420;
      Mr = 60;
      Ms = 2000;

     // константы рисунка
      Rx1 = 60;
      Ry = 60;

      G = 79200;   // примерный модуль сдвига

     // константы для таблицы
      HZ = 18;
      x1 = 0;
      x2 = 113;
      x3 = 169;
      x4 = 221;

type m = record
       min : real;
       max : real;
       d   : real;
     end;

const mater : array [1..3] of m =
((min:2; max:5; d:0.1), (min:100; max:250; d:1), (min:3; max:10; d:1));

implementation

end.
