
translate([0, 20, 0]) demo_circle();
demo_rect();

module demo_circle() {
    polygon(circle_points(r=3));
    translate([10, 0]) polygon(circle_points(r=3, a1=45, a2=270));
    translate([20, 0]) polygon(circle_points(r=3, fn=8));
    translate([30, 0]) polygon(circle_points(r=3, a1=45, a2=270, fn=8));
}

module demo_rect() {
    polygon(rect_points([10, 15], center=true));
    translate([15, 0]) polygon(rect_points([10, 15]));
    translate([30, 0]) polygon(rect_points([10, 15], r=4));
    translate([45, 0]) polygon(rect_points([10, 15], r=4, r3=0, r4=2));
}

/**
 * Окружность или дуга.
 * 
 * Для полной окружности: a1=0, a2=360
 * 
 * @param r радиус окружности
 * @param a1 начальный угол дуги
 *     (по умолчанию: 360)
 * @param a2 конечный угол дуги
 *     (по умолчанию: 360)
* @param shift смещение по X и Y
 * @param fn количество сегментов на полной окружности
 *     (по умолчанию: 100)
 * @return массив точек [x,y] окружности или дуги
 */
function circle_points(r=1, a1=0, a2=360, shift=[0,0], fn=100) = 
    a2 > a1 ? 
        concat(
            circle_points(r=r, fn=fn, a1=a1, a2=a2-360/fn, shift=shift),
            [[r*cos(a2)+shift.x, r*sin(a2)+shift.y]]
        ) :
        [[r*cos(a2)+shift.x, r*sin(a2)+shift.y]];

/**
 * Прямоугольник со скругленными углами.
 * 
 * r2 r1
 * r3 r4
 * 
 * @param dim размеры прямоугольника: [x, y]
 * @param center центрировать прямоугольник
 * @param r радиус скругления всех углов
 * @param r1 радиус скругления угла 1 (право, верх)
 * @param r2 радиус скругления угла 2 (лево, верх)
 * @param r3 радиус скругления угла 3 (лево, низ)
 * @param r4 радиус скругления угла 4 (право, низ)
* @param shift смещение по X и Y
 * @param fn количество сегментов на скруглениях окружности
 *     (по умолчанию: 100)
 * @return массив точек [x,y] прямоугольника
 
 */
function rect_points(dim=[1,1], center=false,
        r=0, r1=-1, r2=-1, r3=-1, r4=-1,
        shift=[0,0], fn=100) =  
    concat(
        // право, верх
        (r == 0 && r1 < 0) || r1==0 ?
            [[dim.x - (center?dim.x/2:0) + shift.x, dim.y - (center?dim.y/2:0) + shift.y]] :
            circle_points(
                r=(r1>0?r1:r), a1=0, a2=90,
                shift=[
                    dim.x-(r1>0?r1:r) - (center?dim.x/2:0) + shift.x,
                    dim.y-(r1>0?r1:r) - (center?dim.y/2:0) + shift.y],
                fn=fn),
        // лево, верх
        (r == 0 && r2 < 0) || r2==0 ?
            [[0 - (center?dim.x/2:0) + shift.x, dim.y - (center?dim.y/2:0) + shift.y]] :
            circle_points(
                r=(r2>0?r2:r), a1=90, a2=180,
                shift=[
                    (r2>0?r2:r) - (center?dim.x/2:0) + shift.x,
                    dim.y-(r2>0?r2:r) - (center?dim.y/2:0) + shift.y],
                fn=fn),
        // лево, низ
        (r == 0 && r3 < 0) || r3==0 ?
            [[0 - (center?dim.x/2:0) + shift.x, 0 - (center?dim.y/2:0) + shift.y]] :
            circle_points(
                r=(r3>0?r3:r), a1=180, a2=270,
                shift=[
                    (r3>0?r3:r) - (center?dim.x/2:0) + shift.x,
                    (r3>0?r3:r) - (center?dim.y/2:0) + shift.y],
                fn=fn),
        // право, низ
        (r == 0 && r4 < 0) || r4==0 ?
            [[dim.x - (center?dim.x/2:0) + shift.x, 0 - (center?dim.y/2:0) + shift.y]] :
            circle_points(
                r=(r4>0?r4:r), a1=270, a2=360,
                shift=[
                    dim.x-(r4>0?r4:r) - (center?dim.x/2:0) + shift.x,
                    (r4>0?r4:r) - (center?dim.y/2:0) + shift.y],
                fn=fn)
    );
