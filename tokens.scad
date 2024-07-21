
include <one-damage.scad>
include <five-damage.scad>
include <ten-damage.scad>

one_damage_token_base();
//one_damage_token_silk();

//five_damage_token_base();
//five_damage_token_silk();

//ten_damage_token_base();
//ten_damage_token_silk();

//reminder_token_silk();
//experience_token_silk();
//shield_token_silk();

module damage_token_base_silk() {
    token_border();
}


module reminder_token_design() {    

    translate([base_height * .2, base_width *.65, 0])
      rotate(a=[0, 0, 270])
        text("!", size=12, halign="center", font="Star Jedi");
    
    translate([base_height * .78, base_width * .18, 0])
      rotate(a=[0, 0, 270])
        text("attn", direction="ttb", size=3, halign="center", font="aurebesh");
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

module plus_one() {
    translate([-4, 0, 0])
    text("+", size=5, halign="center", font="Marion");
    text("1", size=6, halign="center", font="Star Jedi");
}

module experience_token_design() {    

    translate([base_height * .6, base_width *.5, 0])
      rotate(a=[0, 0, 270])
        plus_one();
    
    translate([base_height * .65, base_width * .08, 0])
    rotate([0, 0, 30])
    square([silk_thickness, base_width * .95]);
    
    translate([base_height * .2, base_width *.38, 0])
      rotate(a=[0, 0, 270])
        plus_one();
}


module experience_token_silk() {
        color("red") {
    translate([0,0,base_thickness - silk_thickness]) {
        linear_extrude(height=silk_thickness) {
            experience_token_design();
            token_border();
        }
    }
    }
}

module shield_token_design() {    

    translate([base_height * .65, base_width *.32, 0])
      rotate(a=[0, 0, 270])
        text("^", size=4, halign="center", font="Star Jedi");
    
    translate([base_height * .82, base_width * .5, 0])
      rotate(a=[0, 0, 270])
        text("Shield", direction="ttb", size=3, halign="center", font="aurebesh");
}


module shield_token_silk() {
        color("red") {
    translate([0,0,base_thickness - silk_thickness]) {
        linear_extrude(height=silk_thickness) {
            shield_token_design();
            token_border();
        }
    }
    }
}