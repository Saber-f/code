clear
load snet2.mat;
A = load('f2.txt');

%% ��������
range = [3,10];     %�����������Χ
k1 = 0.1,k2 = 0.1;  %y1 = k1*(65-y1)^2   y2 = k2*(65-y2)^2
k3 = 0.6;           %�����=ԭ��*(1/n)*(1-k3) + k3
bound = [65 85];    %�۸�Χ


%% ��һ��
tinput = tramnmx(A(:,1:3)',minI,maxI);

i = 1;n = 0;
while(1)
	tY = sim(snet,tramnmx(A(i,1:3)',minI,maxI));
	if(A(i,3) < bound(1))
		tY(1) = tY(1) + k1 * (bound(1) - A(i,3)).^2;
    end
    if(A(i,3) > bound(2))
		tY(2) = tY(2) + k2 * (A(i,3) - bound(2)).^2;
	end
	if tY(1) > tY(2)	
		if j ~= 1 && n ~= 0
            A(i,3) = A(i,3) + 0.5;
            i = i + 1;
            if i > length(A)
                break;
            end
        end
         A(i,3) = A(i,3) + 0.5;
		j = 1;		
    else	
		if j ~= 2 && n ~= 0
            i = i + 1;
            if i > length(A)
                break;
            end
        end
        A(i,3) = A(i,3) - 0.5;
		j = 2;
    end
    n = n + 1;
end


A_A = zeros(length(A),length(A));


for i = 2:length(A)
   for j = 1 : i - 1
        A_A(i,j) = sqrt(sum((A(i,1:2) - A(j,1:2)).^2));
   end
end
A_A = A_A + A_A';

D01 = A_A < 0.02;
D01 = D01.*~eye(length(D01));
D01fj = D01;

%% ���������
refer = 1:length(D01);                                                                                      %refer��¼�仯��ı��
sumA = sum(D01);[~,t1] = sort(-sumA);D01 = D01(:,t1);D01 = D01(t1,:);refer = refer(t1);sumA = sumA(t1);     %��A��ÿ��ÿ�а���ͻ�̶ȴӴ�С����

N = 0;  %N Ϊ�����
s = 1:length(D01);
while(1)
    sz = 0;              %szΪ����Ŷ�����
    for k = 1 : length(s)   
        i = 1;   
        T = k:length(s);   %T����Ϊ����λ�Ǳ����   
        while(1)
            if i > length(T)           
                break;        
            end            
            j = 1;
            while(1)
                if j > length(T)            
                    break;            
                end                
                if D01(s(T(i)),s(T(j))) == 0 && i ~= j            
                    T(j) = [];            
                else                   
                    j = j + 1;            
                end
            end
            i = i + 1;    
        end       
        if length(T) > sz
            sz = length(T);
            ZT = T;   
        end        
        if length(s) - k < sz
            break;   
        end
    end
    if length(ZT) < range(1)
       break;
    end
    N= N + 1; %�����
    if length(ZT) < range(2)
        l = length(ZT);
    else
        l = range(2);
    end
    JT(N,1:l) = refer(s(ZT(1:l)));
    s(ZT(1:l)) = [];
end
lj = length(JT);
for i = lj + 1 : lj + length(s)
   JT(i,1) = refer(s(i - lj)); 
end

N = 0;M = 0;
m = range(2) + 1;
for i = 1 : length(JT)
   n = sum(JT(i,1:range(2)) > 0);
   N = N + n; 
   JT(i,m) = sum(A(JT(i,1:n),3));
   M = M + JT(i,m);
   JT(i,m+1) = floor(2 * JT(i,m)*((1/n)*(1-k3)+k3))/2;
end
   