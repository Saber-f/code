for i = 1 : length(JT)
   n = sum(JT(i,1:range(2)) > 0);
   N = N + n; 
   JT(i,m) = sum(A(JT(i,1:n),3));
   M = M + JT(i,m);
   JT(i,m+1) = floor(2 * JT(i,m)*((1/n)*(1-k3)+k3))/2;
end
