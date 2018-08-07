function [] = plotf(A)
    for i = 1:length(A)
        x(2*i-1) = i-1;
        x(2*i) = i;
        y(2*i-1) = A(i);
        y(2*i) = A(i);
    end
    plot(x,y)
end

