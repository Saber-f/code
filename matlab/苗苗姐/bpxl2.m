clear
T_all = importdata('data.txt');
T_all = T_all';
P_all = importdata('data2.txt');
P_all = P_all';

P = P_all(:,1:1000);
T = T_all(1:1000);
[p1,minp,maxp,t1,mint,maxt]=premnmx(P,T);
%创建网络
net=newff(minmax(P),[12,6,1],{'tansig','tansig','purelin'},'trainlm');
%设置训练次数
net.trainParam.epochs = 5000;
%设置收敛误差
net.trainParam.goal=0.0000001;
%训练网络
[net,tr]=train(net,p1,t1);
 
%输入数据
a = P_all(:,1001:end);
%将输入数据归一化
a=premnmx(a);
%放入到网络输出数据
b=sim(net,a);
%将得到的数据反归一化得到预测数据
c=postmnmx(b,mint,maxt);
an = [T_all(1001:end)',c'];
plot(an)