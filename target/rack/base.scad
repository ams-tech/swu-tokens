include <../../src/rack.scad>

$fn = 50;
minkowski()
{

    rack(12);
    sphere(rounding);
}

