function Z = getZ(m)
    z1 = [];
    z2 = [];
    for i = 1:m
        z1 = [z1,eye(m)];
        t = zeros(m);
        t(i,:) = 1;
        z2 = [z2,t];
    end
    Z = [z1;z2];
end