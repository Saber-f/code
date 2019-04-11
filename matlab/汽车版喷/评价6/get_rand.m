function y = get_rand(size,sum_i)
    y = rand(1,size);
    while true
        s = sum(y)-sum_i;
        if s == 0
            break;
        elseif s < 0
            t = randi(size);
            d = (1-y(t))*0.001;
            if -s < d
                y(t) = y(t) - s;
                break;
            else
                y(t) = y(t) + d;
            end
        else
            t = randi(size);
            d = y(t)*0.001;
            if s < d
                y(t) = y(t) - s;
                break;
            else
                y(t) = y(t) - d;
            end
        end     
    end
end