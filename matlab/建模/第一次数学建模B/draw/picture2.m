clear
RC = load('allData.txt'); %原始数据


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
title('价格-人数图');
xlabel('价格(元)');
ylabel('人数(人)');
set(gca,'XLim',[64.5 85.5]);%X轴的数据显示范围
set(gca,'YLim',[0 160]);%X轴的数据显示范围
legend('总人数','失败人数','成功人数');

