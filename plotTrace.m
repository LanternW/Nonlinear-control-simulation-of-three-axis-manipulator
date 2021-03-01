function plotTrace(t,q_trace,qd_trace,qdd_trace, q_points , Tt)

    %���ƹ켣�滮���
    
    subplot(1,3,1);
    plot(t,q_trace(),'LineWidth',2);
    hold on;
    plot([0,Tt,2*Tt,3*Tt],[q_points(1) , q_points(2) ,q_points(3),q_points(4)],'r*','LineWidth',1);
    title("�ؽڽǶȹ켣�滮");
    xlabel("time,s");
    ylabel("��,��");
    
    subplot(1,3,2);
    plot(t,qd_trace(),'LineWidth',2);
    hold on;
    title("�ؽڽ��ٶȹ켣�滮");
    xlabel("time,s");
    ylabel("��',��/s");
    
    subplot(1,3,3);
    plot(t,qdd_trace(),'LineWidth',2);
    hold on;
    title("�ؽڽǼ��ٶȹ켣�滮");
    xlabel("time,s");
    ylabel("��'',��/s^2");
end