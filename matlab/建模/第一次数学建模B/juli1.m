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
title('�������Ա��̾���-�۸�ͼ','FontSize',14);
xlabel('����','FontSize',12);
ylabel('�۸�Ԫ��','FontSize',12);
%set(gca,'XLim',[0 0.36]);%X���������ʾ��Χ
set(gca,'YLim',[65 90]);%X���������ʾ��Χ