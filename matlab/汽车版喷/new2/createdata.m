%% ��������
clear
N = 16;    %������Ŀ

car = [];  %ɫ�ţ�

for i = 1:N
    %��������ʱ��
    tim = randi(480);

    fg = false;   
    % ����ɫ��
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
        
    %��ʱ��Χ
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