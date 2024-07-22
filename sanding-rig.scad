include <common.scad>


num_x = 3;
num_y = 5;

gap_size = 3;
// Extra distance inside each hole, in mm
interior_tolerance = .2;

floor_thickness = 2;
exposed_percentage = .5;

// Size to scale down for cutting out of the floor (more saves plastic)
floor_cutout_ratio = .7;

module main_block() {
    // Main block dimensions
    block_y = (base_width + gap_size + interior_tolerance) * num_y - gap_size;
    block_x = (base_height + gap_size + interior_tolerance) * num_x - gap_size;
    block_z = floor_thickness + (1 - exposed_percentage) * base_thickness;

    // Draw the main block
    linear_extrude(block_z)
    minkowski() {
        square([block_x, block_y]);
        circle(r=gap_size);
    }
}

// Calculate the scale of the inserts
base_width_scale = (base_width + interior_tolerance) / base_width;
base_height_scale = (base_height + interior_tolerance) / base_height;

// Cut out the inserts
module inserts()
for(i = [0:num_x-1])
{
    for(j = [0:num_y-1])
    {
        translate([
            (base_height + gap_size + interior_tolerance) * i,
            (base_width + gap_size + interior_tolerance) * j,
            floor_thickness
        ])
        scale([base_height_scale, base_width_scale, 1])
        token_insert_floor();
        
        translate([
            (base_height + gap_size + interior_tolerance) * i + base_height * (1 - floor_cutout_ratio) / 2,
            (base_width + gap_size + interior_tolerance) * j + base_width * (1 - floor_cutout_ratio) / 2,
            -base_thickness
        ])
        scale([floor_cutout_ratio, floor_cutout_ratio, 4 * base_thickness])
        token_insert_floor();
    }
}

difference()
{
    main_block();
    inserts();
}