A = load('juli234.txt');

figure
plot(A(:,2),A(:,1),'x');
title('任务与任务聚类中心距离-价格图','FontSize',14);
xlabel('距离','FontSize',12);
ylabel('价格（元）','FontSize',12);
%set(gca,'XLim',[0 0.36]);%X轴的数据显示范围
set(gca,'YLim',[65 90]);%X轴的数据显示范围

figure
plot(A(:,3),A(:,1),'x');
title('任务与会员聚类中心距离-价格图','FontSize',14);
xlabel('距离','FontSize',12);
ylabel('价格（元）','FontSize',12);
set(gca,'YLim',[65 90]);%X轴的数据显示范围

figure
plot(A(:,4),A(:,1),'x');
title('任务与任务，会员聚类中心距离之和-价格图','FontSize',14);
xlabel('距离','FontSize',12);
ylabel('价格（元）','FontSize',12);
set(gca,'YLim',[65 90]);%X轴的数据显示范围


