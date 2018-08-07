clear,load W

x1_R  = {'TETCB';'TETXB'};x1_R = replace(x1_R); %x1:终端消费/总消费（能源利用率）
x2_R  = {'REPRB';'NGMPB'};x2_R = replace(x2_R); %x2:清洁能源和可再生能源的生产量
x4_R  = {'LGTCB';'RETCB';'NGTCB';'NUETB'};x4_R = replace(x4_R);         %x4:清洁能源和可再生能源的消耗量
x6_R  = {'TEPRB'};x6_R  = replace(x6_R);        %x6:总能源的生产量
x7_R  = {'TPOPP'};x7_R  = replace(x7_R);        %x7:人均能源的生产量(包含人口)
x8_R  = {'NUETB'};x8_R  = replace(x8_R);        %x8:核能的使用量
x10_R = {'TETPV'};x10_R = replace(x10_R);       %x10:能源的单位价（Billiox Btu）格价(包含人均能源支出)
x11_R = {'ELNIB'};x11_R = replace(x11_R);       %x11:能源的净进口
x12_R = {'WYTCB'};x12_R = replace(x12_R);       %x12:风能产生的能量
x14_R = {'HYTCB'};x14_R = replace(x14_R);       %x14:水电生产量
x16_R  = {'TETCB'};x16_R  = replace(x16_R);     %x16:总能源的消耗
x18_R  = {'LOTCB'};x18_R  = replace(x18_R);     %x18:电力系统损耗
x19_R  = {'ELISB'};x19_R  = replace(x19_R);     %x19:净州际电力销售和相关损失(负和正的价值)
x20_R = replace({'MGTCB','MMTCB'});             %x20:车用乙醇燃料


for i = 1:4
    %x1终端消费/总消费（能源利用率）+
    x(:,1,i) = W(:,i,x1_R(2))./W(:,i,x1_R(1));
    
    %x2清洁能源和可再生能源的生产量+
    x(:,2,i) = zeros(length(W(:,1,1)),1);
    for j = 1:length(x2_R)
        x(:,2,i) = x(:,2,i) + W(:,i,x2_R(j));
    end
    
    %x3清洁能源和可再生能源的生产量占总生产能量的比值+
    x(:,3,i) = x(:,2,i)./W(:,i,x6_R);
    
    %x4:清洁能源和可再生能源的消耗量+
    x(:,4,i) = zeros(length(W(:,1,1)),1);
    for j = 1:length(x4_R)
        x(:,4,i) = x(:,4,i) + W(:,i,x4_R(j));
    end
    
    %x5:清洁能源和可再生能源的消耗量占总生产能量的比值+
    x(:,5,i) = x(:,4,i)./W(:,i,x16_R);
    
    %x6总能源的生产量+
    x(:,6,i) = W(:,i,x6_R);
    
    %x7:人均能源的生产量+
    x(:,7,i) = x(:,6,i)./W(:,i,x7_R);
    
    %x8:核能的使用量+
    x(:,8,i) = W(:,i,x8_R);
    
    %x9:核能的使用量占能源使用总量的比例+
    x(:,9,i) = x(:,8,i)./W(:,i,x16_R);
    
    %x10:能源的单位价（Billiox Btu）格价+
    x(:,10,i) = W(:,i,x10_R).*W(:,i,x7_R)./x(:,6);
    
    %x11:能源的净进口-
    x(:,11,i) = W(:,i,x11_R)*-1;
    
    %x12:风能生产量+
    x(:,12,i) = W(:,i,x12_R);
    
    %x13:占总生产能比+
    x(:,13,i) = x(:,12,i)./W(:,i,x6_R);
    
    %x14:水电生产量+
    x(:,14,i) = W(:,i,x14_R);
    
    %x15:占总生产能比+
    x(:,15,i) = x(:,14,i)./W(:,i,x6_R);
    
    %x16:总能源的消耗-
    x(:,16,i) = W(:,i,x16_R)*-1;
    
    %x17:人均能源的消耗量-
    x(:,17,i) = x(:,16)./W(:,i,x7_R)*-1;
    
    %x18:电力系统损耗-
    x(:,18,i) = W(:,i,x18_R)*-1;
    
    %x19:净州际电力销售和相关损失(负和正的价值)+
    x(:,19,i) = W(:,i,x19_R);
    
    %x20:车用乙醇燃料+
    x(:,20,i) = W(:,i,x20_R(1)) - W(:,i,x20_R(2));
   
end

gy = [2,4,6,7,8,10,11,12,14,16,17,18,19,20];

%标准化
% for i = 1:length(x(1,:,1))
%     x(:,i,:) = (x(:,i,:) - min(min(x(:,i,:))))/(max(max(x(:,i,:))) - min(min(x(:,i,:))));
% end
for i = 1:length(gy)
    x(:,gy(i),:) = (x(:,gy(i),:) - min(min(x(:,gy(i),:))))/(max(max(x(:,gy(i),:))) - min(min(x(:,gy(i),:))));
end

for i = 1:length(x(:,1,1))
    for j = 1:length(x(1,1,:))
        C(i,j) = sum(x(i,:,j));
    end
end

figure
plot(1960:2009,C)
S(1) = {'Arizoxa'};
S(2) = {'Califorxia'};
S(3) = {'New Mexico'};
S(4) = {'Texas'};
legend(S)