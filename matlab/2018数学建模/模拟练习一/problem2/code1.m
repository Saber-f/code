% 拟合2018年存贷金额及利率
load zcf
load CD  %中有各省15-17年的存贷金额矩阵CD,存贷利率矩阵CD_,均为30*6
cx = []; %存款拟合系数
dx = []; %贷款拟合系数
cx_ = [];
dx_ = [];
zcfjz = [2,4,5];
for k = 1:length(CD)
    % 存款
    t = regress(CD(k,[1,3,5])',zcf(1:3,zcfjz));
    C(k,1) = zcf(4,zcfjz) * t;% 18年存款
    cx = [cx,t];

    % 贷款
    t = regress(CD(k,[2,4,6])',zcf(1:3,zcfjz));
    D(k,1) = zcf(4,zcfjz) * t;% 18年存款
    dx = [dx,t];
    
    if k < 31
        % 存款利率
        t = regress(CD_(k,[1,3,5])',zcf(1:3,zcfjz));
        C_(k,1) = zcf(4,zcfjz) * t;% 18年存款
        cx_ = [cx_,t];
        
        % 贷款
        t = regress(CD_(k,[2,4,6])',zcf(1:3,zcfjz));
        D_(k,1) = zcf(4,zcfjz) * t;% 18年存款
        dx_ = [dx_,t];
    end
end
CD = [CD,C,D];
CD_ = [CD_,C_,D_];
save('CD','CD','CD_'); %保存结果，C为