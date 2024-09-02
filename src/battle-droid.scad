include <common.scad>

module battle_droid_token_design() {

translate([base_height*.5, base_width*.5,0])
scale(.07)
rotate(-90)
import("droid-head.svg", center=true);

    translate([base_height * .69, base_width * .5, 0])
      rotate(a=[0, 0, 270])
        text("battle",  size=1.5, halign="center", font="aurebesh");

    translate([base_height * .25, base_width * .5, 0])
      rotate(a=[0, 0, 270])
        text("droid",  size=1.5, halign="center", font="aurebesh");
}


module battle_droid_top_silk() {
    // Top silk
    
    linear_extrude(height=silk_thickness) 
    {
        battle_droid_token_design();
        token_border();
    }
}

module battle_droid_bottom_silk() {
    //bottom silk
    linear_extrude(height=silk_thickness) 
    {
    translate([0,base_width,0])
    rotate([180,0,0])
    battle_droid_token_design();
    token_border();
    }
}

module battle_droid_token_silk() {
    color("tan") {
        translate([0,0,base_thickness - silk_thickness])
        battle_droid_top_silk();
        battle_droid_bottom_silk();
    }
}


module battle_droid_token_base() {
    color("brown") {
        difference() {
            token_base();

            translate([0,0,-silk_thickness])
            scale([1,1,2])
            battle_droid_bottom_silk();
            
            translate([0,0,base_thickness-silk_thickness])
            scale([1,1,2])
            battle_droid_top_silk();
        }
    }
}

module battle_droid_token() {
    battle_droid_token_base();
    battle_droid_token_silk();
}

battle_droid_token();

