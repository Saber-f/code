function y = f2(C)
    d1 = C{1};d1_d = C{2}; b1 = C{3};b1_max = C{4};b2 = C{5};b2_max = C{6};Lp = C{7};Up = C{8};
    y = [];
    for i = 1:length(d1_d)
        up = Up; % ���޸���
        lp = Lp; % ���޸���
        y(i,1) = 0;
        for j = 2:7
            % ���ʱ���½�(��֤���ڹ涨ʱ�䵽С�糡)
            new_lp = lp(j);
            if j <= d1(end)
                new_lp = max(new_lp,d1_d(i) - (sum(up(d1)) - up(j)));
            end
            
            % ���ʱ���Ͻ�(��֤���ٵ�) 
            new_up = min(up(j),b2_max - (sum(lp(b2)) - lp(j))); % ��֤����17:00ǰ������ҵ��
            if j <= d1(end)
                new_up = min(new_up,b1_max - (sum(lp(b1)) - lp(j))); % ��֤����15:50ǰ����������
            end
            if j <= d1(end)
                new_up = min(new_up,d1_d(i) - (sum(lp(d1)) - lp(j)));
            end
            if j == b1(end) + 1 %���˷������ģ�Ҫ��16:00ǰ�뿪
                new_up = min(new_up,10 + b1_max - sum(y(i,1:j-1)));
            end
            if new_up < new_lp
                y(i,1) = -1;
                break
            end
            if j == d1(end) % �糡ǰһ���㣬����ʹ�պð�㵽�糡
                y(i,j) = d1_d(i) - sum(y(i,1:j-1));
            else
                y(i,j) = rand()*(new_up - new_lp) + new_lp;
            end
            lp(j) = y(i,j);up(j) = y(i,j);
            if j == 7
                y(i,8) = b2_max - sum(y(i,:)) + 30;
            end
        end
    end
    for i = size(y,1):-1:1
        if y(i,1) == -1
            y(i,:) = [];
        end
    end
    if isempty(y)
        y = [];
    end
end