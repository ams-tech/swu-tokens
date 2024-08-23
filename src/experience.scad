include <common.scad>

module plus_one() {
    translate([-4, 0, 0])
    text("+", size=5, halign="center", font="Marion");
    text("1", size=6, halign="center", font="Star Jedi");
}

module experience_token_design() {    

    translate([base_height * .6, base_width *.48, 0])
      rotate(a=[0, 0, 270])
        plus_one();
    
    translate([base_height * .65, base_width * .08, 0])
    rotate([0, 0, 30])
    square([silk_thickness, base_width * .95]);
    
    translate([base_height * .2, base_width *.38, 0])
      rotate(a=[0, 0, 270])
        plus_one();
}

module experience_top_silk() {
    // Top silk
    
    linear_extrude(height=silk_thickness) 
    {
        experience_token_design();
        token_border();
    }
}


module experience_bottom_silk() {
    //bottom silk
    linear_extrude(height=silk_thickness) 
    {
    translate([0,base_width,0])
    rotate([180,0,0])
    experience_token_design();
    token_border();
    }
}

module experience_token_silk() {
    color("red") {
        translate([0,0,base_thickness - silk_thickness])
        experience_top_silk();
        experience_bottom_silk();
    }
}


module experience_token_base() {
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
