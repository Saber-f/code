function y = fb(A)

sumA = sum(A);[~,t1] = sort(-sumA);A = A(:,t1);A = A(t1,:);     %将A按每行每列按冲突程度从大到小排列

%寻找最大团（迷宫法）
cc = 1;b = A(1,:);mt = 0;  t = 1;t2 = 1;
while 1
   for i = t2:length(A)
      if b(t,i)
         t = t + 1;
         cc(t) = i;
         t2 = i + 1;
         b(t,:) = b(t-1,:)&A(i,:);         
         break;
      elseif i == length(A)  
         t2 = cc(t) + 1;
         cc(t) = [];
         t = t - 1;
         break;
      end
   end
   if t <= 0
       break
   end
   if ~sum(b(t,:))            %如果得到团
      if t > mt               %如果团更大
          mt = t;
          mbmc = cc;
          t = t - 1;
      end   
   end
end                                                       
y = mbmc;
end