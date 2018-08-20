% ´æÈ¡¿î
load zcf
load CD
k = 1
n = 1;
PB = [];
for m = 2:4
    zcfjz = [1,m,5];
    t = regress(CD(:,2),zcf(1:3,zcfjz));
    PB = [PB;[t',zcf(4,zcfjz) * t]];
    n = n + 1;
end

for m = 3:4
    zcfjz = [2,m,5];
    t = regress(CD(:,2),zcf(1:3,zcfjz));
    PB = [PB;[t',zcf(4,zcfjz) * t]];
    n = n + 1;
end

zcfjz = [3,4,5];
t = regress(CD(:,2),zcf(1:3,zcfjz));
    PB = [PB;[t',zcf(4,zcfjz) * t]];

