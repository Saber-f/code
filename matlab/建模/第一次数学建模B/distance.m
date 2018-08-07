clear
RC = load('allData.txt'); %ԭʼ����
D = RC(:,[1,2]); %��γ
DM = zeros(length(D),length(D)); %�������
for i = 2:length(D)
    for j = 1 : i
        DM(i,j) = sqrt((D(i,1) - D(j,1))^2 + (D(i,2) - D(j,2))^2);
    end
end
DM = DM + DM' + eye(length(D),length(D));

T = zeros(length(D)*(length(D) - 1) / 2,1);
n = 0;
for i = 2:length(D)
    for j = 1 : i
        n = n + 1;
        T(n) = DM(i,j);
    end
end
T = sort(T);