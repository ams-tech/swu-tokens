include <common.scad>

module five_damage_token_design() {    

    translate([2 * border_relief + border_thickness + 8.25, base_width *.35, 0])
      rotate(a=[0, 0, 270])
        text("5", size=6, halign="center", font="Star Jedi");
    
    translate([base_height * .78, base_width * .55, 0])
      rotate(a=[0, 0, 270])
        text("five", direction="ttb", size=3.5, halign="center", font="aurebesh");
}

module five_damage_top_silk() {
    // Top silk
    
    linear_extrude(height=silk_thickness) 
    {
        five_damage_token_design();
        token_border();
    }
}


module five_damage_bottom_silk() {
    //bottom silk
    linear_extrude(height=silk_thickness) 
    {
    translate([0,base_width,0])
    rotate([180,0,0])
    five_damage_token_design();
    token_border();
    }
}

module five_damage_token_silk() {
    color("red") {
        translate([0,0,base_thickness - silk_thickness])
        five_damage_top_silk();
        five_damage_bottom_silk();
    }
}


module five_damage_token_base() {
    difference() {
        token_base();

        translate([0,0,-silk_thickness])
        scale([1,1,2])
        five_damage_bottom_silk();
        
        translate([0,0,base_thickness-silk_thickness])
        scale([1,1,2])
        five_damage_top_silk();
    }
}
