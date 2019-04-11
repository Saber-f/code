train_data = importdata('zhengqi_train.txt');
test_data = importdata('zhengqi_test.txt');
X = train_data.data(:,1:end-1);
[c,s,l,t] = pca(X);
X_ = test_data.data;
X = X*c;X = X(:,1:15);
X_ = X_*c;X_ = X_(:,1:15);


X = [X,ones(length(X),1)];
Y = train_data.data(:,end);

[b,bint,r,rint,stats] = regress(Y,X);
sum(r.^2/length(Y))

X_ = [X_,ones(length(X_),1)];
Y_ = X_*b;