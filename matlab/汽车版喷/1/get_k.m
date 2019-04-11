function k = get_k(x)
%不满意度
    global  A B 
    load num1 num2  num3
    k1=zeros(num1,1);
    k2=zeros(num2,1);
    k3=zeros(num3,1);
    
    k = zeros(L,1); %等待辆数
    
    fini1=k1;
    fini2=k2;
    fini3=k3;
    fini = k;       %记录完成时间
    
    l = floor(x(end));
    [~,s] = sort(x(1:L));
    s1 = s(1:l);s2 = s(l+1:L);
   
    rj=0;
    
    %% 第一台设备
    for i = 1:LA   
        if A(i,1)==1
            y1=rj+A(i,3);
        else 
            break
        end 
        rj=y1;
        p=i;
    end
    
   for j = 1:LB   
        if B(j,1)==1
            y1=rj+B(j,3);
        else 
            break
        end 
        fini1(j) = y1;
        rj=y1;
        q=j;
    end
    num1=p+q;
    
    %% 第二台设备
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
    
    for j = q+1:LB   
        if B(j,1)==2 
           y2=rj+B(j,3);  
        else
            break
        end
        fini2(j) = y2;
        rj=y2;
        q=j;
    end
    num2=p+q-num1;
    
   %% 第三台设备 
    rj=0;
    for i = p+1:LA   
        if A(i,1)==3
           y3=rj+A(i,3);    
        else
            continue
        end 
        rj=y3;
    end 
    
    for j = q+1:LB   
        if B(j,1)==3
           y3=rj+B(j,3);    
        else
            continue
        end 
        fini3(j) = y3;
        rj=y3;
    end
    num3=LA+LB-num1-num2;
  
    for i = 1:num1
        s=num1;
        s(s>=A(i))
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