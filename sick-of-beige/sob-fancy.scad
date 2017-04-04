// Tom Keddie SoB openscad May 2015
//
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

// customise start
board="BLACKMAGICMINI";
thickness=3;
hole_diameter=3.2;
two_d_render=1;
sob_pcb=0;
corner_radius=4;
// customise end

sizes = [
    [ "BLACKMAGICMINI", 50, 20.5 ],
    [ "SPARKFUNAVR", 48, 31 ],
    [ "ATMELJTAG",  76+5, 45 ],
    [ "FADECANDY",  40 , 22 ],
    [ "DP5031" ,    50 , 31 ], 
    [ "DP5330" ,    53 , 30 ], 
    [ "DP6037" ,    60 , 37 ],  
    [ "DP7043" ,    70 , 43 ],  
    [ "DP8049" ,    80 , 49 ],  
    [ "DP9056" ,    90 , 56 ],  
    [ "DP10062",   100 , 62 ], 
    [ "DP10080",   100 , 80 ],    
    [ "DP3030" ,    30 , 30 ], 
    [ "DP4040" ,    40 , 40 ], 
    [ "DP5050" ,    50 , 50 ], 
    [ "DP6060" ,    60 , 60 ], 
    [ "DP7070" ,    70 , 70 ],
    [ "DP8080" ,    80 , 80 ]];

module user_cutout_blackmagicmini(layer, xsize, ysize)
{
    // USB connector
    translate([-5,ysize/2,0]) square([8, 12], center=true);

    if (layer != "bottom")
    {
        // connector pins
        #translate([xsize+2,ysize/2,0]) square([12, 14], center=true);
    }

    if (layer == "top")
    {
        // swd/serial
        translate([33,2,0]) square([14, 4], center=true);
    }
}

module user_cutout_fadecandy(layer, xsize, ysize)
{
    // USB connector
    translate([-5,ysize/2,0]) square(12, center=true);
    if (layer == "middle1")
    {
        // LED connector
        translate([xsize+5,ysize/2,0]) square([10, ysize], center=true);
        // connector pins
        translate([xsize-4,ysize/2,0]) square([8, ysize], center=true);
        
    }
    if (layer == "middle2")
    {
        // LED connector
        translate([xsize+5,ysize/2,0]) square([10, ysize], center=true);
    }
}

module user_cutout_sparkfunavr(layer, xsize, ysize)
{
    // USB connector
    translate([-5,ysize/2,0]) square(14, center=true);
    if (layer == "middle2")
    {
        translate([xsize, ysize/2, 0]) square([10, 15], center=true);
    }
    if (layer == "top")
    {
        translate([28, 5, 0]) square([15,10], center=true);
    }
}

module user_cutout_atmeljtag(layer, xsize, ysize)
{
    // USB connector
    translate([-5,ysize/2,0]) square(12, center=true);
    if (layer == "middle2")
    {
        // 2mm connectors
        translate([xsize+2.5,ysize/2,0]) square([10, 30], center=true);
    }
}


module user_addin_atmeljtag(layer, xsize, ysize)
{
    if (layer == "middle2")
    {
        // tongue
        square([5, 12.5]);
        translate([0, 35, 0]) square([5, 12.5]);
    }
}


module user_cutout_buspirate(layer, xsize, ysize)
{
    // USB connector
    translate([-5,ysize/2,0]) square(14, center=true);

    if (layer == "top")
    {
        // 5 x 2 i/o connector
        translate([46, 11, 0]) scale([7, 14, 1]) square(1);

        // icsp
        translate([19, 0, 0]) scale([14, 4, 1]) square(1);
    }
}

module user_cutout(layer, xsize, ysize)
{
    if (board == "SPARKFUNAVR")
    {
        user_cutout_sparkfunavr(layer, xsize, ysize);
    }
    else if (board == "ATMELJTAG")
    {
        user_cutout_atmeljtag(layer, xsize, ysize);
    }
    else if (board == "FADECANDY")
    {
        user_cutout_fadecandy(layer, xsize, ysize);
    }
    else if (board == "BLACKMAGICMINI")
    {
        user_cutout_blackmagicmini(layer, xsize, ysize);
    }
}

