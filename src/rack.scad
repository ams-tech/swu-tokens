use <one-damage.scad>
include <common.scad>


w = 80;
l = 67;
h = 33;


damage_w = 72;
damage_h = 37;
damage_t = 7;


wall_thickness = 1;
rounding = .4;


initiative_w = 37;
initiative_h = 35;
initiative_t = 3.5;

gap = 6;

module initiative_token_cutout() {
    translate([0,0,initiative_t])
    cube([initiative_w , initiative_h, initiative_t * 2], center=true);
}

module damage_token_cutout() {
    translate([0,0,damage_t])
    cube([damage_w, damage_h, damage_t * 2], center=true);
}

module rack_housing() {
    translate([0,0,h/2 - rounding])
    cube([w-2*rounding, l - 2*rounding, h - 2*rounding], center=true);
}

module cutout_single() {
    scale([1.02, 1.02, 2]) 
    translate([0,0,wall_thickness])
    linear_extrude(h)
    {
        square([base_height+4*rounding, base_width+4*rounding]);
    } 
    
    translate([0,0,-5])
    linear_extrude(h + 10 * wall_thickness)
    {
        // The lower cutout
        translate([5 * wall_thickness,  -2*wall_thickness, 0])
        {
            square([base_width - wall_thickness,15*wall_thickness]);
        }
    }
}

module cutout_side() {
       translate([-w/2,-h,0])
       for ( i = [0 : 2] ){
           translate([.5 + i * (base_height + 4 * rounding + .75), wall_thickness, -1]) 
            {
                cutout_single();
            }
        }
}

module rack_base() {
    difference() {
        rack_housing();
        // front long side
        cutout_side();
        // Rear long side
        rotate([0,0,180])
        cutout_side();
        // Narrow sides mid
        translate([w/2 - wall_thickness,-base_height/2-wall_thickness,-1])
        rotate([0,0,90])
        cutout_single();
        rotate([0,0,180])
        translate([w/2 - wall_thickness - 2 * rounding,-base_height/2-wall_thickness,0])
        rotate([0,0,90])
        cutout_single();
        //interior rectangle
        translate([0,0,-3*wall_thickness])
        linear_extrude(2*h)
        minkowski(){
            square([initiative_w - 6*wall_thickness,initiative_w -12*wall_thickness], center=true);
            circle(wall_thickness/2);
        }
        // Initiative token cutout
        translate([0,10,h-initiative_t-damage_t])
        initiative_token_cutout();
        // Damage Counter Cutout
        translate([0,10,h-damage_t])
        damage_token_cutout();

    }
}

minkowski()
{
    rack_base();
    //sphere(rounding);
}


module one_tokens() {
    for ( i = [0 : 9] )
        translate([wall_thickness-w/2, wall_thickness-h, wall_thickness + i * (base_thickness + 0.1)])
            one_damage_token();
}

//one_tokens();

