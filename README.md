# 2d_points
Generate 2D shapes as arrays of points in OpenSCAD

~~~scad
use <2d_points/2d_points.scad>
~~~

Draw arcs and circles
~~~
    polygon(circle_points(r=3));
    translate([10, 0]) polygon(circle_points(r=3, a1=45, a2=270));
    translate([20, 0]) polygon(circle_points(r=3, fn=8));
    translate([30, 0]) polygon(circle_points(r=3, a1=45, a2=270, fn=8));
~~~

Draw rounded rect
~~~scad
    polygon(rect_points([10, 15], center=true));
    translate([15, 0]) polygon(rect_points([10, 15]));
    translate([30, 0]) polygon(rect_points([10, 15], r=4));
    translate([45, 0]) polygon(rect_points([10, 15], r=4, r3=0, r4=2));
~~~

