function y = f2(x)
    %���ո�֪
    
     global A B num1 num2 num3
     y = 0;                   %����Ⱥ�ڷ��ո�֪��ֵ
     [~,sA] = sort(A(:,1));   %����Ⱥ������
     [~,sB] = sort(B(:,1));   %����Ⱥ������
     A = A(sA,:);         
     B = B(sB,:);
     LA = length(A);          %��������
     LB = length(B);          %��������
     rj =0;                   %��һ��������ύʱ��
     
    
    %% ��һ̨�豸 
    ys=0;                     %����Ⱥ�ڷ��ո�֪��ֵ
    for i = 1:LA              %��������Ⱥ��
        if A(i,1)==1          %���豸1�ϼӹ�
            y1=rj+A(i,3);     %�豸1�ϵ�ǰi������Ⱥ��ʵ�����ʱ��
            Cjs=y1;           %��ֵ����Cjs
            ys=ys+fs(Cjs);    %ǰi������Ⱥ�ڵķ��ո�֪��
        else 
            break             %�����豸1�ϼӹ�������ѭ��
        end 
        rj=y1;                %��һ����������ʱ�伴��һ��������ύʱ��         
        p=i;                  %����i��ֵ
    end
    
    yl=0;
    for j = 1:LB              %��������Ⱥ��
        if B(j,1)==1          %���豸2�ϼӹ�
            y1=rj+B(j,3);     %�豸1�ϵĵ�i������Ⱥ��ʵ�����ʱ��
            Cjl=y1;
            yl=yl+fl(Cjl);    %����Ⱥ�ڵķ��ո�֪�ܺ�+ǰj������Ⱥ�ڷ��ո�֪��
        else 
            break
        end 
        rj=y1;
        q=j;                  %����i��ֵ
    end
    num1=p+q;
    %% �ڶ�̨�豸
    rj=0;
    for i = p+1:LA   
        if A(i,1)==2 
           y2=rj+A(i,3); 
           Cjs=y2;
           ys=ys+fs(Cjs);
        else
            break
        end
        rj=y2;
        p=i;
    end
    for j = q+1:LB   
        if B(j,1)==2 
           y2=rj+B(j,3);  
           Cjl=y2;
           yl=yl+fl(Cjl);
        else
            break
        end
        rj=y2;
        q=j;
    end
    num2=p+q-num1;
   %% ����̨�豸 
    rj=0;
    for i = p+1:LA   
        if A(i,1)==3
           y3=rj+A(i,3); 
           Cjs=y3;
           ys=ys+fs(Cjs);
        else
            break
        end 
        rj=y3;
    end 
    for j = q+1:LB   
        if B(j,1)==3
           y3=rj+B(j,3);
           Cjl=y3;
           yl=yl+fl(Cjl);
        else
            break
        end 
        rj=y3;
    end
    num3=LA+LB-num1-num2;
    y=yl+ys;                  %���ո�֪�ܺ�
    
end

 %%���˷��ո�֪����
function ys = fs(Cjs)
    T=120*0.75;               %����Ⱥ�ڵ���ȴ�ʱ�䣬��λСʱ
    %����Ⱥ��
    if Cjs >= T               %���ʱ�䳬������Ⱥ�ڵ���ȴ�ʱ��
        ys = 2.25*(90)^0.88;  %�ﵽ���ո�֪����E2����Ϊ��ֵ
    else 
        ys = 2.25*(Cjs)^0.88; %����Ⱥ�ڵ���ȴ�ʱ�䵽��֮ǰ��������ո�֪����
    end
end
 %%���˷��ո�֪����
function yl = fl(Cjl)
    global fai2
    %����Ⱥ��
    if Cjl<90   
        yl = -((90-Cjl)^0.88);           %����������������
    elseif Cjl<432
        yl = fai2*(Cjl-90)^0.88;         %��һ������ʧ����
    elseif Cjl==90                       %ԭ��
        yl=0;
    else
        yl=fai2*432^0.88;                %���ո�֪������Ӱ��ĺ㶨ֵ
    end
end
