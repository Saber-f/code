function y = f1(x)
%����
    global PD car L
    y = 2;
    l = floor(x(end));
    [~,s] = sort(x(1:L));
    
    % ��һ̨�豸
    y1 = car(s(1),1) + car(s(1),3);
    for i = 2:l
        if y1 < car(s(i),1) %�����һ���������ʱ�������������ĵ���ʱ��
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
    
    % �ڶ�̨�豸
    if l < L
        y2 = car(s(l+1),1) + car(s(l+1),3);
        y = y + 2;
        for i = l+2:L
            if y2 < car(s(i),1) %�����һ���������ʱ�������������ĵ���ʱ��
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
    end
    g(y);
end