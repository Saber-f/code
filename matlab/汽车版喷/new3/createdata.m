%% 生成数据
clear
N = 16;    %待喷数目

car = [];  %色号，

for i = 1:N
    %产生到达时间
    tim = randi(480);

    fg = false;   
    % 产生色号
    t = rand();
    if t < 0.5
        clo = 1;
        fg = true;
    elseif t < 0.62
        clo = 2;
    elseif t < 0.74
        clo = 3;   
    elseif t < 0.94
        clo = 4;
    else
        clo = 5;
    end
        
    %耗时范围
    if fg
        %us = [180,240];
        us = 180 + randi(60);
        t = 240;
    else
        %us = [60,90];
        us = 60 + randi(30);
        t = 90;
    end
    car = [car;[tim,clo,us,t]];
end
[~,s] = sort(car(:,1));
car = car(s,:);
save('car','car')