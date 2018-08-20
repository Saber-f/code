d = 0.01;
tr = 0;
for o = 1:100
    t = 100;
    x0 = pi;
    y0 = f(x0);
    while t > 0.001
        for i = 1:1000
            if rand() < 0.5
                x = x0 + d;
            else
                x = x0 - d;
            end
            x = mod(x,2*pi);
            y = f(x);
            if y > y0
                x0 = x;
                y0 = f(x0);
            else
                p = exp(-(y0-y)/t);
                if rand() < p
                    x0 = x;
                    y0 = f(x0);
                end
            end
        end
        t = t * 0.98;
    end
    if x0 > 3
        tr = tr + 1;
    end
end


function y = f(x)
y = sin(x);
if y < 0
    y = -2 * y;
end
end