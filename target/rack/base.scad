use <../../src/rack.scad>

$fn = 50;
minkowski()
{
    rack_base();
    sphere(0.3);
}
