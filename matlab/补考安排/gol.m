function [o] = gol(k)
    global x f fd y eps
    y3 = zeros(1,length(x));
    y3(1) = f(x(1));
    for i = 1:length(x)-1
        y3(i+1) = y3(i) + eps * fd(y3(i));
        y3(i+1) = y3(i) + eps *(k*fd(y3(i)) + (1-k)*fd(y3(i+1)));
    end
    o = sum(abs(y3-y))/length(y);
end

