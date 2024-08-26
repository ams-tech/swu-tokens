include <common.scad>

module one_damage_token_design() {    
    translate([base_height * .4, base_width *.3, 0])
      rotate(a=[0, 0, 270])
        text("1", size=number_font_size, halign="center", font="Star Jedi");
    
    translate([base_height * .73, base_width * .48, 0])
      rotate(a=[0, 0, 270])
        text("one", direction="ttb", size=text_font_size, halign="center", font="aurebesh");
}


module one_damage_top_silk() {
    // Top silk
    
    linear_extrude(height=silk_thickness) 
    {
        one_damage_token_design();
        token_border();
    }
}


module one_damage_bottom_silk() {
    //bottom silk
    linear_extrude(height=silk_thickness) 
    {
    translate([0,base_width,0])
    rotate([180,0,0])
    one_damage_token_design();
    token_border();
    }
}

module one_damage_token_silk() {
    color("white") {
        translate([0,0,base_thickness - silk_thickness])
        one_damage_top_silk();
        one_damage_bottom_silk();
    }
}


module one_damage_token_base() {
    color("red") {
        difference() {
            token_base();

            translate([0,0,-silk_thickness])
            scale([1,1,2])
            one_damage_bottom_silk();
            
            translate([0,0,base_thickness-silk_thickness])
            scale([1,1,2])
            one_damage_top_silk();
        }
    }
}

module one_damage_token() {
    one_damage_token_base();
    one_damage_token_silk();
}

one_damage_token();
