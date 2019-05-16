unit lab_7_const;
interface
uses Graphics;
const
      MinHeightPrugina = 60;
      DopuskO = 0.1;   // допуск к осадке
      DopuskP = 0.5;   // допуск к процентам

      // константы графика
      Gx = 290;
      Gy = 268;
      Glx = 190;
      Gly = 150;
      Gdx = 20;
      Gdy = 25;
      Gkx = 20;
      Gky = 50;
      Gkxd = 9;
      Gkyd = 6;

      // константы пружины
      XPrugina = 150;
      YPrugina = 350;      // координата Y расположения пружины

      // константы линейки
      LcountD = 200;        // количество делений
      Ldy = 15;             // через сколько пикселей новый штрих
      Lm = 10;             // масштаб линейки
      Lx = 170;      // координаты левого нижнего угла линейки
      Ly = 350;

      // константы таблицы
      x1 = 75;
      x2 = 151;
      x3 = 244;
      heightZapis = 18;

      // константы счетчиков
      dF_min = 10;
      dF_max = 30;
      dFd = 0.1;// насколько увеличивать или уменьшать значение в поле E_dF

      CountG_min = 4;
      CountG_max = 10;
      CountGd = 1;

      Dsr_min = 15;
      Dsr_max = 25;
      Dsrd = 0.1;

      n_min = 10;
      n_max = 20;
      nd = 1;

      d_min = 2;
      d_max = 4;
      dd = 0.1;

implementation

end.
 