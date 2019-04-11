function k = get_k(x)
%不满意度
    global PD car L
    k = zeros(L,1); %等待辆数
    fini = k;       %记录完成时间
    l = floor(x(end));
    [~,s] = sort(x(1:L));
    s1 = s(1:l);s2 = s(l+1:L);
    % 第一台设备
    y1 = car(s(1),1) + car(s(1),3);
    fini(s(1)) = y1;
    for i = 2:l
        if y1 < car(s(i),1) %如果上一辆车的完成时间早于下辆车的到达时间
            t = car(s(i),1) - y1;
            y1 = car(s(i),1) + car(s(i),3);
            if t < 2
                y1 = y1 + (2-t);
            end
            fini(s(i)) = y1;
        else
            y1 = y1 + PD(car(s(i-1),2),car(s(i),2));
            y1 = y1 + car(s(i),3);
            fini(s(i)) = y1;
        end
    end
    
    % 第二台设备
    if l < L
        y2 = car(s(l+1),1) + car(s(l+1),3);
        fini(s(l+1)) = y2;
        for i = l+2:L
            if y2 < car(s(i),1) %如果上一辆车的完成时间早于下辆车的到达时间
                t = car(s(i),1) - y2;
                y2 = car(s(i),1) + car(s(i),3);
                if t < 2 && car(s(i),1) > 2
                    y2 = y2 + (2-t);
                end
                fini(s(i)) = y2;
            else
                y2 = y2 + PD(car(s(i-1),2),car(s(i),2));
                y2 = y2 + car(s(i),3);
                fini(s(i)) = y2;
            end
        end
    end  
    
    for i = 1:length(s1)
        s = s1;
        s(s >= s1(i)) = [];
        k(s1(i)) = sum(fini(s) > car(s1(i),1));
    end
    
    for i = 1:length(s2)
        s = s2;
        s(s >= s2(i)) = [];
        s(s >= i+l) = [];
        k(s2(i)) = sum(fini(s) > car(s2(i),1));
    end
end