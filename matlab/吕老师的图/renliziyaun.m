clc
clear all
a=[135 240 115 60 0]
b=[0.6 0.4 0 0 0 ;
    0 0.6 0.25 0 0.15;
    0 0 0.55 0.21 0.24;
    0 0 0 0.8 0.2;
    0 0 0 0 1];
c=a*b;
c(1)=c(1)+c(5);
c(5)=0;
d(1,:)=c;


for i=1:30
    d(i+1,:)=d(i,:)*b;
    d(i+1,1)=d(i+1,1)+d(i+1,5);
    d(i+1,5)=0;    
end
dd=round(d);
x=1:31;

gif(-1)
hold on
axis([0,35,60,200]);
box off
for i = 1:length(x)
    plot(x(i),dd(i,1),'b*',x(i),dd(i,2),'rs',x(i),dd(i,3),'m*',x(i),dd(i,4),'g+','LineWidth',3)
    legend('����','��ʦ','������','����')
    xlabel('���')
    ylabel('����')
    gif(0.2)
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