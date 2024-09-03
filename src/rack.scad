use <one-damage.scad>
include <common.scad>


w = 82;
l = 69;
h = 35;

damage_w = 71.5;
damage_h = 34;
damage_t = 5.5;



wall_thickness = 2.1;
rounding = .8;

w_working = w - 2*rounding;
l_working = l - 2*rounding;
h_working = h - 2*rounding;

initiative_w = 36.6;
initiative_h = 33;
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

// initiative token cutout on top
// The top portion of the cutout
_d_w_t = damage_t + rounding + token_clearance_toleraance;
_d_w_w = damage_w + 2*rounding + token_clearance_toleraance;
_d_w_h = damage_h + 2*rounding + token_clearance_toleraance;
_initiative_working_h = initiative_h + 2 *rounding + token_clearance_toleraance;
_initiative_working_w = initiative_w + 2 *rounding + token_clearance_toleraance;
_initiative_working_t = initiative_t + rounding + token_clearance_toleraance;

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
    translate([dice_side*(1-token_floor_cutout_scale)/2,-dice_side/2,working_wall+dice_side*(1-token_floor_cutout_scale)])
    cube([dice_side*token_floor_cutout_scale,3*dice_side,total_height]);

    translate([0,0,working_wall])
    cube([dice_side,2*dice_side,total_height]);

    translate([dice_side * (1-token_floor_cutout_scale) / 2,dice_side * (1-token_floor_cutout_scale),-2*total_height])
    scale(token_floor_cutout_scale)
    cube([dice_side,2*dice_side,4*total_height]);
}

module rack_cutouts(total_height=h_working) {

    
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
        // dice cutout in center
        translate([(l_working-dice_side)/2,w_working/2 - dice_side,total_height-_d_w_t-_initiative_working_t-dice_side])
        dice_cutout_3d(total_height);


        translate([0,0,-_d_w_t])
        {
            translate([(l_working-_initiative_working_h)/2 + 2.5, (w_working - _initiative_working_w)/2 , total_height-_initiative_working_t])
            cube([_initiative_working_h, _initiative_working_w, _initiative_working_t]);
            // damage counter cutout on top

            translate([(l_working-_d_w_h)/2 + 3,(w_working-_d_w_w)/2,total_height])
            cube([_d_w_h, _d_w_w, _d_w_t]);
        }
    }
}

magnet_d = 3.08;
magnet_t = 1.24;
magnet_top = 0.16;

module magnet(total_height) {
    color([1,0,0])
    cylinder(d=magnet_d, h=magnet_t);
}

module magnets(total_height){
    near_x_offset = (l_working-base_height-token_clearance_toleraance-magnet_d-rounding)/2;
    far_x_offset = near_x_offset + base_height+token_clearance_toleraance+magnet_d+rounding;
    near_y_offset = (magnet_d+rounding)/2;
    far_y_offset = w - magnet_d - rounding/2;

    translate([near_x_offset,near_y_offset,0])
    magnet(total_height);

    translate([far_x_offset,near_y_offset,0])
    magnet(total_height);

    translate([near_x_offset,far_y_offset,0])
    magnet(total_height);

    translate([far_x_offset,far_y_offset,0])
    magnet(total_height);
}

$fn = 10;

module rounded_rack(total_height) {
    minkowski(){
        rack_cutouts(total_height-2*rounding);
        sphere(rounding);
    }
}

module rack(total_height=h) {

    difference(){
        rounded_rack(total_height);

        translate([-rounding,-rounding,h_working])
        cube([l,w,h]);

        translate([0,0,h_working-magnet_t-magnet_top])
        magnets();
    }
}

module lid() {
    lip_thickness = 2*wall_thickness;
    top_thickness = magnet_t + 3*magnet_top;

    color("blue")
    difference() {
        translate([l_working/2, w_working/2, 0])
        difference(){
            linear_extrude(top_thickness + lip_thickness)
            minkowski() {
                square([l_working+2*(wall_thickness - rounding), w_working+2*wall_thickness], center=true);
                circle(rounding);
            }
            translate([0,0,top_thickness+rounding])
            linear_extrude(top_thickness + lip_thickness)
            minkowski() {
                square([l_working-2*(rounding)+token_clearance_toleraance, w_working + token_clearance_toleraance], center=true);
                circle(rounding);
            }
        }

        translate([0,0,top_thickness+rounding-magnet_t-magnet_top])
        magnets();
    }
}

lid();
//rack();