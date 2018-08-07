clear 
load D
for i = 1:length(D)
   W(D(i,3)-1959,D(i,2),D(i,1)) = D(i,4);
end
