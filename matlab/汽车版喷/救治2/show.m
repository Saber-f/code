function [] = show(x)
    global D C W
    [~,s] = sort(x(1:size(D,1)));  %����
    se = [x(size(D,1)+1:end),1];   %ѡ�豸
    is = [1,length(s)-1];          %��ʼ��Χ
    y = 0;                         %���ո�֪��
    ti = 0;                        %���ʱ��
    for i = 1:size(C,1)
        h = is(1) + round(is(2) * se(i));
        yt = 0;                   %ÿ̨�����ʱ��
        fprintf('��%d̨�豸\n',i);
        fprintf('���      0��1��     ��ʼ����ʱ��       �������ʱ��        ���ո�֪��\n')
        [~,t] = sort(D(s(is(1):h),1));s(is(1):h) = s(t+is(1)-1);  %��������
        for j = is(1):h           %s(j)Ϊ�ٵ�į�豸�ϵ���Ա
            yt = yt + W(i,j-is(1)+1); %׼��ʱ��
            t = yt;
            yt = yt + C(i,D(s(j),1)*2+1) + C(i,D(s(j),1)*2+2) * D(s(j),2);
            if D(s(j),1) == 0     %���˻���
                t2 = ejs(yt);
                y = y + t2;
            elseif D(s(j),1) == 1  %���̻���
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

