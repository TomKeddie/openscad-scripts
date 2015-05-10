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
board="DP5050";
thickness=3;
hole_diameter=3.2;
two_d_render=1;
// customise end

sizes = [
    [ "DP5031" ,    50 , 31 ], 
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


module draw_panel(xsize, ysize) {
    corner_radius=4;

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

for(i = sizes)
{
    if (board == i[0])
    {
        if (two_d_render == 0)
        {
            linear_extrude(height=thickness)
            {
                draw_panel(i[1], i[2]);
            }
        }
        else
        {
            draw_panel(i[1], i[2]);
        }
    }
}