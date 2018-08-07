%风能条形图
clear
load W
D = zeros(4,50);
n = replace({'TPOPP'});
for i = 1:4
    for j = 1:50
           D(i,j) = W(j,i,n);
    end
end
for i = 1:5
   D(:,i) = sum(D(:,i:i+9),2);
   D(:,1+1:1+9) = [];
end

c = categorical({'1960-1969','1970-1979','1980-1989','1990-1999','2000-2009'});
bar(c,D')
S(1) = {'Arizoxa'};
S(2) = {'Califorxia'};
S(3) = {'New Mexico'};
S(4) = {'Texas'};
legend(S)
box off
title('Resident population including Armed Forces.')
xlabel('Year')
ylabel('Thousand')