clc,clear;%%%清除工作空间中的变量
a0=load('lwy.txt');% 导入数据
a=a0';
b0=a(:,[1:29]);dd0=a(:,[30:end]);%提取已分类和待分类数据
%[b,ps]=mapstd(b0);%已分类数据的标准化,b保存标准化后的数据，ps保存的均值和标准差
%dd=mapstd('apply',dd0,ps); %待分类数据的标准化
b=b0;
dd=dd0;
group = [ones(3,1);2*ones(26,1)];%已知样本点的类别标识,前20个数据是第一类，21-27是底二类
s=svmtrain(b',group)%训练支持向量机分类器
%sv_index=s.supportvectorindices%返回支持向量的标号
sv_index=s.SupportVectorIndices
beta=s.Alpha%返回分类函数的权系数
bb=s.Bias%返回分类函数的常数项
%mean_and_std_trans=s.ScaleData%样本点均值向量的相反数；标准差向量的倒数
check = svmclassify(s,b')%验证已知样本点，得到分类结果
err_rate=1-sum(group ==check)/length(group)%计算已知样本点的错判率
solution = svmclassify(s,dd')%对待判样本点进行分类

