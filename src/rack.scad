$fn=100;
use <one-damage.scad>
include <common.scad>


w = 82;
l = 69;
h = 35;

initiative_w = 37;
initiative_h = 35;
initiative_t = 3.5;

damage_w = 70;
damage_h = 35;
damage_t = 6;


wall_thickness = 2.5;
rounding = 1;

gap = 6;

module initiative_token_cutout() {
    translate([0,0,initiative_t])
    cube([initiative_w, initiative_h, initiative_t * 2], center=true);
}

module damage_token_cutout() {
    translate([0,0,damage_t])
    cube([damage_w, damage_h, damage_t * 2], center=true);
}

module rack_housing() {
    translate([rounding, rounding,0])
    linear_extrude(h-1)
    minkowski() {
        square([w - rounding -1, l - rounding -1], center=true);
        circle(rounding);
    }
}

module cutout_single() {
    scale([1.02, 1.02, 2]) 
    translate([0,0,wall_thickness])
    linear_extrude(h)
    {
        token_insert_floor_polygon();
    } 
    
    translate([0,0,-5])
    linear_extrude(h + 10 * wall_thickness)
    {
        // The lower cutout
        translate([2 * wall_thickness, -3 *wall_thickness, 0])
        {
            square([base_width - wall_thickness,5*wall_thickness]);
        }
        inner_cutout_scale = .75;
        translate(
            [base_height * (1 - inner_cutout_scale) / 2,
             base_width * (1 - inner_cutout_scale) / 2,
             0
            ])
        scale([inner_cutout_scale, inner_cutout_scale, 0])
        token_insert_floor_polygon();
    }
}

module cutout_side() {
       translate([-w/2,-h,0])
       for ( i = [0 : 2] ){
           translate([wall_thickness + i * (base_height + wall_thickness), wall_thickness, -1]) 
            {
                cutout_single();
            }
        }
}


difference() {
    rack_housing();
    // front long side
    cutout_side();
    // Rear long side
    rotate([0,0,180])
    cutout_side();
    // Narrow sides mid
    translate([w/2,-base_height/2,-1])
    rotate([0,0,90])
    cutout_single();
    rotate([0,0,180])
    translate([w/2 - wall_thickness,-base_height/2,0])
    rotate([0,0,90])
    cutout_single();
    //interior rectangle
    translate([0,0,-3*wall_thickness])
    linear_extrude(2*h)
    minkowski(){
        square([initiative_w - 4*wall_thickness,initiative_w - 4*wall_thickness], center=true);
        circle(wall_thickness/2);
    }
    // Initiative token cutout
    translate([0,15,h-initiative_t-damage_t])
    initiative_token_cutout();
    // Damage Counter Cutout
    translate([0,15,h-damage_t])
    damage_token_cutout();

}


module one_tokens() {
    for ( i = [0 : 9] )
        translate([wall_thickness-w/2, wall_thickness-h, wall_thickness + i * (base_thickness + 0.1)])
            one_damage_token();
}

//one_tokens();

