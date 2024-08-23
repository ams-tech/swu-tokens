include <common.scad>


num_x = 4;
num_y = 6;

gap_size = 3;
// Extra distance inside each hole, in mm
interior_tolerance = .3;

floor_thickness = 2;
exposed_percentage = .2;

// Size to scale down for cutting out of the floor (more saves plastic)
floor_cutout_ratio = .7;

grip_offset = 5*base_width;

grip_height = 100;
grip_radius = 15;

module main_block() {
    // Main block dimensions
    block_y = (base_width + gap_size + interior_tolerance) * num_y - gap_size;
    block_x = (base_height + gap_size + interior_tolerance) * num_x - gap_size + grip_offset;
    block_z = floor_thickness + (1 - exposed_percentage) * base_thickness;

    // Draw the main block
    linear_extrude(block_z)
    minkowski() {
        square([block_x, block_y]);
        circle(r=gap_size);
    }
    
    // Draw the grip cylinder
    $fn = 100;
    
    translate([
        block_x - grip_radius - floor_thickness,
        block_y / 2,
        0
    ])
    cylinder(h=grip_height, r=grip_radius);
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