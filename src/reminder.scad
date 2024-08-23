include <common.scad>

module reminder_token_design() {    

    translate([base_height * .4, base_width * .3, 0])
      rotate(a=[0, 0, 270])
        text("!", size=number_font_size, halign="center", font="Star Jedi");
    
    translate([base_height * .82, base_width * .42, 0])
      rotate(a=[0, 0, 270])
        text("attn", direction="ttb", size=text_font_size, halign="center", font="aurebesh");
}

module reminder_top_silk() {
    // Top silk
    
    linear_extrude(height=silk_thickness) 
    {
        reminder_token_design();
        token_border();
    }
}


module reminder_bottom_silk() {
    //bottom silk
    linear_extrude(height=silk_thickness) 
    {
    translate([0,base_width,0])
    rotate([180,0,0])
    reminder_token_design();
    token_border();
    }
}

module reminder_token_silk() {
    color("red") {
        translate([0,0,base_thickness - silk_thickness])
        reminder_top_silk();
        reminder_bottom_silk();
    }
}


module reminder_token_base() {
    difference() {
        token_base();

        translate([0,0,-silk_thickness])
        scale([1,1,2])
        reminder_bottom_silk();
        
        translate([0,0,base_thickness-silk_thickness])
        scale([1,1,2])
        reminder_top_silk();
    }
}


reminder_token_base();
reminder_token_silk();
