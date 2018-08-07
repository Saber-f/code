
%生成gif
fps = 40; %帧数
flage = true;x = -8:0.01:8;
fi = [0:0.1:4, 4:-0.1:-4, -4:0.1:4];
figure
for i = 1:length(fi)
    y = f(x,1,0);
    axes1 = axes('Parent',gcf);
    axis([-8,8,0,0.8]);
    hold(axes1,'on');
    set(axes1,'YAxisLocation','origin');
    plot(x,y,'LineWidth',2)
    y = f(x,1,fi(i));
    plot(x,y,'LineWidth',2)
    legend('Sigma = 1  Mu = 0.0',['Siama = 1  Mu = ',num2str(m(i),'%.1f')])
    

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


function y = f(x,f,m)
    y = 1/(sqrt(2*pi)*f).*exp(-(x-m).^2./(2*f^2));
end