clear
RC = load('allData.txt'); %ԭʼ����


[price,s] = sort(RC(:,3));j = 1;
price2 = unique(price);
pm = zeros(3,length(price2));pm(:,1) = ones(3,1); 
for i = 2:length(RC)
    if price(i) ~= price(i-1)
       j = j + 1; 
    end
    pm(1,j) = pm(1,j) + 1;
    if(RC(s(i),4)) < 1
       pm(2,j) = pm(2,j) + 1; 
    else
       pm(3,j) = pm(3,j) + 1;
    end 
end



figure
plot(price2,pm(1,:)','-');
hold on
plot(price2,pm(2,:)','-');
hold on
plot(price2,pm(3,:)','-');
title('�۸�-����ͼ');
xlabel('�۸�(Ԫ)');
ylabel('����(��)');
set(gca,'XLim',[64.5 85.5]);%X���������ʾ��Χ
set(gca,'YLim',[0 160]);%X���������ʾ��Χ
legend('������','ʧ������','�ɹ�����');

