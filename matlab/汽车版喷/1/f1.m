function y = f1(x)
    %效率
    global A B num1 num2 num3  
     [~,sA] = sort(A(:,1));  
     [~,sB] = sort(B(:,1));  
     A = A(sA,:);
     B = B(sB,:);
     LA = length(A);
     LB = length(B);
     rj =0;                     %任务提交时间初值
   
   %% 第一台设备 
   
   %重伤
    for i = 1:LA   
        if A(i,1)==1            %重伤任务在设备1上进行 
            y1=rj+A(i,3);       %计算前i个任务的总实际完成时间
        else 
            break               %任务不在设备1上进行，则跳出循环 
        end 
        rj=y1;                  %前i个任务的总实际完成时间=第i+1个任务的提交时间
        p=i;                    %目的是获取在设备1上完成的重伤群众任务的总数
    end
    
    %轻伤
    for j = 1:LB                
        if B(j,1)==1            %轻伤任务在设备1上进行 
            y1=rj+B(j,3);       %计算前i+j个任务的总实际完成时间
        else 
            break
        end 
        rj=y1;
        q=j;                    %目的是获取在设备1上完成的轻伤群众任务的总数
    end
    num1=p+q;                   %设备1上执行任务总数
     
 %% 第二台设备
 
    %重伤
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
    
    %轻伤
    for j = q+1:LB   
        if B(j,1)==2 
           y2=rj+B(j,3);  
        else
            break
        end
        rj=y2;
        q=j;
    end
    num2=p+q-num1;              %设备2上执行任务总数
    
   %% 第三台设备 
   
    %重伤
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
    num3=LA+LB-num1-num2;       %设备3上执行任务总数
    
    y=max([y1,y2,y3]);          %制造期
end