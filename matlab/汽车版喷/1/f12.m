function y = f12(x)
    %风险感知
   
     global A B N
     [~,sA] = sort(A(:,1));   %重伤群众排序
     [~,sB] = sort(B(:,1));   %轻伤群众排序
     A = A(sA,:);         
     B = B(sB,:);
     LA = length(A);          %重伤人数
     LB = length(B);          %轻伤人数
     rj =0;                   %第一个任务的提交时间
     
    
    %% 第一台设备 
    ys=0;                     %重伤群众风险感知初值
    for i = 1:LA              %所有重伤群众
        if A(i,1)==1          %在设备1上加工
            y1=rj+A(i,3);     %设备1上的第i个重伤群众实际完成时间
            Cjs=y1;           %将值赋给Cjs
            ys=ys+fs(Cjs);    %前i个重伤群众的风险感知和
        else 
            break             %不在设备1上加工就跳出循环
        end 
        rj=y1;                %上一个任务的完成时间即下一个任务的提交时间         
        p=i;                  %记下i的值
    end
    
    yl=0;
    for j = 1:LB              %所有轻伤群众
        if B(j,1)==1          %在设备2上加工
            y1=rj+B(j,3);     %设备1上的第i个轻伤群众实际完成时间
            Cjl=y1;
            yl=yl+fl(Cjl);    %重伤群众的风险感知总和+前j个轻伤群众风险感知和
        else 
            break
        end 
        rj=y1;
        q=j;                  %记下i的值
    end
    
    %% 第二台设备
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

   %% 第三台设备 
    rj=0;
    for i = p+1:LA   
        if A(i,1)==3
           y3=rj+A(i,3); 
           Cjs=y3;
           ys=ys+fs(Cjs);
        else
            continue
        end 
        rj=y3;
    end 
    for j = q+1:LB   
        if B(j,1)==3
           y3=rj+B(j,3);
           Cjl=y3;
           yl=yl+fl(Cjl);
        else
            continue
        end 
        rj=y3;
    end
    y=yl+ys;
    y1 = max([y1,y2,y3]);
    if y1>N
        y = y1 * 10000;
    end 
    
   
end

 %%重伤风险感知函数
function ys = fs(Cjs)
    T=120*0.75;   %重伤群众的最长等待时间，单位小时
    %重伤群众
    if Cjs >= T    %完成时间超过重伤群众的最长等待时间
        ys = 2.25*(90)^0.88;  %达到风险感知上限E2，且为定值
    else 
        ys = 2.25*(Cjs)^0.88;   %重伤群众的最长等待时间到达之前的心理风险感知函数
    end
end
 %%轻伤风险感知函数
function yl = fl(Cjl)
    global fai2
    %轻伤群众
    if Cjl<90   
        yl = -((90-Cjl)^0.88);
    elseif Cjl<432
        yl = fai2*(Cjl-90)^0.88;
    elseif Cjl==90
        yl=0;
    else
        yl=fai2*432^0.88;
    end
end
