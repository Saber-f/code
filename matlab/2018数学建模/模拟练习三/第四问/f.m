function y = f(x)
    global G path T p dist speed T_b
    p = [path(floor(x(1)),:);path(floor(x(7)),:);path(floor(x(13)),:)]; % ѡ��·��
    t = [0,0,0]; % ����ʱ��
    T = zeros(3,12); % ��¼������뿪�м������ص��ʱ��
    T_b = zeros(3,7); % ��¼ÿ�β���ʱ��
    t_w = sum(x([2:6,8:12,14:18])) + (30+30)*3; % ����ʱ��
    for i = 1:6  % ����ʱ��
        for j = 1:3
            T_b(j,i) = G(p(j,i),p(j,i+1))/x(18 + (j-1)*7 + i);
            t(j) = t(j) + T_b(j,i); % ����ʱ������
            T(j,2*i-1) = t(j); %��j�����ţ������i�������ʱ��
            if p(j,i+1) == 4 %�����������С�糡
                if mod(t(j),30) > 0
                    t(j) = t(j) + (30-mod(t(j),30)); % �Ⱦ糡����
                end
                t(j) = t(j) + 30;
            elseif p(j,i+1) < 4
                t(j) = t(j) + x(p(j,i+1) + (j-1)*6);
            else
                t(j) = t(j) + x(p(j,i+1)+ (j-1)*6 - 1);
            end
            T(j,2*i) = t(j); %��j�����ţ��뿪��i�������ʱ��
        end
    end
    n = [2,2,2]; % ���������ŵ�ǰ����
    jd = zeros(1,7); % ��¼1-7���㵽��ʱ�п�
    T = [T,[inf;inf;inf]];
    while n(1) < 8 && n(2) < 8 && n(3) < 8 %���������໥Ӱ�죬����T
        [~,i] = min([T(1,2*n(1)-3),T(2,2*n(2)-3),T(3,2*n(3)-3)]);
        if T(i,2*n(i)-3) >= jd(p(i,n(i)))
            jd(p(i,n(i))) = T(i,2*n(i)-2);
        else
            T(i,2*n(i)-2:end) = T(i,2*n(i)-2:end) + (jd(p(i,n(i))) - T(i,2*n(i)-3));
            jd(p(i,n(i))) = T(i,2*n(i)-2);    
        end
        if p(i,n(i)) == 4 % ������˾糡
            if mod(T(i,2*n(i)-3),30) > 0
                T(i,2*n(i)-2) = T(i,2*n(i)-3) +  (30-mod(T(i,2*n(i)-3),30)) + 30;
            end
            T(i,2*n(i)-2:end) = T(i,2*n(i)-2:end) + (T(i,2*n(i)-3) + 30) - T(i,2*n(i)-2);
        end
        n(i) = n(i) + 1;
    end
    for i = 1:3
        T_b(i,7) = G(p(i,end-1),p(i,end))/x(18 + (i-1)*7 + 7);
        T(i,end) = T(i,end-1) + T_b(i,7);
        if T(i,end) > 300 % �ٵ���ҵ�ֳͷ�
            t_w = t_w - (T(i,end) - 300 + 1) * 1000;
        else
            t_w = t_w + 300 - T(i,end);
        end
        j = find(p(i,:) == 2);
        if T(i,2*j-2) > 240 % �οͷ������Ĺ���ǰ���뿪�ͷ�
            t_w = t_w - (T(i,2*j-2) - 240 + 1) * 1000;
        end
        % ����ƽ���ٶ�
        speed(i) = dist(floor(x((i-1)*6 + 1)))/sum(T_b(i,:));
        if speed(i) > 2 %���ٳͷ�
            t_w = t_w - 1000 - (speed(i)-2) * 1000;
        end
    end
    y = - t_w;
end