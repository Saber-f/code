function [] = show(x)
    global D C W snum lnum
    [~,s] = sort(x(1:size(D,1)));  %����
    se = [x(size(D,1)+1:end),1];   %ѡ�豸
    is = [1,length(s)-1];          %��ʼ��Χ
    y = 0;                         %���ո�֪��
    ti = 0;                        %���ʱ��
    for i = 1:size(C,1)
        h = is(1) + round(is(2) * se(i));
        yt = 0;   %ÿ̨�����ʱ��
        snum=[];
        lnum=[];
        fprintf('��%d̨�豸\n',i);
        fprintf('���      0��1��     ��ʼ����ʱ��       �������ʱ��        ���ո�֪��\n')
        t=0;
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
            yt = yt + W(i,j); %׼��ʱ��
            t = yt;
            yt = yt + C(i,D(snum(j),1)+1) + C(i,D(snum(j),1)+2) * D(snum(j),2);
            y = y + ejs(yt);
            fprintf('%3d         %d         %6.2fh           %6.2fh            %6.2f\n',snum(j),D(snum(j),1),t,yt,y);
       end
       
       for j = 1:Ll           %s(j)Ϊ�ڵ�į�豸�ϵ�����Ա
            yt = yt + W(i,j); %׼��ʱ��
            t = yt;
            yt = yt + C(i,D(lnum(j),1)*2+1) + C(i,D(lnum(j),1)*2+2) * D(lnum(j),2);
            y = y + ejl(yt);
            fprintf('%3d         %d         %6.2fh           %6.2fh            %6.2f\n',lnum(j),D(lnum(j),1),t,yt,ejl(yt));
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

