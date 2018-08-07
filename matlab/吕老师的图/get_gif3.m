%% 家族
%% 生成gif 示例get_gif3([0.9 0.08 0.02;0.3 0.6 0.1;0.3 0.5 0.2],[3;30;50],20,{'r','b','g'})
function [] = get_gif3(A,A0,n,color) %矩阵，初值，多少年，颜色
    fps = 60; %帧数
    fast = 6; %倍速
    d = fast/fps; %时间间隔
    y_init = 0; %y初值
    flage = true;
    dd = 0;d_d = 0.1; %防止重合
    
    %% 处理数据
    time = 1:n;
    val = zeros(length(A),20);
    val(:,1) = A0; %初始分布
    for i = 2:size(val,2)
        for j = 1:size(val,1)
            for m = 1:val(j,i-1)
                r = rand();
                for k = 1:length(A)
                    if r < sum(A(j,1:k))
                        val(k,i) = val(k,i) + 1;
                        break;
                    end
                end
            end
        end
    end
    
    A'- eye

    t_max = max(time)+0.5;
    l_t = length(time)+1;
    time(l_t) = time(l_t-1);
    val(:,l_t) = val(:,l_t-1);
    axis([0 t_max 0 y_init+max(max(val))+d_d*size(val,1)+20]);hold on;
    title('家族贫富分布')
    xlabel('时间/年')
    ylabel('人数')
    %生成gif
    x = 0;y = val(:,1);i1 = 1;
    while true
        if x+d < time(i1)
            dd = 0;
            for i = 1:size(val,1)
                plot([x,x+d],[y(i),y(i)]+dd,color{i},'LineWidth',2);
                dd = dd + d_d;
            end
            legend('高收入','中等收入','低收入')
        else
            dd = 0;
            for i = 1:size(val,1)
                plot([x,time(i1)],[y(i),y(i)]+dd,color{i},'LineWidth',2);
                plot([time(i1),time(i1)],[y(i),val(i,i1+1)]+dd,color{i},'LineWidth',2);
                y(i) = val(i,i1+1);plot([time(i1),x+d],[y(i),y(i)]+dd,color{i},'LineWidth',2);
                dd = dd + d_d;
            end
            legend('高收入','中等收入','低收入')
            i1 = i1 + 1;
            if i1 >= length(time)
                break
            end
        end
        x = x + d;
        frame=getframe(gcf);
        im=frame2im(frame); %制作gif文件，图像必须是index索引图像
        [I,map]=rgb2ind(im,32);
        if flage
            imwrite(I,map,'pic.gif','gif', 'Loopcount',inf,'DelayTime',1/fps);%第一次必须创建！
            flage = false;
        else
            imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',1/fps);
        end
        if i1 > size(time,2)
            break
        end
    end
end