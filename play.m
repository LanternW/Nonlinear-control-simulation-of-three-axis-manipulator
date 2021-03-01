for i = 1:200

    rbt.plot([ScopeQ1{1}.Values.Data(30000*i) ,ScopeQ2{1}.Values.Data(30000*i),ScopeQ3{1}.Values.Data(30000*i),0]);
    disp(i);
    
end
