function [q,qd,qdd] = Tlike_trace(positions)
    
    dt = 0.05;
    Tt = 12;
    t = 0:dt:(Tt * 3); %三段

    qddmax = 5;
    
    
    a1 = sign( positions(2) - 0) * abs(qddmax); %起步加速度
    a4 = sign( positions(3) - positions(4) ) * abs(qddmax);  %刹车步加速度
    
    ton = Tt - sqrt(Tt^2 - 2*(positions(2) - positions(1))/(a1));  %起步时间
    tof = Tt - sqrt(Tt^2 + 2*(positions(4) - positions(3))/(a4)); %刹车时间
    
    v1  = ( positions(2) - positions(1) ) / (Tt - 0.5 * ton); %直线段速度
    v2  = ( positions(3) - positions(2) ) / Tt; %还是直线段速度
    v3  = ( positions(4) - positions(3) ) / (Tt - 0.5 * tof);
    
   
    a2 = sign(v2 - v1) * abs(qddmax);
    a3 = sign(v3 - v2) * abs(qddmax);
    
    tgd1 = (v2 - v1) / a2;
    tgd2 = (v3 - v2) / a3;
    

    i = 1;
    qstar1 = (0.5 * a1 * ton^2) + v1 * (Tt - 0.5*tgd1 - ton);
    qstar2 = qstar1 + v1 * tgd1 + (0.5*a2*tgd1^2);
    qstar3 = qstar2 + v2 * ( (2*Tt - 0.5*tgd2) - (Tt + 0.5 * tgd1) );
    qstar4 = qstar3 + v2 * tgd2 + (0.5*a3*tgd2^2);
    qstar5 = qstar4 + v3 * ( (3*Tt - tof) - (2*Tt + 0.5 * tgd2) );
    for ti = 0:dt:3*Tt
        if ti <= ton
            q(i) = 0.5 * a1 * ti^2 ;
            qd(i) = a1 * ti;
            qdd(i) = a1;
        elseif ti <= Tt - 0.5 * tgd1
            
            q(i) = (0.5 * a1 * ton^2) + v1 * (ti - ton); 
            qd(i) = v1;
            qdd(i) = 0;

        elseif ti <= Tt + 0.5 * tgd1
            delta_t = ti - (Tt - 0.5 * tgd1);
            q(i) = qstar1 + v1 * delta_t + (0.5*a2*delta_t^2) ;
            qd(i) = v1 + a2 * delta_t;
            qdd(i) = a2;
            
        elseif ti <= (2*Tt - 0.5*tgd2)
            delta_t = ti - (Tt + 0.5 * tgd1);
            q(i) = qstar2 + v2 * delta_t;
            qd(i) = v2;
            qdd(i) = 0;
        elseif ti <= (2*Tt + 0.5*tgd2)
            delta_t = ti - (2*Tt - 0.5*tgd2);
            q(i) = qstar3 + v2 * delta_t + (0.5*a3*delta_t^2);
            qd(i) = v2 + a3 * delta_t;
            qdd(i) = a3;
            
        elseif ti <= (3*Tt - tof)
            delta_t = ti - (2*Tt + 0.5*tgd2);
            q(i) = qstar4 + v3 * delta_t;
            qd(i) = v3;
            qdd(i) = 0;
        else
            delta_t = ti - (3*Tt - tof);
            q(i) = qstar5 + v3 * delta_t + (0.5*a4*delta_t^2);
            qd(i) = v3 + a4 * delta_t;
            qdd(i) = a4;
        end
        i = i+1;
    end
    
 
end
