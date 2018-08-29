function y = f(x)
    global G path T p
    p = [path(floor(x(1)),:);path(floor(x(7)),:);path(floor(x(13)),:)]; % 选择路径
    t = [0,0,0]; % 已用时间
    T = zeros(3,12); % 记录到达和离开中间六个地点的时间
    t_w = sum(x([2:6,8:12,14:18])) + (30+30)*3; % 游览时间
    for i = 1:6  % 计算时间
        for j = 1:3
            t(j) = t(j) + G(p(j,i),p(j,i+1)); % 行走时间增加
            T(j,2*i-1) = t(j); %第j个旅团，到达第i个景点的时间
            if p(j,i+1) == 4 %如果到了深林小剧场
                if mod(t(j),30) > 0
                    t(j) = t(j) + (30-mod(t(j),30)); % 等剧场开门
                end
                t(j) = t(j) + 30;
            elseif p(j,i+1) < 4
                t(j) = t(j) + x(p(j,i+1) + (j-1)*6);
            else
                t(j) = t(j) + x(p(j,i+1)+ (j-1)*6 - 1);
            end
            T(j,2*i) = t(j); %第j个旅团，离开第i个景点的时间
        end
    end
    n = [2,2,2]; % 三个旅游团当前所在
    jd = zeros(1,7); % 记录1-7景点到何时有空
    T = [T,[inf;inf;inf]];
    while n(1) < 8 && n(2) < 8 && n(3) < 8 %考虑旅团相互影响，修正T
        [~,i] = min([T(1,2*n(1)-3),T(2,2*n(2)-3),T(3,2*n(3)-3)]);
        if T(i,2*n(i)-3) >= jd(p(i,n(i)))
            jd(p(i,n(i))) = T(i,2*n(i)-2);
        else
            T(i,2*n(i)-2:end) = T(i,2*n(i)-2:end) + (jd(p(i,n(i))) - T(i,2*n(i)-3));
            jd(p(i,n(i))) = T(i,2*n(i)-2);    
        end
        if p(i,n(i)) == 4 % 如果到了剧场
            if mod(T(i,2*n(i)-3),30) > 0
                T(i,2*n(i)-2) = T(i,2*n(i)-3) +  (30-mod(T(i,2*n(i)-3),30)) + 30;
            end
            T(i,2*n(i)-2:end) = T(i,2*n(i)-2:end) + (T(i,2*n(i)-3) + 30) - T(i,2*n(i)-2);
        end
        n(i) = n(i) + 1;
    end
    for i = 1:3
        T(i,end) = T(i,end-1) + G(p(i,end-1),p(i,end));
        if T(i,end) > 300 % 迟到商业街惩罚
            t_w = t_w - (T(i,end) - 300 + 1) * 1000;
        else
            t_w = t_w + T(i,end) - 300;
        end
        j = find(p(i,:) == 2);
        if T(i,2*j-2) > 240 % 游客服务中心关门前不离开惩罚
            t_w = t_w - (T(i,2*j-2) - 240 + 1) * 1000;
        end
    end
    y = -t_w;
end