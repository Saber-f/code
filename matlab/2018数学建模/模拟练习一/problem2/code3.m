% 所有系数
load zcf
load CD
zcfjz = [1,4,5];
C_x = [];
for k = 1:30     
    t = regress(CD_(k,[2,4,6,8])',[CD(k,[2,4,6,8])',zcf(:,zcfjz)]);
    C_x = [C_x,t];
end