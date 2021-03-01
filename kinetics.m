function [q1,qd1,qdd1] = kinetics(rbt,q,qd,qdd,tau,m)
    
    %正动力学模型，给定θ,θ'，θ'' 和控制量τ，给出下一时刻θ,θ'
    
    dt = 0.005;
    
    TX = rbt.fkine([q(1), q(2), q(3) , 0]).t(1:3,1);
    L1 = norm(TX);
    I1 = m * L1^2;
    I2 = (1/3) * (2*m) * ((2*L1/3)^2);
    I3 = (1/3) * (m) * ((1*L1/3)^2);

    qdd1 = tau ./ [I1;I2;I3];
    q1 = qd * dt + 0.5 * qdd1 * dt^2;
    qd1 = qd + qdd1*dt;
    
end