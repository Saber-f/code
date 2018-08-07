
%生成gif
fps = 40; %帧数
flage = true;x = -8:0.01:8;
m = [1:0.02:2, 2:-0.02:0.5, 0.5:0.02:1];
figure
for i = 1:length(m)
    y = f(x,1,0);
    axes1 = axes('Parent',gcf);
    axis([-8,8,0,0.8]);
    hold(axes1,'on');
    set(axes1,'YAxisLocation','origin');
    plot(x,y,'LineWidth',2)
    y = f(x,m(i),0);
    plot(x,y,'LineWidth',2)
    legend('Sigma = 1.00  Mu = 0',['Siama = ',num2str(m(i),'%.2f'),'  Mu = 0'])
    
    
    frame=getframe(gcf);
    im=frame2im(frame); %制作gif文件，图像必须是index索引图像
    [I,map]=rgb2ind(im,32);
    if flage
        imwrite(I,map,'pic.gif','gif', 'Loopcount',inf,'DelayTime',1/fps);%第一次必须创建！
        flage = false;
    else
        imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',1/fps);
    end
    cla(axes1)
end


