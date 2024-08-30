use <one-damage.scad>
include <common.scad>


w = 82;
l = 69;
h = 35;

damage_w = 72;
damage_h = 37;
damage_t = 7;


wall_thickness = 1.1;
rounding = .5;

w_working = w - 2*rounding;
l_working = l - 2*rounding;
h_working = h - 2*rounding;

initiative_w = 39;
initiative_h = 31;
initiative_t = 3.5;

gap = 6;
token_clearance_toleraance = 0.5;

total_token_cutout_x = base_width + 2 * rounding + token_clearance_toleraance;
total_token_cutout_y = base_height + 2 * rounding + token_clearance_toleraance;
total_token_cutout_2d = [total_token_cutout_x, total_token_cutout_y];

module token_cutout_2d() {
    square(total_token_cutout_2d);
}

module token_cutout_3d(total_height) {
    token_floor_cutout_scale = 0.66;

    translate([0,0,wall_thickness-rounding])
    linear_extrude(total_height)
    token_cutout_2d();

    linear_extrude(total_height)
    translate([0,(1-token_floor_cutout_scale)*total_token_cutout_y/2])
    scale(token_floor_cutout_scale)
    {
    token_cutout_2d();
    translate([-wall_thickness, 0, 0])
    token_cutout_2d();
    }
}

module minimal_token_housing(total_height=h_working) {

    difference() {
        cube([l_working, w_working, total_height]);
        

        l_extra = l_working - 3 * total_token_cutout_x;

        l_offset = l_extra / 3;

        for (x = [1:3]) {
            translate([wall_thickness-2*rounding,wall_thickness-2*rounding,0])
            token_cutout_3d(total_height);
        }

    }

}