clear
%% 标记考两科
ANS = load('result.txt');
l1 = length(ANS);l2 = [];n3 = 0;                                            %l2为重复位置记录,n3重复次数
tANS = table(ANS(:,1),ANS(:,3));
[~,t] = unique(tANS);
if length(t) < l1                                                          %如果有重复项
   t2 = sort(t);
   for i = 1:l1
      if i ~= t2(i-n3)
         n3 = n3 + 1;
         l2 = [l2,i];
      end
   end
   for i = 1:length(ANS)
      for j = 1:n3
         if ANS(i,1) == ANS(l2(j),1) && ANS(i,3) == ANS(l2(j),3)
            ANS(i,4) = j; 
         end
      end
   end
end
clear tANS t2 t l2 l1 i j