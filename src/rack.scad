use <one-damage.scad>
include <common.scad>


w = 82;
l = 69;
h = 35;

damage_w = 69;
damage_h = 34;
damage_t = 5.5;



wall_thickness = 1.1;
rounding = .5;

w_working = w - 2*rounding;
l_working = l - 2*rounding;
h_working = h - 2*rounding;

initiative_w = 36.6;
initiative_h = 34.6;
initiative_t = 3;

gap = 6;
token_clearance_toleraance = 0.25;

total_token_cutout_x = base_width + 2 * rounding + token_clearance_toleraance;
total_token_cutout_y = base_height + 2 * rounding + token_clearance_toleraance;
total_token_cutout_2d = [total_token_cutout_x, total_token_cutout_y];

token_floor_cutout_scale = 0.66;

dice_side_physical = 19.6;
dice_side = dice_side_physical + token_clearance_toleraance + 2 * rounding;

working_wall = wall_thickness-2*rounding;

module token_cutout_2d() {
    square(total_token_cutout_2d);
}

module token_cutout_3d(total_height) {
    

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

module dice_cutout_3d(total_height) {
    
    translate([0,0,working_wall])
    cube([dice_side,2*dice_side,total_height]);

    translate([dice_side * (1-token_floor_cutout_scale) / 2,dice_side * (1-token_floor_cutout_scale),0])
    scale(token_floor_cutout_scale)
    cube([dice_side,2*dice_side,total_height]);
}

module rack(total_height=h_working) {

    
    w_extra = w_working - 3 * total_token_cutout_y;
    w_offset = w_extra / 4;

    module long_side() {
        for (x = [1:3]) {
            translate([working_wall, x*(w_offset) + (x-1) * total_token_cutout_y,0])
            token_cutout_3d(total_height);
        }
    }

    difference() {
        // The outer cutout
        cube([l_working, w_working, total_height]);
        // near side of y axis
        long_side();
        // far side of y axis
        rotate(180)
        translate([-l_working,-w_working,0])
        long_side();
        // near side of x axis
        rotate(90)
        translate([working_wall,(-total_token_cutout_y-l_working)/2,0])
        token_cutout_3d(total_height);
        // far side of x axis
        translate([(l_working-total_token_cutout_y)/2,w_working-wall_thickness+2*rounding,0])
        rotate(-90)
        token_cutout_3d(total_height);
        //dice cutout in center
        translate([(l_working-dice_side)/2,w_working/2 - dice_side,0])
        dice_cutout_3d(total_height);
    }
}
