include <polyround.scad>

// Token base properties
base_width = 16;
base_height = 24;
base_thickness = 2.75;

text_font_size = 4;
number_font_size = 6;

// "silkscreen" properties
silk_thickness = 0.5;
border_thickness = 1;
// Distance from the edge of the border to the edge of the token
border_relief = 1;

corner = 1.5;
notch = 5;

module token_base_polygon() {
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
    }
}

module token_insert_floor_polygon() {
    points=[
        [0, base_width, corner],
        [base_height, base_width, corner],
        [base_height, 0, corner],
        [0, 0, corner],
    ];
    polygon(polyRound(points,5));
}

// A shape that can hold the token flipped in either orientation
module token_insert_floor() {

    linear_extrude(height=base_thickness)
    token_insert_floor_polygon();
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

module token_inner_cutout() {
    //Calcuate the scaling factor needed to generate the relief
    width_scale = (base_width - 2 * border_relief) / base_width;
    height_scale = (base_height - 2 * border_relief) / base_height;
    scale([height_scale, width_scale, 1]){
        token_base_polygon();
    }
}