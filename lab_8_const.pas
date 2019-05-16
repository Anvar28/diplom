unit lab_8_const;
interface

type
     p1=record
       min : real;
       max : real;
       d   : real;
     end;

const param: array [1..6] of p1=
((min:20; max:60; d:1),
 (min:20; max:60; d:1),
 (min:20; max:60; d:1),
 (min:20; max:60; d:1),
 (min:2;  max:4;   d:0.1),
 (min:8; max:15; d:1));

     R1X :word = 0;        // константы 1 рисунка
     R1Y :word = 50;
     R2Y :word = 300;
     H1  :byte = 40;        //
     p   :byte = 4;
     Hk  :byte = 20;
     ot  :byte = 10;
     ho  :byte = 20;

     dopusk = 0.5;

implementation

end.
