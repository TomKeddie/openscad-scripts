angle = 30;
horizontal_length = 100;
horizontal_width = 25;
foot_percentage = 10;
slot_width = 10;
thickness = 2.7;

diagonal_length = horizontal_length * cos(angle);

horizontal_apex = diagonal_length * cos(angle);
vertical_apex =  diagonal_length * sin(angle);


difference()
{
    union()
    {
        // triangle
        polygon([[0,0],[horizontal_length,0],[horizontal_apex, vertical_apex]],[[0,1,2]]);
        // steps at triangle base
        rotate(a=[0, 0, angle]) square(size=[10, 5]);
        translate([horizontal_length, 0, 0]) rotate(a=[0, 0, angle]) square(size=[5, 10]);
    }
    // slots
    translate([horizontal_length*4/5, vertical_apex/3, 0]) rotate([0,0,90+angle]) square(size=[slot_width, thickness], center=true);
    translate([horizontal_length*2/5, vertical_apex/3, 0]) rotate([0,0,angle]) square(size=[slot_width, thickness], center=true);
}

// insert
translate([0,-slot_width*2-1,0])
difference()
{
    square(size=[horizontal_width+4*thickness, slot_width*2]);
    translate([0,0,0]) square(size=[thickness*2, slot_width/2]);
    translate([0,1.5*slot_width,0]) square(size=[thickness*2, slot_width/2]);
    translate([horizontal_width+thickness*2,0,0]) square(size=[thickness*2, slot_width/2]);
    translate([horizontal_width+thickness*2,1.5*slot_width,0]) square(size=[thickness*2, slot_width/2]);
}