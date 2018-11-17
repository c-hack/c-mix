// 3.2mm Durchgangslöcher

translate([2.5,-3,0]) 
translate([1.9,1.9,0]) rotate ([0,0,45]) cube([4,7,14]);
difference(){
cylinder(h=2.5, r=30, $fn=60); 
/*	translate([23,0,-0.1])
	cylinder (h=4, r=1.51, $fn=60);
	translate([0,23,-0.1])
	cylinder (h=4, r=1.51, $fn=60);
	translate([-23,0,-0.1])
	cylinder (h=4, r=1.51, $fn=60);
	translate([0,-23,-0.1])
	cylinder (h=4, r=1.51, $fn=60);
	translate([0,0,-3])
    cylinder(h=20, r=3, $fn=60);  */

    rotate([0,0,45]) union() {
	translate([24,0,-0.1])
	cylinder (h=4, r=1.51, $fn=60);
	translate([0,24,-0.1])
	cylinder (h=4, r=1.51, $fn=60);
	translate([-24,0,-0.1])
	cylinder (h=4, r=1.51, $fn=60);
	translate([0,-24,-0.1])
	cylinder (h=4, r=1.51, $fn=60);
    }

	translate([8,0,-3])	
	cylinder(h=20, r=1.51, $fn=60);
	translate([0,8,-3])
	cylinder(h=20, r=1.51, $fn=60);
	translate([-8,0,-3])
	cylinder(h=20, r=1.51, $fn=60);
	translate([0,-8,-3])
	cylinder(h=20, r=1.51, $fn=60);
}

difference(){
cylinder(h=14, r=11, $fn=60);
	translate([0,0,-3])
    cylinder(h=20, r=3, $fn=60);
	translate([8,0,-3])	
	cylinder(h=20, r=1.51, $fn=60);
	translate([0,8,-3])
	cylinder(h=20, r=1.51, $fn=60);
	translate([-8,0,-3])
	cylinder(h=20, r=1.51, $fn=60);
	translate([0,-8,-3])
	cylinder(h=20, r=1.51, $fn=60);
}