A = load('juli234.txt');

figure
plot(A(:,2),A(:,1),'x');
title('����������������ľ���-�۸�ͼ','FontSize',14);
xlabel('����','FontSize',12);
ylabel('�۸�Ԫ��','FontSize',12);
%set(gca,'XLim',[0 0.36]);%X���������ʾ��Χ
set(gca,'YLim',[65 90]);%X���������ʾ��Χ

figure
plot(A(:,3),A(:,1),'x');
title('�������Ա�������ľ���-�۸�ͼ','FontSize',14);
xlabel('����','FontSize',12);
ylabel('�۸�Ԫ��','FontSize',12);
set(gca,'YLim',[65 90]);%X���������ʾ��Χ

figure
plot(A(:,4),A(:,1),'x');
title('���������񣬻�Ա�������ľ���֮��-�۸�ͼ','FontSize',14);
xlabel('����','FontSize',12);
ylabel('�۸�Ԫ��','FontSize',12);
set(gca,'YLim',[65 90]);%X���������ʾ��Χ


