function [] = show(x)
    global D C W
    [~,s] = sort(x(1:size(D,1)));  %索引
    se = [x(size(D,1)+1:end),1];   %选设备
    is = [1,length(s)-1];          %初始范围
    y = 0;                         %风险感知度
    ti = 0;                        %完成时间
    for i = 1:size(C,1)
        h = is(1) + round(is(2) * se(i));
        yt = 0;                   %每台的完成时间
        fprintf('第%d台设备\n',i);
        fprintf('编号      0重1轻     开始治疗时间       治疗完成时间        风险感知度\n')
        [~,t] = sort(D(s(is(1):h),1));s(is(1):h) = s(t+is(1)-1);  %重伤优先
        for j = is(1):h           %s(j)为再第i台设备上的伤员
            yt = yt + W(i,j-is(1)+1); %准备时间
            t = yt;
            yt = yt + C(i,D(s(j),1)*2+1) + C(i,D(s(j),1)*2+2) * D(s(j),2);
            if D(s(j),1) == 0     %重伤患者
                t2 = ejs(yt);
                y = y + t2;
            elseif D(s(j),1) == 1  %轻商患者
                t2 = ejl(yt);
                y = y + t2;
            end
            fprintf('%3d         %d         %6.2fh           %6.2fh            %6.2f\n',s(j),D(s(j),1),t,yt,t2);
        end
        if yt > ti
            ti = yt;
        end
        is(2) = is(2) - (h-is(1)+1);
        is(1) = h + 1;
        if (is(1) > 360)
            break;
        end
    end
end

