include <ucon_config.scad>
use <ucon_functions.scad>
use <MCAD/motors.scad>
use <MCAD/nuts_and_bolts.scad>
$fn=100;


bearing1OD = 13+4;  //xend bearingOD w/ fender
bearing2OD = 22+4;  //idler bearingOD w/ fender
pulleyOD = 25.5; // motor pulleyOD
nema17 = 42.3; // motor size
xoff = 10; // offset of the xend toward the conduit
bearing1H = 5;
bearing2H = 7;


//translate([0,0,0]) bearingPlate(bearing=1);
//translate([-35-2,0,0]) scale([-1,1,1]) bearingPlate();
//translate([-35-2,35+2,0]) scale([-1,-1,1]) bearingPlate();
//translate([0,35+2,0]) scale([1,-1,1]) bearingPlate();

translate([0,0,0]) rotate([0,0,0]) bearingFender();

module bearingFender(){
difference(){
union(){
cylinder(r=bearing2OD/2,h=bearing2H+9);
cylinder(r1=bearing2OD/2+2,r2=bearing2OD/2,h=4);
translate([0,0,bearing2H+9-4]) cylinder(r2=bearing2OD/2+2,r1=bearing2OD/2,h=4);}
cylinder(r=(bearing2OD-8)/2,h=100,center=true);
translate([0,0,5.01]) cylinder(r=(bearing2OD-4)/2,h=bearing2H+10);
}

difference(){
union(){
cylinder(r=13/2,h=2);
cylinder(r=8/2,h=(7+2)/2);}
cylinder(r=2+0.1,h=30,center=true);}

translate([0,24,0])
difference(){
union(){
cylinder(r=13/2,h=2);
cylinder(r=8/2,h=(7+2)/2);}
cylinder(r=2+0.1,h=30,center=true);}

}

module bearingPlate(bearing=0){

difference(){
union(){
translate([0,0,3]) quadflatFlange1(0,0,0,35.01,35,16,10);

translate([0,0,-10/2]) linear_extrude(height=10)
difference(){
hull(){
square(35,center=true);
// align the motor pulley and xend bearing to rod center
translate([35/2+pulleyOD/2+bearing1OD/2+nema17/2-xoff,0,0])
square(12,center=true);

}

hull(){
square(25,center=true);
// align the motor pulley and xend to rod center
translate([35/2+pulleyOD/2+bearing1OD/2+nema17/2-xoff-12,0,0])
square(8,center=true);
}
// make hole for linear rod
translate([35/2+pulleyOD/2+bearing1OD/2+nema17/2-xoff,0,0])
circle(4,center=true);

// make slot for flex
translate([35/2+pulleyOD/2+bearing1OD/2+nema17/2-xoff+1,0,0])
square([12,1],center=true);

// remove excess
square(35.01,center=true);
}

if (bearing==1){
// align the idler mount
translate([35/2-pulleyOD/2+bearing2OD/2+nema17/2,-35/2+3,0])
cube([10,14,10],center=true);

// warning -- manually aligned
translate([35/2-pulleyOD/2+bearing2OD/2+nema17/2-10/2,-12.5,0]) rotate([0,0,17]) 
fillet(6,10);

translate([35/2-pulleyOD/2+bearing2OD/2+nema17/2+10/2-0.5,-8.5,0]) rotate([0,0,180-85]) 
fillet(6,10);}

if (bearing==2){
// align the idler mount
rotate([0,0,180])
translate([-35/2+pulleyOD/2-bearing2OD/2-nema17/2,-35/2+3,0])
cube([10,14,10],center=true);

rotate([0,0,180])
// warning -- manually aligned
translate([-35/2+pulleyOD/2-bearing2OD/2-nema17/2+10/2,-12.5,0]) rotate([0,0,90-17]) 
fillet(6,10);

rotate([0,0,180])
translate([-35/2+pulleyOD/2-bearing2OD/2-nema17/2-10/2+0.5,-8.5,0]) rotate([0,0,-5]) 
fillet(6,10);}

}


if (bearing==1){
translate([35/2-pulleyOD/2+bearing2OD/2+nema17/2,-35/2,0])
rotate([90,0,0]) cylinder(r=2+tolerance,h=30,center=true);

translate([35/2-pulleyOD/2+bearing2OD/2+nema17/2,-35/2+8,0])
rotate([90,0,0]) rotate([0,0,90]) nutSlot(12,tolerance);}

else if (bearing==2){
rotate([0,0,180])
translate([-35/2+pulleyOD/2-bearing2OD/2-nema17/2,-35/2,0])
rotate([90,0,0]) cylinder(r=2+tolerance,h=30,center=true);

rotate([0,0,180])
translate([-35/2+pulleyOD/2-bearing2OD/2-nema17/2,-35/2+8,0])
rotate([90,0,0]) rotate([0,0,90]) nutSlot(12,tolerance);}

}

}


module fillet(rad,height){
translate([-rad,-rad,0])
difference(){
translate([0,0,-height/2]) cube([rad+0.01,rad+0.01,height]);
cylinder(h=height+1,r=rad,center=true);
}}

module bottom_clip(){
difference(){
union(){
cylinder(r=bearingOD/2+3,h=4,center=true);
translate([0,0,3]) cylinder(r=bearingID/2+2,h=2+0.01,center=true);
translate([0,0,bearingH/2+4]) cylinder(r=bearingID/2,h=bearingH+0.01,center=true);

}
translate([0,0,1]) boltHole(4,length=30,tolerance=tolerance);
cylinder(r=4/2+tolerance,h=60, center=true);
}}