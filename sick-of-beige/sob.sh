#!/bin/sh
for sob in DP5031 DP6037 DP7043 DP8049 DP9056 DP10062 DP10080 DP3030 DP4040 DP5050 DP6060 DP7070 DP8080 
do
    echo "Rendering ${sob}"
    OpenSCAD -o ${sob}.dxf -D board=\"${sob}\" -D two_d_render=1 sob.scad
done

