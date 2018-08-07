l = 0:0.04:5;
x = 0:0.1:5;y = x;
[X,Y] = meshgrid(x,y);


gif(-1)
for i = 1:length(l)
    Z = f(X,Y,l(i));
    mesh(X,Y,Z)
    hold on;mesh([0,0,;0,0],[0,0;0,0],[700 700;700 700]);hold off; %�̶���Χ
    legend(['lamad = ' ,num2str(l(i),'%.1f')])
    gif(0.1)
end



%% ����
function Z = f(X,Y,l)
     Z = X;
     for i = 1:length(X)
        for j = 1:length(X)
            Z(i,j) = l*min(X(i,j),Y(i,j))+l*l*X(i,j)*Y(i,j);
        end
    end
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