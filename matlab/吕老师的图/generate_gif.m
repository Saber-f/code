function  generate_gif(d) % dΪÿ�����ļ��ʱ��
    global flage;
    if isempty(flage)
        flage = true;
    end
    frame=getframe(gcf);
    im=frame2im(frame); %����gif�ļ���ͼ�������index����ͼ��
    [I,map]=rgb2ind(im,32);
    if flage
        imwrite(I,map,'pic.gif','gif', 'Loopcount',inf,'DelayTime',d);%��һ�α��봴����
        flage = false;
    else
        imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',d);
    end
end