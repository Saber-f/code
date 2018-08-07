
%生成gif
clc
clear
fps = 40; %帧数
flage = true;x = -8:0.01:8;
N = 100;
m = [linspace(0,4,N), linspace(4,-4,2*N), linspace(-4,0,N)];
fi = [linspace(1,2,N), linspace(2,0.5,2*N), linspace(0.5,1,N)];

set(axes('Parent',gcf),'YAxisLocation','origin');
axis([-8,8,0,0.8]);
hold on
for i = 1:length(fi)
    y = f(x,1,0);
    plot(x,y,'LineWidth',2)
    y = f(x,fi(i),0);
    plot(x,y,'LineWidth',2)
    y = f(x,1,m(i));
    plot(x,y,'LineWidth',2)
    legend('Sigma = 1.00  Mu = 0.0',['Siama = ',num2str(fi(i),'%.2f'),'  Mu = 0.0'],['Siama = 1.00  Mu = ',num2str(m(i),'%.1f')])
    

    frame=getframe(gcf);
    im=frame2im(frame); %制作gif文件，图像必须是index索引图像
    [I,map]=rgb2ind(im,32);
    if flage
        imwrite(I,map,'pic.gif','gif', 'Loopcount',inf,'DelayTime',1/fps);%第一次必须创建！
        flage = false;
    else
        imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',1/fps);
    end
    cla(gcf)
end


function y = f(x,f,m)
    y = 1/(sqrt(2*pi)*f).*exp(-(x-m).^2./(2*f^2));
end