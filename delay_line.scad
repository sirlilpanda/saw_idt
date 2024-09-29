// inputs, delay line config
// will have to scale approperly

lambda = 7.5;

// inout distance
distance = 20;

// number of finger
n_fingers = 4;

// should be 50-70
finger_length = 2; 

// for tweaking the design
gap = 50;
// for tweaking the design

thickness = 0;

// creates 1 side of the idt
module delay_line(lambda = 1, n_fingers = 1, finger_length = 50, gap = 0, thickness = 0) {
    // code
    l45 =lambda*5/4;
    l2 = lambda/2;
    l4 = lambda/4;
    l8 = lambda/8;
    b = l4 + thickness;
    f = l4 + finger_length*lambda + gap;

    points_cap = [
        [0, 0],
        [0, l2+l8],
        [-b-f, l2+l8],
        [-b-f, l4+l8],
        [-b, l4+l8],
        [-b, 0]
    ];

    points = [
        [0, 0],
        [b, 0],
        [b, l2],
        [b+f, l2],
        [b+f, l2+l4],
        [b, l2+l4],
        [b, l4*5],
        [0, l4*5]
    ];

    translate([0, l2+l8, 0]){
        for(i = [0:n_fingers]){
            translate([0, i*l45, 0]) {
            polygon(points);
            }
        }

        color("red")
        rotate([0, 0, 180])
        translate([0, 0, 0]) 
        polygon(points_cap);


        for(i = [0:n_fingers]){
            translate([b+f+gap+l2, i*l45+l2+l4/2, 0]) 
            rotate([0, 0, 180])
            polygon(points);
        }

        color("red")
        translate([b+f+gap+l2, n_fingers*l45+l2+l4/2, 0]) 
        polygon(points_cap);

        }
}

// creates the input and output ids
module delay_line_idt(lambda, n_fingers, distance = 100, finger_length = 50, gap = 0, thickness = 0) {
    length_of_input = n_fingers*lambda*15/8;
    
    delay_line(lambda, n_fingers, finger_length, gap, thickness);


    translate([0, length_of_input+distance*lambda, 0])
    delay_line(lambda, n_fingers, finger_length, gap, thickness);
}


delay_line_idt(lambda, n_fingers, distance, finger_length, gap, thickness);