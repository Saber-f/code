clc;clear;close all;
S = zeros(4,100);
figure('Color',[0.9 0.9 0.9]);
set(gcf,'outerposition',get(0,'screensize'));
t = zeros(4,1);
Ii = imshow(1-S,[]);
for k = 1:10000
    for m = 1:4
        if(sum(S(m,end-1:end)) == 2)
            t(m) = 0;
        elseif(sum(S(m,end)) == 1)
            t(m) = 1;
        else
            t(m) = floor(rand+0.1);
        end
    end
    S = [S(:,2:end),t];
    set(Ii,'CData',1-S); % 跟新显示数据
    pause(0.02);
end