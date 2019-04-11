function y = f312_(x)
%不满意度
    global PD car L N M Yt
    yp = 2;%污染排放量
    l = floor(x(end));
    [~,s] = sort(x(1:L));
    s1 = s(1:l);s2 = s(l+1:L);
    % 第一台设备
    y1 = car(s(1),1) + car(s(1),3);
    djp = con(s1,s2,s(1));
    y = ff(djp,y1);
    for i = 2:l
        if y1 < car(s(i),1) %如果上一辆车的完成时间早于下辆车的到达时间
            t = car(s(i),1) - y1;
            y1 = car(s(i),1) + car(s(i),3);
            if t < 2
                y1 = y1 + (2-t);
            end
            yp = yp + 2;
        else
            y1 = y1 + PD(car(s(i-1),2),car(s(i),2));
            y1 = y1 + car(s(i),3);
            yp = yp + PD(car(s(i-1),2),car(s(i),2));
        end
        djp = con(s1,s2,s(i));  
        y = y + ff(djp,y1);
    end
    
    % 第二台设备
    if l < L
        y2 = car(s(l+1),1) + car(s(l+1),3);
        djp = con(s1,s2,s(l+1));
        y = y + ff(djp,y2);
        yp = yp + 2;
        for i = l+2:L
            if y2 < car(s(i),1) %如果上一辆车的完成时间早于下辆车的到达时间
                t = car(s(i),1) - y2;
                y2 = car(s(i),1) + car(s(i),3);
                if t < 2 && car(s(i),1) > 2
                    y2 = y2 + (2-t);
                end
                yp = yp + 2;
            else
                y2 = y2 + PD(car(s(i-1),2),car(s(i),2));
                y2 = y2 + car(s(i),3);
                yp = yp + PD(car(s(i-1),2),car(s(i),2));
            end
            djp = con(s1,s2,s(i));
            y = y + ff(djp,y2);
        end
        y1 = max(y1,y2);
    end
    if abs(y-N) > 50
        y1 = y1 + abs(y-N) * 10000;
    end
    if abs(yp-M) > 2
        y1 = y1 + abs(yp-M) * 1000000;
    end
    Yt = [y,yp,y1];
    y = y1;
end

% 获取预计完成时间dj'
function y = con(s1,s2,i)
    global car PD
   
    % 去除i来之前的客户
    s1(car(s1,1)>= car(i,1)) = [];
    s2(car(s2,1)>= car(i,1)) = [];
    
    s1 = [s1,i];s2 = [s2,i];
    %1号设备
    flage = false;
    
    y1 = car(s1(1),1) + car(s1(1),3);
    if y1 > car(i,1) %如果喷完时间晚于i车到达时间
        y1 = y1 - car(s1(1),3);
        flage = true;
        y1 = y1 + car(s1(1),4);
    end
    
    for j = 2:length(s1)
        if y1 < car(s1(j),1) %如果上一辆车的完成时间早于下辆车的到达时间
            t = car(s1(j),1) - y1;
            y1 = car(s1(j),1) + car(s1(j),3);
            if t < 2
                y1 = y1 + (2-t);
            end
        else
            y1 = y1 + PD(car(s1(j-1),2),car(s1(j),2));
            if flage
                y1 = y1 + car(s1(j),4);
            else
                y1 = y1 + car(s1(j),3);
            end
        end 
        if ~flage && y1 > car(i,1) %如果喷完时间晚于i车到达时间
            y1 = y1 - car(s1(j),3);
            flage = true;
            y1 = y1 + car(s1(j),4);
        end
    end
    
    %2号设备
    flage = false;
    y2 = car(s2(1),1) + car(s2(1),3);
    if y2 > car(i,1) %如果喷完时间晚于i车到达时间
        y2 = y2 - car(s2(1),3);
        flage = true;
        y2 = y2 + car(s2(1),4);
    end
    
    for j = 2:length(s2)
        if y2 < car(s2(j),1) %如果上一辆车的完成时间早于下辆车的到达时间
            t = car(s2(j),1) - y2;
            y2 = car(s2(j),1) + car(s2(j),3);
            if t < 2 && car(s2(j),1) > 2
                y2 = y2 + (2-t);
            end
        else
            y2 = y2 + PD(car(s2(j-1),2),car(s2(j),2));
            if flage
                y2 = y2 + car(s2(j),4);   
            else
                y2 = y2 + car(s2(j),3);
            end
        end
        if ~flage && y2 > car(i,1) %如果喷完时间晚于i车到达时间
            y2 = y2 - car(s2(j),3);
            flage = true;
            y2 = y2 + car(s2(j),4);
        end 
    end 
    y = min([y1,y2]);
end

% 感知函数
function y = ff(djp,Cj)
    global o fai2;

    x = Cj - djp;
    %客服
    if x < -120
        x = -120;
    end
    if x > 360
        y1 = 10000;
        y2 = 10000;
    elseif x < 0
        y1 = real(-(-x)^0.88);
        y2 = o;
    else
        y1 = 2.25*x^0.88;
        y2 = fai2*x^0.88+o;
    end
    
    %客户   
    y = floor(y1 + 2*y2);
end