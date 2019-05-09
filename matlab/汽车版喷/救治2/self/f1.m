function y = f1(x)
%完成时间
    global D C W snum lnum
    [~,s] = sort(x(1:size(D,1)));  %索引
    se = [x(size(D,1)+1:end),1];   %选设备
    is = [1,length(s)-1];          %初始范围
    y = 0;                         %完成时间
    for i = 1:size(C,1)
        h = is(1) + round(is(2) * se(i));
        yt = 0;
        snum=[];
        lnum=[];
        for p=is(1):h 
            if D(s(p),1) == 0     %重伤患者
                snum=[snum;p];    %所有的重伤群众
            elseif D(s(p),1) == 1
                lnum=[lnum;p];    %所有的轻伤群众
            end
        end
       Ls=length(snum);
       Ll=length(lnum);
       
        for j = 1:Ls           %s(j)为在第i台设备上的重伤员
            yt = yt + W(i,j); %准备时间
            yt = yt + C(i,D(snum(j),1)+1) + C(i,D(snum(j),1)+2) * D(snum(j),2); 
        end
        
        for j = 1:Ll           %s(j)为在第i台设备上的轻伤员
            yt = yt + W(i,j); %准备时间
            yt = yt + C(i,D(lnum(j),1)*2+1) + C(i,D(lnum(j),1)*2+2) * D(lnum(j),2);
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