RC = load('allData.txt'); %原始数据

%% 价格-成功失败图
figure
plot(RC(:,3),RC(:,4),'b*');
title('价格-成功失败图');
xlabel('价格(元)');
ylabel('未完成(0),完成(1)');
set(gca,'XLim',[63 87]);%X轴的数据显示范围
set(gca,'YLim',[-0.3 1.3]);%X轴的数据显示范围

