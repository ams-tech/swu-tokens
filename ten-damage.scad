include <common.scad>

module ten_damage_token_design() {    

    translate([2 * border_relief + border_thickness + 8.25, base_width / 2, 0])
      rotate(a=[0, 0, 270])
        text("10", size=6, halign="center", font="Star Jedi");
    
    translate([2 * border_relief + border_thickness + 3.5, base_width / 2, 0])
      rotate(a=[0, 0, 270])
        text("ten", size=3.25, halign="center", font="aurebesh");
}

module ten_damage_top_silk() {
    // Top silk
    
    linear_extrude(height=silk_thickness) 
    {
        ten_damage_token_design();
        token_border();
    }
}


module ten_damage_bottom_silk() {
    //bottom silk
    linear_extrude(height=silk_thickness) 
    {
    translate([0,base_width,0])
    rotate([180,0,0])
    ten_damage_token_design();
    token_border();
    }
}

module ten_damage_token_silk() {
    color("red") {
        translate([0,0,base_thickness - silk_thickness])
        ten_damage_top_silk();
        ten_damage_bottom_silk();
    }
}


module ten_damage_token_base() {
    difference() {
        token_base();

        translate([0,0,-silk_thickness])
        scale([1,1,2])
        ten_damage_bottom_silk();
        
        translate([0,0,base_thickness-silk_thickness])
        scale([1,1,2])
        ten_damage_top_silk();
    }
}


ten_damage_token_base();
ten_damage_token_silk();
