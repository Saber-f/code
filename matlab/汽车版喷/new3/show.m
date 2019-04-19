function [] = show(x,y)
    global L car
    k = get_k(x);
    [~,s] = sort(x(1:L));
    l = floor(x(end));
    format compact;
    Y = f33(x);
    a1 = [car(s(1:l)',:),k(s(1:l)),Y(1:l,:)];
    int32(a1)
    a2 = [car(s(l+1:L)',:),k(s(l+1:L)),Y(l+1:L,:)];
    
    fprintf('����ʱ�� ɫ�� ʵ�����ʱ�� Ԥ�����ʱ�� k(��Ҫ�ȴ�������) Ԥ�����ʱ�� ʵ�����ʱ�� ��֪��\n')
    int32(a2)
    
    fprintf('����ʱ�� ɫ�� ʵ�����ʱ�� Ԥ�����ʱ�� k(��Ҫ�ȴ�������) Ԥ�����ʱ�� ʵ�����ʱ�� ��֪��\n')
    y
end


function Y = f33(x)
%�������
    global PD car L
    Y = [];
    y = 0; %�ͻ��������
    l = floor(x(end));
    [~,s] = sort(x(1:L));
    s1 = s(1:l);s2 = s(l+1:L);
    % ��һ̨�豸
    y1 = car(s(1),1) + car(s(1),3);
    djp = con(s1,s2,s(1));
    y = y + ff(djp,y1);
    Y = [Y;djp,y1,ff(djp,y1)];
    for i = 2:l
        if y1 < car(s(i),1) %�����һ���������ʱ�������������ĵ���ʱ��
            t = car(s(i),1) - y1;
            y1 = car(s(i),1) + car(s(i),3);
            if t < 2
                y1 = y1 + (2-t);
            end
        else
            y1 = y1 + PD(car(s(i-1),2),car(s(i),2));
            y1 = y1 + car(s(i),3);
        end
        djp = con(s1,s2,s(i));  
        y = y + ff(djp,y1);
        Y = [Y;djp,y1,ff(djp,y1)];
    end
    
    % �ڶ�̨�豸
    if l < L
        y2 = car(s(l+1),1) + car(s(l+1),3);
        djp = con(s1,s2,s(l+1));
        y = y + ff(djp,y2);
        Y = [Y;djp,y2,ff(djp,y1\2)];
        for i = l+2:L
            if y2 < car(s(i),1) %�����һ���������ʱ�������������ĵ���ʱ��
                t = car(s(i),1) - y2;
                y2 = car(s(i),1) + car(s(i),3);
                if t < 2 && car(s(i),1) > 2
                    y2 = y2 + (2-t);
                end
            else
                y2 = y2 + PD(car(s(i-1),2),car(s(i),2));
                y2 = y2 + car(s(i),3);
            end
            djp = con(s1,s2,s(i));
            y = y + ff(djp,y2);
            Y = [Y;djp,y2,ff(djp,y2)];
        end
    end  
end

% ��ȡԤ�����ʱ��dj'
function y = con(s1,s2,i)
    global car PD
    
    % ȥ��i��֮ǰ�Ŀͻ�
    s1(car(s1,1)>= car(i,1)) = [];
    s2(car(s2,1)>= car(i,1)) = [];
    
    s1 = [s1,i];s2 = [s2,i];
    %1���豸
    flage = false;
    
    y1 = car(s1(1),1) + car(s1(1),3);
    if i ~= s1(1) && y1 > car(i,1) %�������ʱ������i������ʱ��
        y1 = y1 - car(s1(1),3);
        flage = true;
        y1 = y1 + car(s1(1),4);
    end
    
    for j = 2:length(s1)
        if y1 < car(s1(j),1) %�����һ���������ʱ�������������ĵ���ʱ��
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
        if ~flage && y1 > car(i,1) %�������ʱ������i������ʱ��
            y1 = y1 - car(s1(j),3);
            flage = true;
            y1 = y1 + car(s1(j),4);
        end
    end
    
    %2���豸
    flage = false;
    y2 = car(s2(1),1) + car(s2(1),3);
    if i ~= s2(1) && y2 > car(i,1) %�������ʱ������i������ʱ��
        y2 = y2 - car(s2(1),3);
        flage = true;
        y2 = y2 + car(s2(1),4);
    end
    
    for j = 2:length(s2)
        if y2 < car(s2(j),1) %�����һ���������ʱ�������������ĵ���ʱ��
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
        if ~flage && y2 > car(i,1) %�������ʱ������i������ʱ��
            y2 = y2 - car(s2(j),3);
            flage = true;
            y2 = y2 + car(s2(j),4);
        end 
    end 
    y = min([y1,y2]);
end

% ��֪����
function y = ff(djp,Cj)
    global o fai2;

    x = Cj - djp;
    %�ͷ�
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
    
    %�ͻ�   
    y = 0.4*y1 + 0.6*y2;
end

function k = get_k(x)
%�������
    global PD car L
    k = zeros(L,1); %�ȴ�����
    fini = k;       %��¼���ʱ��
    l = floor(x(end));
    [~,s] = sort(x(1:L));
    s1 = s(1:l);s2 = s(l+1:L);
    % ��һ̨�豸
    y1 = car(s(1),1) + car(s(1),3);
    fini(s(1)) = y1;
    for i = 2:l
        if y1 < car(s(i),1) %�����һ���������ʱ�������������ĵ���ʱ��
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
    
    % �ڶ�̨�豸
    if l < L
        y2 = car(s(l+1),1) + car(s(l+1),3);
        fini(s(l+1)) = y2;
        for i = l+2:L
            if y2 < car(s(i),1) %�����һ���������ʱ�������������ĵ���ʱ��
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