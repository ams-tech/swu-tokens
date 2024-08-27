include <common.scad>

module epic_action_token_design() {    

    translate([base_height * .3, base_width *.5, 0])
      rotate(a=[0, 0, 270])
        text("x", size=9, halign="center", font="Star Jedi");
 
    translate([base_height * .7, base_width * .48, 0])
      rotate(a=[0, 0, 270])
        text("ep", size=3, halign="center", font="aurebesh");

    translate([base_height * .15, base_width * .5, 0])
      rotate(a=[0, 0, 270])
        text("ic", size=3, halign="center", font="aurebesh");     
}

module experience_top_silk() {
    // Top silk
    
    linear_extrude(height=silk_thickness) 
    {
        epic_action_token_design();
        token_border();
    }
}


module experience_bottom_silk() {
    //bottom silk
    linear_extrude(height=silk_thickness) 
    {
    translate([0,base_width,0])
    rotate([180,0,0])
    epic_action_token_design();
    token_border();
    }
}

module epic_action_token_silk() {
    color("red") {
        translate([0,0,base_thickness - silk_thickness])
        experience_top_silk();
        experience_bottom_silk();
    }
}


module epic_action_token_base() {
    difference() {
        token_base();

        translate([0,0,-silk_thickness])
        scale([1,1,2])
        experience_bottom_silk();
        
        translate([0,0,base_thickness-silk_thickness])
        scale([1,1,2])
        experience_top_silk();
    }
}


epic_action_token_base();
epic_action_token_silk();