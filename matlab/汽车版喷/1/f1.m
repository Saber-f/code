function y = f1(x)
    %Ч��
    global A B num1 num2 num3  
     [~,sA] = sort(A(:,1));  
     [~,sB] = sort(B(:,1));  
     A = A(sA,:);
     B = B(sB,:);
     LA = length(A);
     LB = length(B);
     rj =0;                     %�����ύʱ���ֵ
   
   %% ��һ̨�豸 
   
   %����
    for i = 1:LA   
        if A(i,1)==1            %�����������豸1�Ͻ��� 
            y1=rj+A(i,3);       %����ǰi���������ʵ�����ʱ��
        else 
            break               %�������豸1�Ͻ��У�������ѭ�� 
        end 
        rj=y1;                  %ǰi���������ʵ�����ʱ��=��i+1��������ύʱ��
        p=i;                    %Ŀ���ǻ�ȡ���豸1����ɵ�����Ⱥ�����������
    end
    
    %����
    for j = 1:LB                
        if B(j,1)==1            %�����������豸1�Ͻ��� 
            y1=rj+B(j,3);       %����ǰi+j���������ʵ�����ʱ��
        else 
            break
        end 
        rj=y1;
        q=j;                    %Ŀ���ǻ�ȡ���豸1����ɵ�����Ⱥ�����������
    end
    num1=p+q;                   %�豸1��ִ����������
     
 %% �ڶ�̨�豸
 
    %����
    rj=0;
    for i = p+1:LA   
        if A(i,1)==2 
           y2=rj+A(i,3);  
        else
            break
        end
        rj=y2;
        p=i;
    end
    
    %����
    for j = q+1:LB   
        if B(j,1)==2 
           y2=rj+B(j,3);  
        else
            break
        end
        rj=y2;
        q=j;
    end
    num2=p+q-num1;              %�豸2��ִ����������
    
   %% ����̨�豸 
   
    %����
    rj=0;
    for i = p+1:LA   
        if A(i,1)==3
           y3=rj+A(i,3);    
        else
            break
        end 
        rj=y3;
    end 
    
    for j = q+1:LB   
        if B(j,1)==3
           y3=rj+B(j,3);    
        else
            break
        end 
        rj=y3;
    end
    num3=LA+LB-num1-num2;       %�豸3��ִ����������
    
    y=max([y1,y2,y3]);          %������
end