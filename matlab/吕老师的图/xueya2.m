%% �������
sigma = 8.5;
mu = [115,115,115,117,120,124,128,134,137,148];
x = 80:0.2:180;
year = 16:5:61;

%% ���ɶ�ͼ
gif(-1) %��ʼ��
for i = 1:length(mu)
    y = f(x,sigma,mu(i));
    plot(x,y,'LineWidth',2)
    box off;ylabel('����');xlabel('Ѫѹ/mmHg')
    legend(['Sigma = ' ,num2str(sigma,'%.1f'),'  Mu = ',num2str(mu(i),'%.1f'),'  ����:',num2str(year(i),'%d'),'-',num2str(year(i)+4,'%d'),'��'])
    gif(0.8);  %ÿ��ͼƬ���ʱ��
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