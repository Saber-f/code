% ���˶Ĳ�
clear
money = [5 10]; % ��ʼ�ʽ�
win = [0.5 0.5]; % Ӯ�ĸ���
num = 50; %���㳡��

remain = zeros(sum(money),num);remain(money(1),1) = 1;
x = 1:num;
y1 = zeros(1,num);
y2 = zeros(1,num);

for i = 2:num
    for j = 1:size(remain,1)-1
        if j == 1
            remain(j,i) = remain(j+1,i-1)*win(2);
        elseif j == size(remain,1)
            remain(j,i) = remain(j-1,i-1)*win(1);
        else
            remain(j,i) = remain(j-1,i-1)*win(1) + remain(j+1,i-1)*win(2);
        end
    end 
    y1(i) = y1(i-1) + remain(1,i-1)*win(2); 
    y2(i) = y2(i-1) + remain(sum(money)-1,i)*win(1); 
end
plot(x,y1,x,y2,x,1-y1-y2)

%����gif
fps = 6; %֡��
flage = true;
figure('Color',[1 1 1]);
hold on
for i = 1:length(x)
    axis([0, num, 0, 1])
    if flage
        frame=getframe(gcf);
        im=frame2im(frame); %����gif�ļ���ͼ�������index����ͼ��
        [I,map]=rgb2ind(im,32);
        imwrite(I,map,'pic.gif','gif', 'Loopcount',1,'DelayTime',1/fps);%��һ�α��봴����
        flage = false;
    end
    plot([x(i),x(i)-1],[y1(i),y1(i)],'r','LineWidth',2)
    plot([x(i),x(i)-1],[y2(i),y2(i)],'b','LineWidth',2)
    plot([x(i),x(i)-1],[1-y1(i)-y2(i),1-y1(i)-y2(i)],'k','LineWidth',2)
    xlabel('�Ĳ�����')
    ylabel('����')
    legend('�����','�����','δ�ֳ�ʤ��')
    frame=getframe(gcf);
    im=frame2im(frame); %����gif�ļ���ͼ�������index����ͼ��
    [I,map]=rgb2ind(im,32);
    imwrite(I,map,'pic.gif','gif','WriteMode','append','DelayTime',1/fps);
end

