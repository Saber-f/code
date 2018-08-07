RC = load('allData.txt'); %原始数据

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
title('任务完成情况分布图','FontSize',16);
xlabel('经度','FontSize',12);
ylabel('纬度','FontSize',12);
legend('失败','成功');

text(113.7517900000,23.0206700000,'东莞市','FontSize',14);
text(113.1219200000,23.0218500000,'佛山市','FontSize',14);
text(113.2643600000,23.1290800000,'广州市','FontSize',14);
text(113.0561500000,23.6820100000,'清远市','FontSize',14);
text(114.0595600000,22.5428600000,'深圳市','FontSize',14);

text(113.1419200000,23.1290800000,'I','FontSize',18);
text(113.7517900000,22.9006700000,'II','FontSize',18);
text(113.9595600000,22.6028600000,'III','FontSize',18);
