function y = bj(x)
    load b;
    y = zeros(1,5);
    for i = 1:5
       y(i) = (x(i)-b(i,2))/b(i,1); 
    end
    y = sum(y(3:5))-sum(y(1:2));
    y = y + x(6)/x(5) + x(7)/x(5) + x(2)/x(1) + x(3)/x(1);
end