syms l1 l2 l3 t1 t2 t3 t4 Px Py;

%%%% 机械臂模型建立

l1 = 1;
l2 = 1;
l3 = 1;

L(1) = Link([0 , 0 ,0 ,0],'modified');
L(2) = Link([0 , 0 ,l1 ,0],'modified');
L(3) = Link([0 , 0 ,l2 ,0],'modified');
L(4) = Link([0 , 0 ,l3 ,0], 'modified');

L(1).m = 10;
L(2).m = 10;
L(3).m = 10;
L(4).m = 0;
L(1).I = [0,0,0 ; 0,5/6,0 ; 0,0,5/6];
L(2).I = [0,0,0 ; 0,5/6,0 ; 0,0,5/6];
L(3).I = [0,0,0 ; 0,5/6,0 ; 0,0,5/6];
L(4).I = [0,0,0 ; 0,0,0 ; 0,0,0];

rbt = SerialLink(L);
rbt.name = "3180105951";

%%%%% -机械臂模型建立 %%%

%%%%% 正运动学解算 %%%%
T04 = rbt.fkine([t1, t2, t3 , 0]);

T01 =  [cos(t1) , -sin(t1) , 0 ,0 ; sin(t1) , cos(t1) , 0, 0; 0,0,1,0 ; 0,0,0,1];
T12 =  [cos(t2) , -sin(t2) , 0 ,1 ; sin(t2) , cos(t2) , 0, 0; 0,0,1,0 ; 0,0,0,1];
T23 =  [cos(t3) , -sin(t3) , 0 ,1 ; sin(t3) , cos(t3) , 0, 0; 0,0,1,0 ; 0,0,0,1];
T34 =  [1 , 0 , 0 ,1 ; 0 , 1 , 0, 0; 0,0,1,0 ; 0,0,0,1];

%%%%% -正运动学解算 %%%%

%%%%% 轨迹规划 %%%%%
% 使用T型速度曲线规划

dt = 0.05;   %插值间隔   
Tt = 12;     %单段时间
t = 0:dt:(Tt * 3);  %三段

% 关节空间规划
p1 = [0,0,0];                                %起始点
p2 = [180 , -170 , -10];                     %中间点1
p3 = [180, -72 , -108];                      %中间点2
p4 = [168.027655 , -71.034425 , -96.99323];  %末状态点，末端在规定终点

%[θ，θ',θ'']
[q1,qd1,qdd1] = Tlike_trace([p1(1), p2(1) , p3(1) , p4(1)]);
[q2,qd2,qdd2] = Tlike_trace([p1(2), p2(2) , p3(2) , p4(2)]);
q3 = -q1 - q2;
qd3 = -qd1 - qd2;
qdd3 = -qdd1 - qdd2;

%%%%% -轨迹规划 %%%%

%%%%% 轨迹规划结果绘制 %%%%
% 此时轨迹q 是角度制表示，绘制结果用角度制表示
% plotTrace(t,q1,qd1,qdd1,[p1(1),p2(1),p3(1),p4(1)],Tt);
% plotTrace(t,q2,qd2,qdd2,[p1(2),p2(2),p3(2),p4(2)],Tt);
% plotTrace(t,q3,qd3,qdd3,[p1(3),p2(3),p3(3),p4(3)],Tt);
%%%%% -轨迹规划结果绘制 %%%%

%%%%% 格式化轨迹规划结果，附加时间序列，化为弧度制 %%%%
t = 0:dt:3*Tt;
q1    = [t',q1'];
q2    = [t',q2'];
q3    = [t',q3'];
qd1   = [t',qd1'];
qd2   = [t',qd2'];
qd3   = [t',qd3'];
qdd1  = [t',qdd1'];
qdd2  = [t',qdd2'];
qdd3  = [t',qdd3'];

q1(:,2) = q1(:,2) * 2 * pi / 360;
q2(:,2) = q2(:,2) * 2 * pi / 360;
q3(:,2) = q3(:,2) * 2 * pi / 360;
qd1(:,2) = qd1(:,2) * 2 * pi / 360;
qd2(:,2) = qd2(:,2) * 2 * pi / 360;
qd3(:,2) = qd3(:,2) * 2 * pi / 360;
qdd1(:,2) = qdd1(:,2) * 2 * pi / 360;
qdd2(:,2) = qdd2(:,2) * 2 * pi / 360;
qdd3(:,2) = qdd3(:,2) * 2 * pi / 360;

%%%%% -格式化轨迹规划结果，附加时间序列，化为弧度制 %%%%

%%%%% 画墙和目标点 %%%%

hold on;
rbt.plot([0,0,0,0]);
plot([0,0],[1.1,3],'r*-','LineWidth',3);
plot([-0.1],[1.2],'bo');

%%%%% -画墙和目标点 %%%%

%%%%% 记录末端笛卡尔轨迹 %%%%
for i = 1:721
    TX = rbt.fkine([q1(i,2), q2(i,2), q3(i,2) , 0]);
    t_endx(i) = TX.t(1);
    t_endy(i) = TX.t(2);
end
%%%%% -记录末端笛卡尔轨迹 %%%%

%%%%% 演示机械臂笛卡尔轨迹 %%%%
for i = 1:120
    hold on;
    rbt.plot([q1(6*i,2),q2(6*i,2),q3(6*i,2),0]);
    plot([t_endx(6*i)],[t_endy(6*i)] , 'b*');
end
%%%%% -演示机械臂笛卡尔轨迹 %%%%

