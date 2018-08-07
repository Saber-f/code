X = load("test.txt");
X = X(:,[1,2]);
d = [];
for i = 1:length(X)
    if(X(i,2) > 114.6 || X(i,2) < 112.6 || X(i,1) > 23.8 || X(i,1) < 22.4)
        d = [d,i];
    end
end
X(d,:) = [];
opts = statset('Display','final');
[Idx,Ctrs,SumD,D] = kmeans(X,3,'Replicates',2,'Options',opts);
figure
hold on
plot(X(Idx == 1,2),X(Idx == 1,1),'b.');
plot(X(Idx == 2,2),X(Idx == 2,1),'g.');
plot(X(Idx == 3,2),X(Idx == 3,1),'r.');
