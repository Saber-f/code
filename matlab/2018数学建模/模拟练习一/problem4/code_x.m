%���մ�����
load cq
N = 100; %����ȡ�������ΪN��С����ͳ�ƴ���

XV = [];
for n = 1:1; %��һ��ʡ
    a = cq(:,2*n-1) - cq(:,2*n);
    
    % load C
    % a = [];
    % for k = 1:365
    %     a = [a,norminv(rand,C(1,1),C(1,2))];
    % end
    
    [b x]=hist(a,N);
    num=numel(a);
    y=cumsum(b/num);        %�ۻ��ֲ�
    XV = [XV;x];
end

clear a num ans n N



