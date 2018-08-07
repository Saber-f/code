function  generate_gif(d) % d为每幅画的间隔时间
    global flage;
    if isempty(flage)
        flage = true;
    end
    frame=getframe(gcf);
    im=frame2im(frame); %制作gif文件，图像必须是index索引图像
    [I,map]=rgb2ind(im,32);
    if flage
        imwrite(I,map,'pic.gif','gif', 'Loopcount',inf,'DelayTime',d);%第一次必须创建！
        flage = false;
    else
        imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',d);
    end
end