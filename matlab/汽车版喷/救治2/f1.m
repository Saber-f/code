function y = f1(x)
%完成时间
    global D C W
    [~,s] = sort(x(1:size(D,1)));  %索引
    se = [x(size(D,1)+1:end),1];   %选设备
    is = [1,length(s)-1];          %初始范围
    y = 0;                         %完成时间
    for i = 1:size(C,1)
        h = is(1) + round(is(2) * se(i));
        yt = 0;
        [~,t] = sort(D(s(is(1):h),1));s(is(1):h) = s(t+is(1)-1);  %重伤优先
        for j = is(1):h               %s(j)为再第i台设备上的伤员
            yt = yt + W(i,j-is(1)+1); %准备时间
            yt = yt + C(i,D(s(j),1)*2+1) + C(i,D(s(j),1)*2+2) * D(s(j),2);
        end
        if yt > y
            y = yt;
        end
        is(2) = is(2) - (h-is(1)+1);
        is(1) = h + 1;
        if (is(1) > 360)
            break;
        end
    end
    g(y);
end