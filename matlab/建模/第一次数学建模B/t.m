%% 读取训练数据


%% 将特征归一化
tinput = tramnmx(A(:,1:3)',minI,maxI);

%% 测试数据归一化
tY = sim(snet,tinput);
ANS = tY(1,:) > tY(2,:);

