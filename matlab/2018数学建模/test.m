t0=100;%初温
x0=-10;%初始解
s0=x0^2+2*x0+1;%初始目标函数值
delta=1;%x步长

for t=t0:-10:0
    for k=1:50
       % 这里不能只增不减
        if rand() < 0.5
            x1=x0+delta; %新解
        else
            x1=x0-delta; %新解
        end
        
        s1=x1^2+2*x1+1;
        if s1<s0 %判断状态接受
            x0=x1; %以新解作为当前解
            s0 = s1;%这里漏了
        else
            p=exp(-(s1-s0)/t*k);%接受概率
            if rand(1)<p
                x0=x1;
                s0=s1;
                
            end
        end
    end
end

x0