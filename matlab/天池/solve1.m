clear
load('DATA.mat')
[R,P] = corrcoef([Y,X]); %���ϵ������
r = R(1,2:end);
p = P(1,2:end);
[~,s] = sort(-abs(r));
% for i = 1:38
%     subplot(5,8,i)
%     plot(X(:,s(i)),Y,'.') 
%     title(['x',num2str(s(i)),' r=',num2str(r(s(i))),' p=',num2str(p(s(i)))])
% end

X = X(:,s(1:10));   %ѡȡǰ16��
X_ = X_(:,s(1:10)); %ͬ��

%% ��ȡ���ɷ�
[coeff,~,~,~,explained] = pca(X);
X = X*coeff;X_ = X_*coeff;
X = X(:,1:5);X_ = X_(:,1:5);


%% �ع�
X = [X,ones(length(X),1)];

[b,bint,r,rint,stats] = regress(Y,X);
sum(r.^2/length(Y))

X_ = [X_,ones(length(X_),1)];
Y_ = X_*b;

