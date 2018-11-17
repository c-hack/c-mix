// ============ Grundplatte =============
translate([-40,-40,29.9]) difference() {
cube([80,80,6]);
    // ------ Mittelbohrung ---------
    translate([40,40,-0.1]) cylinder(h=9, r=6, $fn=40);

   // ------ Schlitz für Wellenmitnehmer -----------
   translate([29,38.5,-0.1]) cube([22,3,10]);

    // ----- Motorbefestigungslöcher --------------
	translate ([47,55.5,-0.1])
	cylinder(h=10, r=1.65, $fn=60);
	translate ([47,24.5,-0.1])
	cylinder(h=10, r=1.65, $fn=60);
	
    // ----- Senkungen der Motorbefestigungslöcher --------- 
	translate ([47,55.5,-0.1])
	cylinder(h=2, r2=1.65, r1=3, $fn=60);
	translate ([47,24.5,-0.1])
	cylinder(h=2, r2=1.65, r1=3, $fn=60);

    // ------ Befestigungslöcher ------------- 
	translate ([6,6,-0.1])
	cylinder(h=10, r=1.7, $fn=60);
	translate ([6,74,-0.1])
	cylinder(h=10, r=1.7, $fn=60);
	translate ([74,74,-0.1])
	cylinder(h=10, r=1.7, $fn=60);
	translate ([74,6,-0.1])
	cylinder(h=10, r=1.7, $fn=60);
	
	// -------- 5mm LED Löcher --------------
   translate ([22,22,-0.1]) cylinder(h=10, r=2.55, $fn=50);
   translate ([80-22,22,-0.1]) cylinder(h=10, r=2.55, $fn=50);
   translate ([22,80-22,-0.1]) cylinder(h=10, r=2.55, $fn=50);
   translate ([80-22,80-22,-0.1]) cylinder(h=10, r=2.55, $fn=50);

   translate ([22,22,5]) cylinder(h=1.1, r=3.3, $fn=50);
   translate ([80-22,22,5]) cylinder(h=1.1, r=3.3, $fn=50);
   translate ([22,80-22,5]) cylinder(h=1.1, r=3.3, $fn=50);
   translate ([80-22,80-22,5]) cylinder(h=1.1, r=3.3, $fn=50);

   // ----- Elektronikaussparung + Sensorlöcher ----------
   translate([6,30,4]) cube([6,20,10]);
   translate([7,40-7.5,-0-1]) cylinder(h=10, r=0.8, $fn=50);
   translate([7,40+7.5,-0-1]) cylinder(h=10, r=0.8, $fn=50);
}

// ========= Zylinder ===============
difference(){
cylinder(h=30, r=40, $fn=200);

    // ----- Außenwand 5mm Dicke -----
    translate ([0,0,-0.1])
    cylinder (h=40, r=35, $fn=200);

    // ----- Schlauchausschnitte ------
    rotate ([0,0,-10])
    translate ([0,29,-0.1])
    cube ([50,4,17]);
    rotate ([0,0,10])
    translate ([0,-35,-0.1])
    cube ([50,4,17]);
	translate([10,30.75,17])
	rotate([0,90,-10])
	cylinder(h=40, r=3, $fn=60);
	translate([10,-30.75,17])
	rotate([0,90,10])
	cylinder(h=40, r=3, $fn=60);
	
    // ---------- Führungsnute -------------
    translate([0,0,12]) cylinder(h=10, r=36, $fn=200);	
}