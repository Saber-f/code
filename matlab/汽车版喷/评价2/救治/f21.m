function y = f21(x)
%�޶���֪����������ʱ��
    global D C W T
    [~,s] = sort(x(1:size(D,1)));  %����
    se = [x(size(D,1)+1:end),1];   %ѡ�豸
    is = [1,length(s)-1];          %��ʼ��Χ
    y = 0;                         %���ո�֪��
    ti = 0;                        %���ʱ��
    for i = 1:size(C,1)
        h = is(1) + round(is(2) * se(i));
        yt = 0;                   %ÿ̨�����ʱ��
        for j = is(1):h           %s(j)Ϊ�ٵ�į�豸�ϵ���Ա
            yt = yt + W(i,j-is(1)+1); %׼��ʱ��
            yt = yt + C(i,D(s(j),1)*2+1) + C(i,D(s(j),1)*2+2) * D(s(j),2);
            if D(s(j),1) == 0     %���˻���
                y = y + ejs(yt);
            elseif D(s(j),1) == 1  %���̻���
                y = y + ejl(yt);
            end
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
    if y > T
        y = 10^5 + ti*10^5;
    else
        y = ti;
    end
end