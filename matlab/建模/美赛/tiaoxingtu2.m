clear;load W
R = replace({'RETCB','NGTCB','FFTCB','TETCB'});
D = W(:,:,R);
j = 1;
for i = 1:10:41
    D2(j,:,:) = sum(D(i:i+9,:,:));
    j = j+1;
end

plot(1960:2009,W(:,1,replace({'RETCB'}))


S(1) = {'Arizoxa'};
S(2) = {'Califorxia'};
S(3) = {'New Mexico'};
S(4) = {'Texas'};
c = categorical({'1960-1969','1970-1979','1980-1989','1990-1999','2000-2009'});
figure
for i = 1:4
    subplot(1,4,i)
    A1(1:5,1:4) = D2(:,i,:);
    A1(:,4) = A1(:,4) - sum(A1(:,[1,3]),2);
    A1(:,3) = A1(:,3) - A1(:,2);
    bar(c,A1,'stack')
    title(S(i))
    box off
    ylabel('Billion Btu')
end