% ���2018����������
load zcf
load CD  %���и�ʡ15-17��Ĵ��������CD,������ʾ���CD_,��Ϊ30*6
cx = []; %������ϵ��
dx = []; %�������ϵ��
cx_ = [];
dx_ = [];
zcfjz = [2,4,5];
for k = 1:length(CD)
    % ���
    t = regress(CD(k,[1,3,5])',zcf(1:3,zcfjz));
    C(k,1) = zcf(4,zcfjz) * t;% 18����
    cx = [cx,t];

    % ����
    t = regress(CD(k,[2,4,6])',zcf(1:3,zcfjz));
    D(k,1) = zcf(4,zcfjz) * t;% 18����
    dx = [dx,t];
    
    if k < 31
        % �������
        t = regress(CD_(k,[1,3,5])',zcf(1:3,zcfjz));
        C_(k,1) = zcf(4,zcfjz) * t;% 18����
        cx_ = [cx_,t];
        
        % ����
        t = regress(CD_(k,[2,4,6])',zcf(1:3,zcfjz));
        D_(k,1) = zcf(4,zcfjz) * t;% 18����
        dx_ = [dx_,t];
    end
end
CD = [CD,C,D];
CD_ = [CD_,C_,D_];
save('CD','CD','CD_'); %��������CΪ