include <../../src/rack.scad>

$fn = 50;
minkowski()
{
    minimal_token_housing(12);
    sphere(rounding);
}

