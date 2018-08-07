%% ��������
time = rand(1,10);
val = floor((rand(1,10)-0.5)*20)*100;
color = {'red', 'blue'};

get_gif(time,val,color)

%% ����gif
function [] = get_gif(time,val,color)
    fps = 60; %֡��
    fast = 1; %����
    d = fast/fps; %ʱ����
    y_init = 1000; %y��ֵ
    flage = true;
    dd = 0;d_d = 0.1; %��ֹ�غ�
    
    %�ۼ�
    for i = 1:size(time,1)
        for j = 2:size(time,2)
            time(i,j) = time(i,j-1) + time(i,j);
            val(i,j) = val(i,j-1) + val(i,j); 
        end
    end
    t_max = max(max(time))+0.5;
    l = size(time,2)+1;
    for i = 1:size(time,1)
        time(i,l) = t_max;
        val(i,l) = val(i,l-1);
    end
    axis([0 t_max min(min(val)) y_init+max(max(val))+d_d*size(val,1)]);hold on;
    title('�����ʽ�')
    ylabel('ʣ���ʽ�/Ԫ')
    xlabel('ʱ��/Сʱ')
    %����gif
    for i = 1:size(time,1)
        x = 0;y = y_init;i1 = 1;
        while true
            if x+d < time(i,i1)
                plot([x,x+d],[y,y]+dd,color{i},'LineWidth',3);
            else
                t = x;cy = y;
                while x+d > time(i,i1)
                    plot([t,time(i,i1)],[y,y]+dd,color{i},'LineWidth',3);%����
                    plot([time(i,i1),time(i,i1)],[y,val(i,i1)],color{i}','LineWidth',3);%����  
                    t = time(i,i1);y = val(i,i1);i1 = i1 + 1;
                    if i1 > size(time,2)
                        break
                    end
                end
                %plot([x,x+d],[cy,y]+dd,color{i},'LineWidth',1);%����
                plot([t,x+d],[y,y]+dd,color{i},'LineWidth',3);%����
            end
            x = x + d;
            frame=getframe(gcf);
            im=frame2im(frame); %����gif�ļ���ͼ�������index����ͼ��
            [I,map]=rgb2ind(im,32);
            if flage
                imwrite(I,map,'pic.gif','gif', 'Loopcount',inf,'DelayTime',d);%��һ�α��봴����
                flage = false;
            else
                imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',d);
            end
            if i1 > size(time,2)
                break
            end
        end
        dd = dd + d_d;
    end
end