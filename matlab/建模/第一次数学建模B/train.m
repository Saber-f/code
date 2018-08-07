clear
%% ��ȡѵ������
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

%% ��������һ��
[input,minI,maxI] = premnmx([f1,f2,f3]');


%% �����������
s = length(class);
output = zeros(s,2);
for i = 1 : s
   output(i,class(i)) = 1; 
end

%% ����������
net = newff(minmax(input),[10 2],{'logsig' 'purelin'},'trainbfg');

%% ����ѵ������
net.trainparam.show = 50;
net.trainparam.epochs = 600;
net.trainparam.goal = 0.001;
net.trainparam.lr = 0.001;

%% ��ʼѵ��
net = train(net,input,output');

%% ��ȡ��������
t1 = B(:,1);
t2 = B(:,2);
t3 = B(:,3);
c = B(:,4);
c = c + 1;

%% �������ݹ�һ��
testInput = tramnmx([t1,t2,t3]',minI,maxI);

%% ����
Y = sim(net,testInput);

%% ͳ��ʶ����ȷ��
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

sprintf('ʶ������%3.3f%%  %3.3f%%',su,ssu)

end