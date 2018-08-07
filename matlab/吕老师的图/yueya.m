%% 输入参数
sigma = 8.5;
mu = [115,115,115,117,120,124,128,134,137,148];
x = 80:0.2:180;

%% 处理mu
mu_ = [];
for i = 1:length(mu)-1
    mu_ = [mu_,linspace(mu(i),mu(i+1),2)];
end
year = linspace(16,65,length(mu_));

%% 生成动图
gif(-1) %初始化
for i = 1:length(mu_)
    y = f(x,sigma,mu_(i));
    plot(x,y,'LineWidth',2)
    box off;ylabel('概率');xlabel('血压/mmHg')
    legend(['Sigma = ' ,num2str(sigma,'%.1f'),'  Mu = ',num2str(mu_(i),'%.1f'),'  年龄:',num2str(year(i),'%.1f'),'岁'])
    gif(0.1);  %每张图片间隔时间
end

%% 正态函数
function y = f(x,f,m)
    y = 1/(sqrt(2*pi)*f).*exp(-(x-m).^2./(2*f^2));
end

%% gif生成函数
function  gif(d) % d为每幅画的间隔时间
    if d < 0
        figure('Color',[1 1 1]);
        set(gcf,'outerposition',get(0,'screensize'));
        frame=getframe(gcf);
        im=frame2im(frame); %制作gif文件，图像必须是index索引图像
        [I,map]=rgb2ind(im,32);
        imwrite(I,map,'pic.gif','gif', 'Loopcount',inf,'DelayTime',0);%第一次必须创建！
    else
        frame=getframe(gcf);
        im=frame2im(frame); %制作gif文件，图像必须是index索引图像
        [I,map]=rgb2ind(im,32);
        imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',d);
    end
end