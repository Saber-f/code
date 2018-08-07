load W
[~,~,E] = xlsread('data\evaluate2.xlsx');
E = [replace(E(:,1)),cell2mat(E(:,2))];
WE = W(:,:,E(:,1));

C = zeros(50,4);
%±ê×¼»¯
for i = 1:length(WE(1,1,:))
   WE(:,:,i) = WE(:,:,i) * E(i,2);
   C = C + (WE(:,:,i) - min(min(WE(:,:,i)))) ./  (max(max(WE(:,:,i))) - min(min(WE(:,:,i))));
end
plot(C)
S(1) = {'Arizoxa'};
S(2) = {'Califorxia'};
S(3) = {'New Mexico'};
S(4) = {'Texas'};
legend(S)