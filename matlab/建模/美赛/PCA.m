load W;
for i = 1:length(W(:,1,1))
    for j = 1:length(W(1,1,:))
        D(i,j) = W(i,1,j);
    end
end
[~,a1,~,~,b1] = pca(D);

for i = 1:length(W(:,1,1))
    for j = 1:length(W(1,1,:))
        D(i,j) = W(i,2,j);
    end
end
[~,a2,~,~,b2] = pca(D);

for i = 1:length(W(:,1,1))
    for j = 1:length(W(1,1,:))
        D(i,j) = W(i,3,j);
    end
end
[~,a3,~,~,b3] = pca(D);

for i = 1:length(W(:,1,1))
    for j = 1:length(W(1,1,:))
        D(i,j) = W(i,4,j);
    end
end
[~,a4,~,~,b4] = pca(D);