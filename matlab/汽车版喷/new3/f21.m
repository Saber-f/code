function y = f12(x)
%排污
    global PD car L N
    y = 2;
    l = floor(x(end));
    [~,s] = sort(x(1:L));
    
    % 第一台设备
    y1 = car(s(1),1) + car(s(1),3);
    for i = 2:l
        if y1 < car(s(i),1) %如果上一辆车的完成时间早于下辆车的到达时间
            t = car(s(i),1) - y1;
            y1 = car(s(i),1) + car(s(i),3);
            if t < 2
                y1 = y1 + (2-t);
            end
            y = y + 2;
        else
            y1 = y1 + PD(car(s(i-1),2),car(s(i),2));
            y1 = y1 + car(s(i),3);
            y = y + PD(car(s(i-1),2),car(s(i),2));
        end
    end
    
    % 第二台设备
    if l < L
        y2 = car(s(l+1),1) + car(s(l+1),3);
        y = y + 2;
        for i = l+2:L
            if y2 < car(s(i),1) %如果上一辆车的完成时间早于下辆车的到达时间
                t = car(s(i),1) - y2;
                y2 = car(s(i),1) + car(s(i),3);
                if t < 2 && car(s(i),1) > 2
                    y2 = y2 + (2-t);
                end
                y = y + 2;
            else
                y2 = y2 + PD(car(s(i-1),2),car(s(i),2));
                y2 = y2 + car(s(i),3);
                y = y + PD(car(s(i-1),2),car(s(i),2));
            end
        end
        y1 = max(y1,y2);
        if y1 > N
            y = y1 * 10000;
        end  
    else
        if y1 > N
            y = y1 * 10000;
        end
    end
end