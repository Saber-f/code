RC = load('allData.txt'); %ԭʼ����

%% �۸�-�ɹ�ʧ��ͼ
figure
plot(RC(:,3),RC(:,4),'b*');
title('�۸�-�ɹ�ʧ��ͼ');
xlabel('�۸�(Ԫ)');
ylabel('δ���(0),���(1)');
set(gca,'XLim',[63 87]);%X���������ʾ��Χ
set(gca,'YLim',[-0.3 1.3]);%X���������ʾ��Χ

