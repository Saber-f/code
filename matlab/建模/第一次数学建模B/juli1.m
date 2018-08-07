clear
A = load('allData.txt');B = load('data1_1f2.txt');
S = zeros(length(A),length(B));
for i = 1 : length(A)
   for j = 1 : length(B) 
       S(i,j) = sqrt(sum((A(i,1:2) - B(j,1:2)).^2));
   end
end

dr = min(S')';

figure
plot(dr,A(:,3),'x');
title('任务与会员最短距离-价格图','FontSize',14);
xlabel('距离','FontSize',12);
ylabel('价格（元）','FontSize',12);
%set(gca,'XLim',[0 0.36]);%X轴的数据显示范围
set(gca,'YLim',[65 90]);%X轴的数据显示范围