module user_addin(layer, xsize, ysize)
{
    if (board == "ATMELJTAG")
    {
        user_addin_atmeljtag(layer, xsize, ysize);
    }
}

module draw_pcb_sob(xsize, ysize)
{
    difference()
    {
        hull()
        {
            translate([corner_radius, corner_radius, 0]) circle(r=corner_radius, $fn=32);
            translate([xsize-corner_radius, corner_radius, 0]) circle(r=corner_radius, $fn=32);
            translate([corner_radius, ysize-corner_radius, 0]) circle(r=corner_radius, $fn=32);
            translate([xsize-corner_radius, ysize-corner_radius, 0]) circle(r=corner_radius, $fn=32);
        }
        translate([corner_radius, corner_radius, 0]) circle(r=hole_diameter/2, $fn=32);
        translate([xsize-corner_radius, corner_radius, 0]) circle(r=hole_diameter/2, $fn=32);
        translate([corner_radius, ysize-corner_radius, 0]) circle(r=hole_diameter/2, $fn=32);
        translate([xsize-corner_radius, ysize-corner_radius, 0]) circle(r=hole_diameter/2, $fn=32);
    }
}

module draw_pcb_rectangle(xsize, ysize)
{
    scale([xsize, ysize, 1]) square(1);
}

module draw_pcb(xsize, ysize)
{
    if (sob_pcb != 0)
    {
        draw_pcb_sob(xsize, ysize);
    }
    else
    {
        draw_pcb_rectangle(xsize, ysize);
    }
}

module circle_radius(x1, y1, x2, y2, x3, y3)
{
    // virtex lengths
    a = sqrt(pow(x2-x1, 2) + pow(y2-y1, 2));
    b = sqrt(pow(x3-x2, 2) + pow(y3-y2, 2));
    c = sqrt(pow(x3-x1, 2) + pow(y3-y1, 2));

    // area
    // http://www.mathopenref.com/heronsformula.html
    p = (a + b + c) / 2;
    k = sqrt(p * (p - a) * (p - b) * (p - c));
    
    // http://math.stackexchange.com/questions/133638/how-does-this-equation-to-find-the-radius-from-3-points-actually-work
    r = (a * b * c) / ( 4 * k);

    if (x1 == x2)
    {
        if (x3 > 0)
        {
            translate([x3+r, y3, 0]) circle(r = r, $fn=128);
        }
        else
        {
            translate([x3-r, y3, 0]) circle(r = r, $fn=128);
        }
    }
    else
    {
        if (y3 > 0)
        {
            translate([x3, y3+r, 0]) circle(r = r, $fn=256);
        }
        else
        {
            translate([x3, y3-r, 0]) circle(r = r, $fn=256);
        }
    }
}


module intersect_circle(x1, y1, x2, y2, deflection)
{
    if (x1 == x2)
    {
        // calculate y3
        x3 = x1 - deflection;
        y3 = y1 + (y2 - y1)/2;
        circle_radius(x1, y1, x2, y2, x3, y3);
    }
    else
    {
        // calculate x
        x3 = x1 + (x2 - x1)/2;
        y3 = y1 - deflection;
        circle_radius(x1, y1, x2, y2, x3, y3);
    }
}

