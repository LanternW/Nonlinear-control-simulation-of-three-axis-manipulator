function tau = invKinetics3(theta1,theta2,theta3,dtheta1,dtheta2,dtheta3,ddtheta1,ddtheta2,ddtheta3)

    m1 = 10;
    m2 = 10;
    m3 = 10;
    L1 = 1;
    L2 = 1;
    L3 = 1;
    g = 10;
    
    A = [(L1^2*m1)/3 + L1^2*m2 + (L2^2*m2)/3 + (L3^2*m3)/12 + (m3*((L1 + L3/2 + L1*cos(theta2))*(2*L1 + L3 + 2*L1*cos(theta2)) + (L3 - 2*L1*sin(theta2))*(L3/2 - L1*sin(theta2))))/2 + L1*L2*m2 (L2^2*m2)/3 + (L3^2*m3)/12 + (m3*((L1 + L3/2)*(2*L1 + L3 + 2*L1*cos(theta2)) + (L3*(L3 - 2*L1*sin(theta2)))/2))/2 + (L1*L2*m2)/2 (L3^2*m3)/12 + (m3*((L3*(2*L1 + L3 + 2*L1*cos(theta2)))/2 + (L3*(L3 - 2*L1*sin(theta2)))/2))/2;
   (m3*(L3*(L3/2 - L1*sin(theta2)) + (2*L1 + L3)*(L1 + L3/2 + L1*cos(theta2))))/2 + (L2^2*m2)/3 + (L3^2*m3)/12 + (L1*L2*m2)/2 (m3*((2*L1 + L3)*(L1 + L3/2) + L3^2/2))/2 + (L2^2*m2)/3 + (L3^2*m3)/12 (m3*((L3*(2*L1 + L3))/2 + L3^2/2))/2 + (L3^2*m3)/12;
   (L3*m3*(6*L1 + 7*L3 + 6*L1*cos(theta2) - 6*L1*sin(theta2)))/12 (L3*m3*(6*L1 + 7*L3))/12 (7*L3^2*m3)/12
    ];

b=[(m3*(2*L1*dtheta2*sin(theta2)*((L3*(dtheta1 + dtheta2 + dtheta3))/2 + L1*(dtheta1 + dtheta2) + L1*dtheta1*cos(theta2)) + 2*L1*dtheta2*cos(theta2)*((L3*(dtheta1 + dtheta2 + dtheta3))/2 - L1*dtheta1*sin(theta2)) + L1*dtheta1*dtheta2*sin(theta2)*(2*L1 + L3 + 2*L1*cos(theta2)) + L1*dtheta1*dtheta2*cos(theta2)*(L3 - 2*L1*sin(theta2))))/2 - g*m3*(L2*cos(theta1 + theta2) + L1*cos(theta1) + (L3*cos(theta1 + theta2 + theta3))/2) - g*m2*((L2*cos(theta1 + theta2))/2 + L1*cos(theta1)) - (L1*g*m1*cos(theta1))/2
     (m3*(L1*L3*dtheta1*dtheta2*cos(theta2) + L1*dtheta1*dtheta2*sin(theta2)*(2*L1 + L3)))/2 - (m3*(2*L1*dtheta1*sin(theta2)*((L3*(dtheta1 + dtheta2 + dtheta3))/2 + L1*(dtheta1 + dtheta2) + L1*dtheta1*cos(theta2)) + 2*L1*dtheta1*cos(theta2)*((L3*(dtheta1 + dtheta2 + dtheta3))/2 - L1*dtheta1*sin(theta2))))/2 - g*m3*(L2*cos(theta1 + theta2) + (L3*cos(theta1 + theta2 + theta3))/2) - (L2*g*m2*cos(theta1 + theta2))/2
    (L3*m3*(6*L1*dtheta1*dtheta2*cos(theta2) - 6*g*cos(theta1 + theta2 + theta3) + 6*L1*dtheta1*dtheta2*sin(theta2)))/12];

    tau = A * [ddtheta1;ddtheta2;ddtheta3] - b;

end