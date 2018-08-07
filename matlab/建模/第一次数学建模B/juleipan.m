clear
A = load('data1_1f2.txt');
B = (A(:,[1,2,5]));
[~,s] = sort(B(:,3));
B = B(s,:);
C(1) = 0;C(2) = 1;j = 2;
for i = 2: length(B)
    if B(i,3) ~= B(i - 1,3)
       j = j + 1;
       C(j) = C(j - 1) + 1; 
    else
       C(j) = C(j) + 1;
    end
end


figure
i = 1;
hold on
plot(B(C(i) + 1:C(i + 1),2),B(C(i) + 1:C(i + 1),1),'*');
i= i + 1;
hold on
plot(B(C(i) + 1:C(i + 1),2),B(C(i) + 1:C(i + 1),1),'x');
i= i + 1;
hold on
plot(B(C(i) + 1:C(i + 1),2),B(C(i) + 1:C(i + 1),1),'v');
%i= i + 1;
%hold on
%plot(B(C(i) + 1:C(i + 1),2),B(C(i) + 1:C(i + 1),1),'o');
%i= i + 1;
%hold on
%plot(B(C(i) + 1:C(i + 1),2),B(C(i) + 1:C(i + 1),1),'>');



title('会员聚类分布图(三类)','FontSize',14);
xlabel('经度','FontSize',12);
ylabel('纬度','FontSize',12);
legend('1,','2','3');

