function y = f2(x)
    global A m n
    [~,s] = sort(x);
    x = zeros(1,m);
    y = 0;
    for i = 1:m
        [~,t] = sort(A(:,s(i))); 
        for j = n:-1:1
            if sum(x == t(j)) == 0
                x(s(i)) = t(j);
                y = y - A(t(j),s(i));
                break
            end
        end
    end
end