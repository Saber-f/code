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