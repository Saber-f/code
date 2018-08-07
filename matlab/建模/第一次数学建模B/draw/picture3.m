RC = load('allData.txt'); %ԭʼ����

%[~,s] = sort(RC(:,3));
data = RC;


d0 = [];d1 = [];
for i = 1 : length(data)
    if data(i,4) == 0
        d0 = [d0,i];
    else
        d1 = [d1,i];
    end
end

figure
plot(data(d0,2),data(d0,1),'xr');
hold on
plot(data(d1,2),data(d1,1),'og')
title('�����������ֲ�ͼ','FontSize',16);
xlabel('����','FontSize',12);
ylabel('γ��','FontSize',12);
legend('ʧ��','�ɹ�');

text(113.7517900000,23.0206700000,'��ݸ��','FontSize',14);
text(113.1219200000,23.0218500000,'��ɽ��','FontSize',14);
text(113.2643600000,23.1290800000,'������','FontSize',14);
text(113.0561500000,23.6820100000,'��Զ��','FontSize',14);
text(114.0595600000,22.5428600000,'������','FontSize',14);

text(113.1419200000,23.1290800000,'I','FontSize',18);
text(113.7517900000,22.9006700000,'II','FontSize',18);
text(113.9595600000,22.6028600000,'III','FontSize',18);
