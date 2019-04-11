function y = f1(x)
    global A m p S st g1 g2
    [~,s] = sort(x);
    x = s(1:m);
    y = 0;
    for i = 1:m
        y = y - A(i,x(i));
    end
    st(g1) = y;
    if g1 == p
        S(g2) = min(st);
        g2 = g2 + 1;
        g1 = 0;
    end
    g1 = g1 + 1;
end