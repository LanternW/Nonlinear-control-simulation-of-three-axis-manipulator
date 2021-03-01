
points = 200; %实际产生的点太多了，运行过慢，等间隔选取部分点即可
total = size(ScopeQ1{1}.Values.Data,1); %总位姿数
gt = floor(total / points);
for i = 1:points
    TX = rbt.fkine([ScopeQ1{1}.Values.Data(gt*i), ScopeQ2{1}.Values.Data(gt*i), ScopeQ3{1}.Values.Data(gt*i) , 0]);
    r_endx(i) = TX.t(1);
    r_endy(i) = TX.t(2);
end
    TX = rbt.fkine([ScopeQ1{1}.Values.Data(total), ScopeQ2{1}.Values.Data(total), ScopeQ3{1}.Values.Data(total) , 0]);
    r_endx(i+1) = TX.t(1);
    r_endy(i+1) = TX.t(2);
 for i = 1:points
    hold on;
    rbt.plot([ScopeQ1{1}.Values.Data(gt*i) ,ScopeQ2{1}.Values.Data(gt*i),ScopeQ3{1}.Values.Data(gt*i),0]);
    plot([r_endx(i)],[r_endy(i)], 'y*');

end
rbt.plot([ScopeQ1{1}.Values.Data(total) ,ScopeQ2{1}.Values.Data(total),ScopeQ3{1}.Values.Data(total),0]);
plot([r_endx(i+1)],[r_endy(i+1)] , 'y*');


