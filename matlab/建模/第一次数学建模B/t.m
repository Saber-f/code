%% ��ȡѵ������


%% ��������һ��
tinput = tramnmx(A(:,1:3)',minI,maxI);

%% �������ݹ�һ��
tY = sim(snet,tinput);
ANS = tY(1,:) > tY(2,:);

