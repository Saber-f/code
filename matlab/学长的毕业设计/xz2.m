clear all
clc
w=4;  %����
%�û�����x=[4,8,16,32,64,128,256��512,1024]��ѡ��
%һά��/������������������Ԫ���ÿո���߶��ŷָ������÷����Ű���������Ԫ����������
x=16;   %�û���
code=cell(1);%cell��matlab�е�һ���������ͣ��ô����Ŷ��壬������������������͵����ݻ����
k=0;
code{1}=ones(1,w);
while(size(code,2)<x)%r=size(A,1)����䷵�ص��Ǿ���A��������r=size(A,2) ����䷵�ص��Ǿ���A������
    flag=0; %����һ����ǣ����ڿ���ѭ��
    k=k+1;
    A=[1 zeros(1,k)]; %���ڲ���
    newCode=repmat(A,1,w);%����������
    for i=1:size(code,2)
        M=length(code{i});
        N=length(newCode);
        L=M+N-1;
        a=[code{i} zeros(1,L-M)];%ת��Ϊ�ȳ���ֵ����
        b=[newCode zeros(1,L-N)];%ת��Ϊ�ȳ���ֵ����
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
        if max(y)>1%newCode������Ҫ��
            flag=1;
            break;
        else
            continue;
        end
    end
    if(flag==0)%�ҵ�����Ҫ�������
        code{end+1}=newCode;%end��ʾ��������һ��Ԫ���±꣬code{end+1}��̬����code
    end
end
k+1;

%% ��ͼ
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
axis([0 max_x 0 2*size(code,2)+1]); % ������������ָ��������
for i = 1:size(code,2)
    A = code{i};
    for i = 1:length(A)
        fprintf(num2str(A(i)))
    end
    fprintf('\n')
end

