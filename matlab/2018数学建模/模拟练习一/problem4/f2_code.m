% 使用插值计算
N = 100000; % 仿真次数
R = [];

for k = 1:N
    r = 0;
    for m = 1:365
        r = r + ff(rand,f,x(1),x(length(x)));
    end
    R = [R,r];
end

clear N k n r

function y = ff(x,f,min_,max_)
    while max_ - min_ >= 1
       y = (max_ + min_)/2;
       if f(y) > x
            max_ = y;
       elseif f(y) < x
           min_ = y;
       else
           break;
       end
    end
end