t0=100;%����
x0=-10;%��ʼ��
s0=x0^2+2*x0+1;%��ʼĿ�꺯��ֵ
delta=1;%x����

for t=t0:-10:0
    for k=1:50
       % ���ﲻ��ֻ������
        if rand() < 0.5
            x1=x0+delta; %�½�
        else
            x1=x0-delta; %�½�
        end
        
        s1=x1^2+2*x1+1;
        if s1<s0 %�ж�״̬����
            x0=x1; %���½���Ϊ��ǰ��
            s0 = s1;%����©��
        else
            p=exp(-(s1-s0)/t*k);%���ܸ���
            if rand(1)<p
                x0=x1;
                s0=s1;
                
            end
        end
    end
end

x0