clear
m = 1; %�м�������
n = 6; %ÿ�����ӵ�������
D = ones(1,m); %m�������ų�һ��
R  = zeros(1,m*n-m+1); %���
i = 1;
b = false;
while true
    t = sum(D) - m + 1; %���ӵĵ���->�Ǳ�
    R(t) = R(t) + 1;
    while D(i) + 1 > n %��λ
        if i == m
            b = true;
            break;
        end
        D(i) = 1;
        i = i + 1; 
    end
    if b
       break; 
    end
    D(i) = D(i) + 1;
    i = 1;
end
R = R/sum(R);
figure
X = m:m*n;
plot(X,R,'x')

%�����̬�ֲ�����
options = optimset('MaxFunEvals',6000);
fun = @(c,x)exp(-(x-(m*n+m)/2).^2/2/c^2)/(2*pi)^0.5/c;
c0 = 1;
c = lsqcurvefit(fun,c0,X,R,[],[],options)
hold on;
x = min(X):0.1:max(X);
plot(x,fun(c,x));

clear ans b i t D x X options c0