# 2d_points
Generate 2D shapes as arrays of points in OpenSCAD

~~~scad
use <2d_points/2d_points.scad>

polygon(circle_points(r=3));
translate([10, 0]) polygon(circle_points(r=3, a1=45, a2=270));
translate([20, 0]) polygon(circle_points(r=3, fn=8));
translate([30, 0]) polygon(circle_points(r=3, a1=45, a2=270, fn=8));
~~~

