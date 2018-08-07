%生成gif
fps = 8; %帧数
flage = true;

a=[0.7 0.1 0.2;0.1 0.7 0.2;0.08 0.04 0.88];
c0=[0.3 0.2 0.5];
%0=[0.3,0.4,0.3]
b=[];
b(1,:)=c0;
for i=1:20
    b(i+1,:)=c0*a^i;
end
x=8:20+8;

figure('Color',[1 1 1]);
hold on
for i = 1:length(x)-1
    axis([min(x), max(x), 0, max(max(b))])
    if flage
        frame=getframe(gcf);
        im=frame2im(frame); %制作gif文件，图像必须是index索引图像
        [I,map]=rgb2ind(im,32);
        imwrite(I,map,'pic.gif','gif', 'Loopcount',1,'DelayTime',1/fps);%第一次必须创建！
        flage = false;
    end
    plot(x(i:i+1),b(i:i+1,1),'r*-',x(i:i+1),b(i:i+1,2),'bO-',x(i:i+1),b(i:i+1,3),'ks-')
    xlabel('月份')
    ylabel('市场占有率')
    legend('甲产品','乙产品','丙产品')
    frame=getframe(gcf);
    im=frame2im(frame); %制作gif文件，图像必须是index索引图像
    [I,map]=rgb2ind(im,32);
    imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',1/fps);
end

