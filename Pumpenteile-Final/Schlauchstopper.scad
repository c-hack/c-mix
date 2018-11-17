//Schlauchstopper

difference(){
cylinder(h=20, r=7, $fn=60);
	translate([0,0,-0.1])
	cylinder(h=30, r=4, $fn=60);

    translate([20,30,50]) rotate([90,0,0]) cylinder(r=40, h=50, $fn=200);
}