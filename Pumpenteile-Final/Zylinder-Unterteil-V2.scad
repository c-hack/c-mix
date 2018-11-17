//Mit zwei unterschiedlichen Lochmaßen zur besseren Anpassung an den Außendurchmesser
// 2.5mm Löcher, in die ein M3 Gewinde gebohrt werden muss

difference() {
  translate([3,0,0]) rotate([0,0,45]) cube([4,7,14]);
    rotate([0,0,-45]) translate([-1.25,-10,-0.1]) cube([2.5,20,4]);
}  

difference(){
cylinder(h=2.5, r=30, $fn=60); 

    rotate([0,0,-45]) translate([-1.25,-10,-0.1]) cube([2.5,20,4]);

/*	translate([23,0,-0.1])
	cylinder (h=4, r=1.25, $fn=60);
	translate([0,23,-0.1])
	cylinder (h=4, r=1.25, $fn=60);
	translate([-23,0,-0.1])
	cylinder (h=4, r=1.25, $fn=60); 
	translate([0,-23,-0.1])
	cylinder (h=4, r=1.25, $fn=60); */

	translate([0,0,-3])
    cylinder(h=20, r=3, $fn=60);    

    rotate([0,0,45]) union() {
	translate([24,0,-0.1])
	cylinder (h=4, r=1.25, $fn=60);
	translate([0,24,-0.1])
	cylinder (h=4, r=1.25, $fn=60);
	translate([-24,0,-0.1])
	cylinder (h=4, r=1.25, $fn=60);
	translate([0,-24,-0.1])
	cylinder (h=4, r=1.25, $fn=60);
    }

	translate([8,0,-3])	
	cylinder(h=20, r=1.25, $fn=60);
	translate([0,8,-3])
	cylinder(h=20, r=1.25, $fn=60);
	translate([-8,0,-3])
	cylinder(h=20, r=1.25, $fn=60);
	translate([0,-8,-3])
	cylinder(h=20, r=1.25, $fn=60);

    // ---- Magnet -----
    translate([10,25,-0.1]) cylinder(h=1.1, r=3, $fn=50);
}

difference(){
cylinder(h=14, r=11, $fn=60);

    rotate([0,0,-45]) translate([-1.25,-10,-0.1]) cube([2.5,20,4]);

	translate([0,0,-3])
    cylinder(h=20, r=3, $fn=60);
	translate([8,0,-3])	
	cylinder(h=20, r=1.25, $fn=60);
	translate([0,8,-3])
	cylinder(h=20, r=1.25, $fn=60);
	translate([-8,0,-3])
	cylinder(h=20, r=1.25, $fn=60);
	translate([0,-8,-3])
	cylinder(h=20, r=1.25, $fn=60);
}