clear 
%% 计算聚类中心
A = load('data1_1.txt');
A = A(:,[1 2 3]);
[~,s] = sort(A(:,3));
[~,ss] = sort(s);
A = A(s,:);
B(1) = 1;j = 1;
for i = 2 : length(A)
    if A(i,3) ~= A(i-1,3)
        j = j + 1;
        B(j) = B(j-1);
    end
    B(j) = B(j) + 1;
end

B = [0,B];C = zeros(length(B) - 1,2);

for i = 1:length(B) - 1
   C(i,:) = sum(A(B(i) + 1 : B(i + 1),[1,2]))/(B(i + 1) - B(i));
end


myans = zeros(length(A),1);
for i = 1 : length(A)
   myans(i) = sqrt(sum((A(i,[1,2]) - C(A(i,3),:)).^2)); 
end

myans = [A(:,[1,2]),myans];