% 两人赌博
clear
money0 = [5 5]; % 初始资金
win = [0.5 0.5]; % 赢的概率
num = 1000000; %计算场数
num_win = 0;
xx = {money0(1),money0(1),money0(1),money0(1)};
for i = 1:num
    money = money0;
    while true
        t = rand(1,1);
        if t < 0.5
            money(1) = money(1) - 1;
        else
            money(1) = money(1) + 1;
        end
        if i <= 4
            xx{i} = [xx{i},money(1)];
        end
        if money(1) == 0
            break;
        end
        if money(1) == sum(money0)
            num_win = num_win + 1;
            break;
        end
    end
end

if false
fps = 6; %帧数
flage = true;
figure('Color',[1 1 1]);
color = {'r','b','g','c'};
hold on
maa = max([length(xx{1}),length(xx{2}),length(xx{3}),length(xx{4})]);
for j = 1:length(xx)
    y = xx{j};
    x = 1:length(y);
    axis([0, maa+0.1, 0, sum(money0)])
    for i = 1:length(x)      
        if flage
            frame=getframe(gcf);
            im=frame2im(frame); %制作gif文件，图像必须是index索引图像
            [I,map]=rgb2ind(im,32);
            imwrite(I,map,'pic.gif','gif', 'Loopcount',1,'DelayTime',1/fps);%第一次必须创建！
            flage = false;
        end
        plot([x(i),x(i)-1],[y(i),y(i)]+0.03*(j-1),color{j}','LineWidth',2)
        xlabel('赌博场数')
        ylabel('剩余金钱')
        frame=getframe(gcf);
        im=frame2im(frame); %制作gif文件，图像必须是index索引图像
        [I,map]=rgb2ind(im,32);
        imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',1/fps);
    end
end
end