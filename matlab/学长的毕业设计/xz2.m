clear all
clc
w=4;  %码重
%用户数从x=[4,8,16,32,64,128,256，512,1024]中选择
%一维行/列向量：把所有数组元素用空格或者逗号分隔，并用方括号把所有数组元素括起来。
x=16;   %用户数
code=cell(1);%cell是matlab中的一种数据类型，用大括号定义，括号里可以是任意类型的数据或矩阵。
k=0;
code{1}=ones(1,w);
while(size(code,2)<x)%r=size(A,1)该语句返回的是矩阵A的行数，r=size(A,2) 该语句返回的是矩阵A的列数
    flag=0; %定义一个标记，用于控制循环
    k=k+1;
    A=[1 zeros(1,k)]; %周期部分
    newCode=repmat(A,1,w);%产生周期码
    for i=1:size(code,2)
        M=length(code{i});
        N=length(newCode);
        L=M+N-1;
        a=[code{i} zeros(1,L-M)];%转化为等长数值数组
        b=[newCode zeros(1,L-N)];%转化为等长数值数组
        y=zeros(1,L);
        for m=1:L
            temp=0;
            for n=1:L
                if m>=n
                    temp=temp+a(n)*b(m+1-n);
                else
                    break;
                end
            end
            y(m)=temp;
        end
        if max(y)>1%newCode不符合要求
            flag=1;
            break;
        else
            continue;
        end
    end
    if(flag==0)%找到符合要求的码字
        code{end+1}=newCode;%end表示矩阵的最后一个元素下标，code{end+1}动态扩大code
    end
end
k+1;

%% 画图
T = 1;max_x = 0;
for i = size(code,2):-1:1
    A = code{i};
    max_x = max([max_x length(A)+1]);
    for i = 1:length(A)
        x(2*i-1) = i-1;
        x(2*i) = i;
        y(2*i-1) = A(i);
        y(2*i) = A(i);
    end
    plot(x,y+T)
    hold on
    T = T + 2;
    clear x y
end
axis([0 max_x 0 2*size(code,2)+1]); % 设置坐标轴在指定的区间
for i = 1:size(code,2)
    A = code{i};
    for i = 1:length(A)
        fprintf(num2str(A(i)))
    end
    fprintf('\n')
end

