%% �������
sigma = 8.5;
mu = [115,115,115,117,120,124,128,134,137,148];
x = 80:0.2:180;

%% ����mu
mu_ = [];
for i = 1:length(mu)-1
    mu_ = [mu_,linspace(mu(i),mu(i+1),2)];
end
year = linspace(16,65,length(mu_));

%% ���ɶ�ͼ
gif(-1) %��ʼ��
for i = 1:length(mu_)
    y = f(x,sigma,mu_(i));
    plot(x,y,'LineWidth',2)
    box off;ylabel('����');xlabel('Ѫѹ/mmHg')
    legend(['Sigma = ' ,num2str(sigma,'%.1f'),'  Mu = ',num2str(mu_(i),'%.1f'),'  ����:',num2str(year(i),'%.1f'),'��'])
    gif(0.1);  %ÿ��ͼƬ���ʱ��
end

%% ��̬����
function y = f(x,f,m)
    y = 1/(sqrt(2*pi)*f).*exp(-(x-m).^2./(2*f^2));
end

%% gif���ɺ���
function  gif(d) % dΪÿ�����ļ��ʱ��
    if d < 0
        figure('Color',[1 1 1]);
        set(gcf,'outerposition',get(0,'screensize'));
        frame=getframe(gcf);
        im=frame2im(frame); %����gif�ļ���ͼ�������index����ͼ��
        [I,map]=rgb2ind(im,32);
        imwrite(I,map,'pic.gif','gif', 'Loopcount',inf,'DelayTime',0);%��һ�α��봴����
    else
        frame=getframe(gcf);
        im=frame2im(frame); %����gif�ļ���ͼ�������index����ͼ��
        [I,map]=rgb2ind(im,32);
        imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',d);
    end
end