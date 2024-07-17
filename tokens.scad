include <polyround.scad>

// Token base properties
base_width = 16;
base_height = 24;
base_thickness = 3;

// "silkscreen" properties
silk_thickness = 1;
border_thickness = 1;
// Distance from the edge of the border to the edge of the token
border_relief = 1;

token_base();

//one_damage_token_silk();
reminder_token_silk();


module token_base_polygon() {
    corner = 1.5;
    notch = 5;
    
    points=[
        [0, notch, corner],
        [0, base_width, corner],
        [base_height - notch, base_width, corner],
        [base_height, base_width - notch, corner],
        [base_height, 0, corner],
        [notch, 0, corner],
    ];
    polygon(polyRound(points,5));
}

module token_base() {
    difference() {
            linear_extrude(height=base_thickness){        
        token_base_polygon();
    }
        
        translate([border_relief, border_relief, base_thickness - silk_thickness])
          linear_extrude(height = 2 * silk_thickness) {
            token_inner_cutout();
          }

            
    }

}

module damage_token_base_silk() {
    token_border();
}

module token_inner_cutout() {
    //Calcuate the scaling factor needed to generate the relief
    width_scale = (base_width - 2 * border_relief) / base_width;
    height_scale = (base_height - 2 * border_relief) / base_height;
    scale([height_scale, width_scale, 1]){
        token_base_polygon();
    }
}


module token_border() {    

    //Calculate the scaling factor needed to generate the border
    cut_width_scale = (base_width - 2 * (border_relief + border_thickness)) / base_width;
    cut_height_scale = (base_height - 2 * (border_relief + border_thickness)) / base_height;
    
    translate([border_relief, border_relief, 0]) {
        difference(){
            token_inner_cutout();
            translate([border_thickness, border_thickness, 0]) {
                scale([cut_height_scale, cut_width_scale, 1]){
                    token_base_polygon();
                }
            }
        }
    }
}




module ten_damage_token_design() {    

    translate([2 * border_relief + border_thickness + 8.25, base_width / 2, 0])
      rotate(a=[0, 0, 270])
        text("10", size=6, halign="center", font="Star Jedi");
    
    translate([2 * border_relief + border_thickness + 3.5, base_width / 2, 0])
      rotate(a=[0, 0, 270])
        text("ten", size=3.25, halign="center", font="aurebesh");
}


module ten_damage_token_silk() {
    color("red") {
    translate([0,0,base_thickness - silk_thickness]) {
        linear_extrude(height=silk_thickness) {
            ten_damage_token_design();
            token_border();
        }
    }
    }
}




module five_damage_token_design() {    

    translate([2 * border_relief + border_thickness + 8.25, base_width *.35, 0])
      rotate(a=[0, 0, 270])
        text("5", size=6, halign="center", font="Star Jedi");
    
    translate([base_height * .78, base_width * .55, 0])
      rotate(a=[0, 0, 270])
        text("five", direction="ttb", size=4, halign="center", font="aurebesh");
}



module five_damage_token_silk() {
    color("red") {
    translate([0,0,base_thickness - silk_thickness]) {
        linear_extrude(height=silk_thickness) {
            five_damage_token_design();
            token_border();
        }
    }
    }
}



module one_damage_token_design() {    

    translate([base_height * .6, base_width *.3, 0])
      rotate(a=[0, 0, 270])
        text("1", size=6, halign="center", font="Star Jedi");
    
    translate([base_height * .73, base_width * .4, 0])
      rotate(a=[0, 0, 270])
        text("one", direction="ttb", size=5, halign="center", font="aurebesh");
}



module one_damage_token_silk() {
    color("red") {
    translate([0,0,base_thickness - silk_thickness]) {
        linear_extrude(height=silk_thickness) {
            one_damage_token_design();
            token_border();
        }
    }
    }
}


module reminder_token_design() {    

    translate([2 * border_relief + border_thickness + 8.25, base_width *.3, 0])
      rotate(a=[0, 0, 270])
        text("!", size=6, halign="center", font="Star Jedi");
    
    translate([base_height * .78, base_width * .45, 0])
      rotate(a=[0, 0, 270])
        text("attn", direction="ttb", size=4, halign="center", font="aurebesh");
}


module reminder_token_silk() {
        color("red") {
    translate([0,0,base_thickness - silk_thickness]) {
        linear_extrude(height=silk_thickness) {
            reminder_token_design();
            token_border();
        }
    }
    }
}