clear
RC = load('allDataHy.txt'); %原始数据

[~,s] = sort(RC(:,3));
data = RC(s,:);
priceuq = unique(data(:,3));

N = 4;  %分成N组
n = N;

A = zeros(1,N);l = length(priceuq);  %A信誉度分段
for i = 1:N
    A(i) = floor(l / n);
    l = l - A(i);
    n = n - 1;
end

for i = 2:N
   A(i) = A(i-1) + A(i); 
end


j = 1;
for i = 2:length(data)
    if data(i,3) ~= data(i - 1,3)
       n = n + 1;
       if n == A(1,j)
           A(2,j) = i - 1;
          j = j + 1; 
       end
    end
end
A(2,N) = length(data);
A2 = [1,A(2,:)];

figure
%for i = 1:N
    i = 1;
    hold on
    plot(data(A2(i):A2(i+1),2),data(A2(i):A2(i+1),1),'*m')
    hold on
    i = i + 1;
    plot(data(A2(i):A2(i+1),2),data(A2(i):A2(i+1),1),'og')
    hold on
    i = i + 1;
    plot(data(A2(i):A2(i+1),2),data(A2(i):A2(i+1),1),'xk')
    hold on
    i = i + 1;
    plot(data(A2(i):A2(i+1),2),data(A2(i):A2(i+1),1),'vr')
%end
title('主要会员信誉度分布图','FontSize',14);
xlabel('经度','FontSize',12);
ylabel('纬度','FontSize',12);
legend('0.0001-7.5925,','7.5925-75.361','75.361-287.4723','287.4723-67997.3868');
text(113.7517900000,23.0206700000,'东莞市','FontSize',12);
text(113.1219200000,23.0218500000,'佛山市','FontSize',12);
text(113.2643600000,23.1290800000,'广州市','FontSize',12);
text(113.0561500000,23.6820100000,'清远市','FontSize',12);
text(114.0595600000,22.5428600000,'深圳市','FontSize',12);