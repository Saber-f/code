function A = getA(m,n,u,o)
    A = zeros(m,n);
    for i = 1:m
        for j = 1:n
            while true
                t = randn*o + u;
                if t < 1 && t > 0
                    A(i,j) = t;
                    break;
                end
            end
        end
    end
%     if n > m
%         A = [A;-10*ones(n-m,n)];
%     else
%         A = [A,-10*ones(m,n-n)];
%     end
end

