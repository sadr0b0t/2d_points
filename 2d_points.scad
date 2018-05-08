
polygon(circle_points(r=3));
translate([10, 0]) polygon(circle_points(r=3, a1=45, a2=270));
translate([20, 0]) polygon(circle_points(r=3, fn=8));
translate([30, 0]) polygon(circle_points(r=3, a1=45, a2=270, fn=8));

/**
 * Сгенерировать массив точек окружности или дуги.
 * 
 * Для полной окружности: a1=0, a2=360
 * 
 * @param r радиус окружности
 * @param fn количество сегментов на полной окружности
 *     (по умолчанию: 100)
 * @param a1 начальный угол дуги
 *     (по умолчанию: 360)
 * @param a2 конечный угол дуги
 *     (по умолчанию: 360)
 * @return массив точек [x,y] окружности или дуги
 */
function circle_points(r=1, a1=0, a2=360, fn=100) = 
    a2 > a1 ? 
        concat(circle_points(r=r, fn=fn, a1=a1, a2=a2-360/fn), [[r*cos(a2), r*sin(a2)]]) :
        [[r*cos(a2), r*sin(a2)]];

