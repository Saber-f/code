function y = f21(x)
%�޶���֪����������ʱ��
    global D C Y snum lnum W 
    [~,s] = sort(x(1:size(D,1)));  %����
    se = [x(size(D,1)+1:end),1];   %ѡ�豸
    is = [1,length(s)-1];          %��ʼ��Χ
    y = 0;                         %���ո�֪��
    ti = 0;                        %���ʱ��
    for i = 1:size(C,1)
        h = is(1) + round(is(2) * se(i));
        yt = 0;                   %ÿ̨�����ʱ��
        snum=[];
        lnum=[];
        for p=is(1):h 
            if D(s(p),1) == 0     %���˻���
                snum=[snum;s(p)];    %���е�����Ⱥ��
            elseif D(s(p),1) == 1
                lnum=[lnum;s(p)];    %���е�����Ⱥ��
            end
        end
       Ls=length(snum);
       Ll=length(lnum);
       
        for j = 1:Ls           %s(j)Ϊ�ڵ�į�豸�ϵ�����Ա
            yt = yt +W(i,j); %׼��ʱ��
            yt = yt + C(i,D(snum(j),1)+1) + C(i,D(snum(j),1)+2) * D(snum(j),2);
            y = y + ejs(yt);
        end
        
        for j = 1:Ll           %s(j)Ϊ�ڵ�į�豸�ϵ�����Ա
            yt = yt +W(i,j); %׼��ʱ��
            yt = yt + C(i,D(lnum(j),1)*2+1) + C(i,D(lnum(j),1)*2+2) * D(lnum(j),2);
            y = y + ejl(yt);
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
    if y > Y
        y = 10^5 + ti*10^5;
    else
        y = ti;
    end
end