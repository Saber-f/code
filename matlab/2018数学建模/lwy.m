clc,clear;%%%��������ռ��еı���
a0=load('lwy.txt');% ��������
a=a0';
b0=a(:,[1:29]);dd0=a(:,[30:end]);%��ȡ�ѷ���ʹ���������
%[b,ps]=mapstd(b0);%�ѷ������ݵı�׼��,b�����׼��������ݣ�ps����ľ�ֵ�ͱ�׼��
%dd=mapstd('apply',dd0,ps); %���������ݵı�׼��
b=b0;
dd=dd0;
group = [ones(3,1);2*ones(26,1)];%��֪�����������ʶ,ǰ20�������ǵ�һ�࣬21-27�ǵ׶���
s=svmtrain(b',group)%ѵ��֧��������������
%sv_index=s.supportvectorindices%����֧�������ı��
sv_index=s.SupportVectorIndices
beta=s.Alpha%���ط��ຯ����Ȩϵ��
bb=s.Bias%���ط��ຯ���ĳ�����
%mean_and_std_trans=s.ScaleData%�������ֵ�������෴������׼�������ĵ���
check = svmclassify(s,b')%��֤��֪�����㣬�õ�������
err_rate=1-sum(group ==check)/length(group)%������֪������Ĵ�����
solution = svmclassify(s,dd')%�Դ�����������з���

