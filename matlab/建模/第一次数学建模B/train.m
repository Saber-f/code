clear
%% 读取训练数据
AA = load('trainData.txt');


ssu = 0;


load snet.mat;

for i = 1 : 1000


A = AA(randperm(length(AA)),:);
B = A(1:100,:);
A(1:100,:) = [];

f1 = A(:,1);
f2 = A(:,2);
f3 = A(:,3);
class = A(:,4);

class = class + 1;

%% 将特征归一化
[input,minI,maxI] = premnmx([f1,f2,f3]');


%% 构造输出矩阵
s = length(class);
output = zeros(s,2);
for i = 1 : s
   output(i,class(i)) = 1; 
end

%% 创建神经网络
net = newff(minmax(input),[10 2],{'logsig' 'purelin'},'trainbfg');

%% 设置训练参数
net.trainparam.show = 50;
net.trainparam.epochs = 600;
net.trainparam.goal = 0.001;
net.trainparam.lr = 0.001;

%% 开始训练
net = train(net,input,output');

%% 读取测试数据
t1 = B(:,1);
t2 = B(:,2);
t3 = B(:,3);
c = B(:,4);
c = c + 1;

%% 测试数据归一化
testInput = tramnmx([t1,t2,t3]',minI,maxI);

%% 仿真
Y = sim(net,testInput);

%% 统计识别正确率
[s1 , s2] = size(Y);
hitNum = 0;
for i = 1 : s2
   [m , Index] = max(Y(:,i));
   if(Index) == c(i)
       hitNum = hitNum + 1;
   end
end

su = 100 * hitNum / s2;


if ssu < su 
    ssu = su;
    snet = net;
    sB = B;
    sA = A;
    save snet
end

sprintf('识别率是%3.3f%%  %3.3f%%',su,ssu)

end