function y = fb(A)

sumA = sum(A);[~,t1] = sort(-sumA);A = A(:,t1);A = A(t1,:);     %��A��ÿ��ÿ�а���ͻ�̶ȴӴ�С����

%Ѱ������ţ��Թ�����
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
   if ~sum(b(t,:))            %����õ���
      if t > mt               %����Ÿ���
          mt = t;
          mbmc = cc;
          t = t - 1;
      end   
   end
end                                                       
y = mbmc;
end