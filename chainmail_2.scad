//Sections in wire extrusion
wireDetail=24;
wireDetail=10;
circleDetail=12;

//Thickness of wire
wireGauge = 3.5;

//diameter of the ring
ringDiameter=22;

module ring()
rotate_extrude(convexity = 10, $fn=wireDetail)
translate([ringDiameter/2, 0, 0])
circle(r = wireGauge/2, $fn=circleDetail);

//number of ring is x direction
xrings = 3;
yrings = 3;

//generate mail
module mail()
translate([	ringDiameter/2,
			cos(45) * ringDiameter/2,
			cos(45) * ringDiameter/2])
for (xt = [0:xrings]){
for (yt = [0:yrings]){
	translate([xt*ringDiameter/1.7,yt*ringDiameter/1.7])
	if(xt%2){
		rotate([45,0,0])
		ring();
	}
	else{
		translate([0,ringDiameter/3,0])
		rotate([-45,0,0])
		ring();
	}
}
}

//cut base for stable platform
module base()
translate([-5,-5,-10])
cube([	ringDiameter * xrings,
		ringDiameter * yrings,
		10]);

mail();
/*
difference() {
	mail();
	base();
}
*/