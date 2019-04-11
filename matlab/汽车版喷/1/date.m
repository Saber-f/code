%% 生成数据
clear
N = 40;           %重伤人数
n = 320;          %轻伤及未受伤人数
A=[];             %重伤群众情况
B=[];             %轻伤及未受伤群众情况

for i = 1:N    
    fg = false;   %生成零矩阵  
    
    c = randi(3);  % 产生不同受伤群众
  
    if c<=1
         %耗时范围
         s=randi(2);   %产生[1h,2h]之间的随机准备时间
         m=1;
         t = s+2 + randi(3);   %us = [3h,5h];
        
     
    elseif c<=2
         s=randi(2);   %产生[1h,2h]之间的随机准备时间
         m=2;
         t = s+3 + randi(2); %us = [4h,5h];
        
     
    else
         s=randi(2);   %产生[1h,2h]之间的随机准备时间
         m=3;
         t = s+2 + randi(2); %us = [3h,4h];
         
    end
    %重伤群众情况
    A= [A;[m,s,t]];   %设备，准备时间，实际完成时间
end
 
 for j=1:n
      fg = false;   %生成零矩阵  
    
      c = randi(3);  % 产生不同受伤群众
      
      if c<=1
         %耗时范围
         s=randi(2);   %产生[1h,2h]之间的随机准备时间
         m=1;
         t = s+randi(3);   %us = [1h,3h];
         
      
      elseif c<=2
         s=randi(2);   %产生[1h,2h]之间的随机准备时间
         m=2;
         t = s+1 + randi(2); %us = [2h,3h];
        
      
      else
         s=randi(2);   %产生[1h,2h]之间的随机准备时间
         m=3;
         t =s+ randi(2); %us = [1h,2h];
        
      end
      %轻伤及未受伤群众情况
      B= [B;[m,s,t]];   %设备，准备时间，实际完成时间
 end
  
[~,sA] = sort(A(:,1));[~,sB] = sort(B(:,1));     %将群众按设备号进行排序
A = A(sA,:);B = B(sB,:);                         %得出结果

save ('A.mat','A');save ('B.mat','B')
