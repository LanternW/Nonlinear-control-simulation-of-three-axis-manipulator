
points = 720; %与规划点数目相同
total = length(ScopeQ1{1}.Values.Data); %总位姿数
gt = floor(total / points);
for i = 1:points
    TX = rbt.fkine([ScopeQ1{1}.Values.Data(gt*i), ScopeQ2{1}.Values.Data(gt*i), ScopeQ3{1}.Values.Data(gt*i) , 0]);
    r_endx(i) = TX.t(1);
    r_endy(i) = TX.t(2);
end
    TX = rbt.fkine([ScopeQ1{1}.Values.Data(total), ScopeQ2{1}.Values.Data(total), ScopeQ3{1}.Values.Data(total) , 0]);
    r_endx(i+1) = TX.t(1);
    r_endy(i+1) = TX.t(2);
E = 0;
for i = 1:points
    E = E + (r_endx(i) - t_endx(i))^2 + (r_endy(i) - t_endy(i))^2;
end
    E = E + (r_endx(i+1) - t_endx(i+1))^2 + (r_endy(i+1) - t_endy(i+1))^2;
    disp(E);
