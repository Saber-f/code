n = 60;
A = int8(zeros(n));
for i = 1:n
    for j = i+1:n
        if rand < 0.3
            A(i,j) = 1;
            A(j,i) = 1;
        end
    end
end
tic
fb(A)
toc