module draw_case(xsize, ysize) {
    case_corner_radius=7;
    pcb_corner_radius=4;
    curve_depth=4;
    distance_to_pcb_corner=sqrt(pow(pcb_corner_radius, 2) + pow(pcb_corner_radius, 2)) - pcb_corner_radius;
    distance_to_case_corner_centre=case_corner_radius-distance_to_pcb_corner;
    offset_to_case_corner_centre=sqrt(pow(distance_to_case_corner_centre, 2) / 2); 
    difference() {
        union() {
            // corner circles
            translate([-offset_to_case_corner_centre, -offset_to_case_corner_centre, 0]) circle(r=case_corner_radius, $fn=32);
            translate([xsize+offset_to_case_corner_centre, -offset_to_case_corner_centre, 0]) circle(r=case_corner_radius, $fn=32);
            translate([-offset_to_case_corner_centre, ysize+offset_to_case_corner_centre, 0]) circle(r=case_corner_radius, $fn=32);
            translate([xsize+offset_to_case_corner_centre, ysize+offset_to_case_corner_centre, 0]) circle(r=case_corner_radius, $fn=32);
            difference() {
                // rectangle to enclose them
                translate([-2*offset_to_case_corner_centre, -2*offset_to_case_corner_centre, 0]) scale([xsize+4*offset_to_case_corner_centre,ysize+4*offset_to_case_corner_centre,0]) square(1);
                // curved edges
                x11=-2*offset_to_case_corner_centre;
                y11=-offset_to_case_corner_centre+sqrt(pow(case_corner_radius, 2)-pow(offset_to_case_corner_centre, 2));
                x12=x11;
                y12=ysize+offset_to_case_corner_centre-sqrt(pow(case_corner_radius, 2)-pow(offset_to_case_corner_centre, 2));
                intersect_circle(x11, y11, x12, y12, -curve_depth);
                
                x21=-offset_to_case_corner_centre+sqrt(pow(case_corner_radius, 2)-pow(offset_to_case_corner_centre, 2));
                y21=-2*offset_to_case_corner_centre;
                x22=xsize+offset_to_case_corner_centre-sqrt(pow(case_corner_radius, 2)-pow(offset_to_case_corner_centre, 2));
                y22=y21;
                intersect_circle(x21, y21, x22, y22, -curve_depth);

                x31=xsize+2*offset_to_case_corner_centre;
                y31=y11;
                x32=x31;
                y32=y12;
                intersect_circle(x31, y31, x32, y32, curve_depth);

                x41=x21;
                y41=ysize+2*offset_to_case_corner_centre;
                x42=x22;
                y42=y41;
                intersect_circle(x41, y41, x42, y42, curve_depth);
            }
        }
        // screw holes in corners
        translate([-offset_to_case_corner_centre, -offset_to_case_corner_centre, 0]) circle(r=hole_diameter/2, $fn=32);
        translate([xsize+offset_to_case_corner_centre, -offset_to_case_corner_centre, 0]) circle(r=hole_diameter/2, $fn=32);
        translate([-offset_to_case_corner_centre, ysize+offset_to_case_corner_centre, 0]) circle(r=hole_diameter/2, $fn=32);
        translate([xsize+offset_to_case_corner_centre, ysize+offset_to_case_corner_centre, 0]) circle(r=hole_diameter/2, $fn=32);
    }
}

module draw_layer_top(x, y)
{
    difference()
    {
        union()
        {
            draw_case(x, y);
            user_addin("top", x, y);
        }
        user_cutout("top", x, y);
    }
}

module draw_layer_middle1(x, y)
{
    difference()
    {
        union()
        {
            difference()
            {
                draw_case(x, y);
            }
            user_addin("middle1", x, y);
        }
        user_cutout("middle1", x, y);
    }
}

module draw_layer_middle2(x, y)
{
    difference()
    {
        union()
        {
            difference()
            {
                draw_case(x, y);
                draw_pcb(x, y);
            }
            user_addin("middle2", x, y);
        }
        user_cutout("middle2", x, y);
    }
}

module draw_layer_bottom(x, y)
{
    difference()
    {
        union()
        {
            draw_case(x, y);
            user_addin("bottom", x, y);
        }
        user_cutout("bottom", x, y);
    }
}

module draw_layers(x, y)
{
    translate([0,  y+22, 0]) draw_layer_top(x,y);
    translate([0,     0, 0]) draw_layer_bottom(x,y);
    translate([0, -y-22, 0])   draw_layer_middle1(x, y);
    translate([0, -2*y-44, 0]) draw_layer_middle2(x, y);
}


for(i = sizes)
{
    if (board == i[0])
    {
        if (two_d_render == 0)
        {
            linear_extrude(height=thickness)
            {
                draw_layers(i[1], i[2]);
            }
        }
        else
        {
            draw_layers(i[1], i[2]);
        }
    }
}

