clear,load W

R1 = replace({'TEPRB','TETCB'});
R2 = replace({'REPRB'});
R3 = replace({'FFTCB'});
R4 = replace({'NUETB'});
R5 = replace({'HYTCB'});
R6 = replace({'WYTCB'});

for i = 1:4
    %能源富余
    x(:,1,i) = W(:,i,R1(1)) - W(:,i,R1(2));
    
    %可再生能源的生产量
    x(:,2,i) = W(:,i,R2);
    
    %化石燃料总消费。
    x(:,3,i) = W(:,i,R3) * -1;
    
    %核能发电
    x(:,4,i) = W(:,i,R4);
    
    %水能发电
    x(:,5,i) = W(:,i,R5);
    
    %风能发电
    x(:,6,i) = W(:,i,R6);
    
    
end


%标准化
for i = 1:length(x(1,:,1))
    x(:,i,:) = (x(:,i,:) - min(min(x(:,i,:))))/(max(max(x(:,i,:))) - min(min(x(:,i,:))));
end


for i = 1:length(x(:,1,1))
    for j = 1:length(x(1,1,:))
        C(i,j) = sum(x(i,:,j));
    end
end

figure
plot(1960:2009,C)
S(1) = {'Arizoxa'};
S(2) = {'Califorxia'};
S(3) = {'New Mexico'};
S(4) = {'Texas'};
legend(S)