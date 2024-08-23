include <common.scad>

module five_damage_token_design() {    

    translate([base_height * .4, base_width *.32, 0])
      rotate(a=[0, 0, 270])
        text("5", size=number_font_size, halign="center", font="Star Jedi");
    
    translate([base_height * .83, base_width * .5, 0])
      rotate(a=[0, 0, 270])
        text("five", direction="ttb", size=text_font_size, halign="center", font="aurebesh");
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


five_damage_token_base();
five_damage_token_silk();