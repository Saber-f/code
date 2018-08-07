clear
A = load('allData.txt');
B = load('allDataHy.txt');
A_A = zeros(length(A),length(A));


l1 = length(A) * length(A);l2 = length(A) * length(B);


for i = 2:length(A)
   for j = 1 : i - 1
        A_A(i,j) = sqrt(sum((A(i,1:2) - A(j,1:2)).^2));
   end
end
A_A = A_A + A_A';


A_B = zeros(length(A),length(B));
for i = 1: length(A)
   for j = 1 : length(B) 
       A_B(i,j) = sqrt(sum((A(i,1:2) - B(j,1:2)).^2));
   end
end


N1 = 0.02;N2 = 0.00013;
d1 = (max(max(A_A)) - min(min(A_A))) * N1;
d2 = (max(max(A_B)) - min(min(A_B))) * N2;

s1 = sum(A_A < d1,2);
s2 = sum(A_B < d2,2);


figure
plot(s1,A(:,3),'*');
title('�����ܼ��̶�-�۸�ͼ','FontSize',14);
xlabel('�����ܶ�','FontSize',12);
ylabel('��Ǯ��Ԫ��','FontSize',12);
set(gca,'YLim',[65 90]);%Y���������ʾ��Χ



figure
plot(s2,A(:,3),'*');
title('��Ա�ܼ��̶�-��λͼ','FontSize',14);
xlabel('��Ա�ܶ�','FontSize',12);
ylabel('��Ǯ��Ԫ��','FontSize',12);
set(gca,'YLim',[65 90]);%Y���������ʾ��Χ


figure
plot(s2+s2,A(:,3),'*');
title('��Ա�ܼ��̶��������ܼ��̶�֮��-��λͼ','FontSize',14);
xlabel('��Ա�ܼ��̶��������ܼ��̶�֮��','FontSize',12);
ylabel('��Ǯ��Ԫ��','FontSize',12);
set(gca,'YLim',[65 90]);%Y���������ʾ��Χ

