% ������
% norminv(rand,C(1,1),C(1,2))
tic
load C % ϵ���ȷ������
N = 100000; % �������
X = [];
Y = [];
for n = 1:1
    R = []; % ���׼����
    for k = 1:N
        t = 0; % ��ǰ���
        mint = t; % ���ٽ��
        for m = 1:365
            %         t = t + (tinv(rand,C(2,3))-C(2,2))/C(2,1);
            t2 = norminv(rand,0,C(n,2));
            t = t + t2;
            if t < mint
                mint = t;
            end
        end
        R = [R,mint];
    end
    
    a = R;
    [b x]=hist(a,100);
    num=numel(a);
    y=cumsum(b/num);        %�ۻ��ֲ�
    X = [X;x];
    Y = [Y;y];
    n
    toc
end
clear t mint C N k m n x y
