% 寻找贷款量和贷款规模的关系
load zcf
load CD

PB = zeros(30,6);

% CD(:,4) = CD(:,4)./CD(:,2);
% CD(:,6) = CD(:,6)./CD(:,2);
% CD(:,2) = 1;

for k = 1:30
    n = 1;
    for m = 2:4
        zcfjz = [1,m,5];
        t = regress(CD_(k,[2,4,6,8])',[CD(k,[2,4,6,8])',zcf(:,zcfjz)]);
        PB(k,n) = t(1);
        n = n + 1;
    end
    for m = 3:4
        zcfjz = [2,m,5];
        t = regress(CD_(k,[2,4,6,8])',[CD(k,[2,4,6,8])',zcf(:,zcfjz)]);
        PB(k,n) = t(1);
        n = n + 1;
    end
    
    zcfjz = [3,4,5];
    t = regress(CD_(k,[2,4,6,8])',[CD(k,[2,4,6,8])',zcf(:,zcfjz)]);
    PB(k,n) = t(1);
    
end
save('PB','PB'); %保存结果

for k = 1:6
    PB_(:,k) = PB(:,k)/(max(PB(:,k))-min(PB(:,k)));
end