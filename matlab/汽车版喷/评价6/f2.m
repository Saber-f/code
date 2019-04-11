function y = f2(x)
    global A m n p S st g1 g2
    [~,s] = sort(x);
    x = zeros(1,m);
    y = 0;
    for i = 1:m
        [~,t] = sort(A(s(i),:)); 
        for j = n:-1:1
            if sum(x == t(j)) == 0
                x(s(i)) = t(j);
                y = y - A(s(i),t(j));
                break
            end
        end
    end
    st(g1) = y;
    if g1 == p
        S(g2) = min(st);
        g2 = g2 + 1;
        g1 = 0;
    end
    g1 = g1 + 1;
end