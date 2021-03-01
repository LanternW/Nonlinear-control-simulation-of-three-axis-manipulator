function plotTrace(t,q_trace,qd_trace,qdd_trace, q_points , Tt)

    %绘制轨迹规划结果
    
    subplot(1,3,1);
    plot(t,q_trace(),'LineWidth',2);
    hold on;
    plot([0,Tt,2*Tt,3*Tt],[q_points(1) , q_points(2) ,q_points(3),q_points(4)],'r*','LineWidth',1);
    title("关节角度轨迹规划");
    xlabel("time,s");
    ylabel("θ,度");
    
    subplot(1,3,2);
    plot(t,qd_trace(),'LineWidth',2);
    hold on;
    title("关节角速度轨迹规划");
    xlabel("time,s");
    ylabel("θ',度/s");
    
    subplot(1,3,3);
    plot(t,qdd_trace(),'LineWidth',2);
    hold on;
    title("关节角加速度轨迹规划");
    xlabel("time,s");
    ylabel("θ'',度/s^2");
end