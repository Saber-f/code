% 两人赌博
clear
money = [5 10]; % 初始资金
win = [0.5 0.5]; % 赢的概率
num = 50; %计算场数

remain = zeros(sum(money),num);remain(money(1),1) = 1;
x = 1:num;
y1 = zeros(1,num);
y2 = zeros(1,num);

for i = 2:num
    for j = 1:size(remain,1)-1
        if j == 1
            remain(j,i) = remain(j+1,i-1)*win(2);
        elseif j == size(remain,1)
            remain(j,i) = remain(j-1,i-1)*win(1);
        else
            remain(j,i) = remain(j-1,i-1)*win(1) + remain(j+1,i-1)*win(2);
        end
    end 
    y1(i) = y1(i-1) + remain(1,i-1)*win(2); 
    y2(i) = y2(i-1) + remain(sum(money)-1,i)*win(1); 
end
plot(x,y1,x,y2,x,1-y1-y2)

%生成gif
fps = 6; %帧数
flage = true;
figure('Color',[1 1 1]);
hold on
for i = 1:length(x)
    axis([0, num, 0, 1])
    if flage
        frame=getframe(gcf);
        im=frame2im(frame); %制作gif文件，图像必须是index索引图像
        [I,map]=rgb2ind(im,32);
        imwrite(I,map,'pic.gif','gif', 'Loopcount',1,'DelayTime',1/fps);%第一次必须创建！
        flage = false;
    end
    plot([x(i),x(i)-1],[y1(i),y1(i)],'r','LineWidth',2)
    plot([x(i),x(i)-1],[y2(i),y2(i)],'b','LineWidth',2)
    plot([x(i),x(i)-1],[1-y1(i)-y2(i),1-y1(i)-y2(i)],'k','LineWidth',2)
    xlabel('赌博场数')
    ylabel('概率')
    legend('甲输光','乙输光','未分出胜负')
    frame=getframe(gcf);
    im=frame2im(frame); %制作gif文件，图像必须是index索引图像
    [I,map]=rgb2ind(im,32);
    imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',1/fps);
end

