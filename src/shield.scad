include <common.scad>

module shield_token_design() {    

    translate([base_height * .48, base_width *.5, 0])
      rotate(a=[0, 0, 270])
        text("^", size=number_font_size, halign="center", font="Star Jedi");
    
    translate([base_height * .28, base_width * .49, 0])
      rotate(a=[0, 0, 270])
        text("SHD",  size=3.5, halign="center", font="aurebesh");
}

module shield_top_silk() {
    // Top silk
    
    linear_extrude(height=silk_thickness) 
    {
        shield_token_design();
        token_border();
    }
}


module shield_bottom_silk() {
    //bottom silk
    linear_extrude(height=silk_thickness) 
    {
    translate([0,base_width,0])
    rotate([180,0,0])
    shield_token_design();
    token_border();
    }
}

module shield_token_silk() {
    color("red") {
        translate([0,0,base_thickness - silk_thickness])
        shield_top_silk();
        shield_bottom_silk();
    }
}


module shield_token_base() {
    difference() {
        token_base();

        translate([0,0,-silk_thickness])
        scale([1,1,2])
        shield_bottom_silk();
        
        translate([0,0,base_thickness-silk_thickness])
        scale([1,1,2])
        shield_top_silk();
    }
}


shield_token_base();
shield_token_silk();
