clear
T_all = importdata('data.txt');
T_all = T_all';
P_all = importdata('data2.txt');
P_all = P_all';

P = P_all(:,1:1000);
T = T_all(1:1000);
[p1,minp,maxp,t1,mint,maxt]=premnmx(P,T);
%��������
net=newff(minmax(P),[12,6,1],{'tansig','tansig','purelin'},'trainlm');
%����ѵ������
net.trainParam.epochs = 5000;
%�����������
net.trainParam.goal=0.0000001;
%ѵ������
[net,tr]=train(net,p1,t1);
 
%��������
a = P_all(:,1001:end);
%���������ݹ�һ��
a=premnmx(a);
%���뵽�����������
b=sim(net,a);
%���õ������ݷ���һ���õ�Ԥ������
c=postmnmx(b,mint,maxt);
an = [T_all(1001:end)',c'];
plot(an)