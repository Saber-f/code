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