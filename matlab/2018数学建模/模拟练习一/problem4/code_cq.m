% 各省2017备付金计算
clear
load cq
Cq = cq(:,1:2:30) - cq(:,2:2:30);
cq_ = Cq;
cq_(:,:) = 0;
cq_(1,:) = Cq(1,:);
for k = 2:365
    cq_(k,:) = cq_(k-1,:) + Cq(k,:);
end
