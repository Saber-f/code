global G N X
G = [
    0	300	360	210	590	475	500	690
    300	0	380	270	230	285	200	390
    360	380	0	510	230	765	580	770
    210	270	510	0	470	265	450	640
    590	230	230	470	0	515	260	450
    475	285	765	265	515	0	460	650
    500	200	580	450	260	460	0	190
    690	390	760	640	450	650	190	0
    ]; % 邻接矩阵

N = 100;
options = gaoptimset('PopulationSize',300,'Generations',100,'StallGenLimit',100); % 人口设为100，进化代数设为60
[a,b] = ga(@f,N,[],[],[],[],ones(N,1),8*ones(N,1)-1e-6,[],options);
for i = 1:N
    a(i) = floor(a(i));
end
a(find(a==1)) = [];
a
b
function y = f(x)
    global N G 
    y = 0;
    n = 1;
    for i = 1:N
        x(i) = floor(x(i));
        if x(i) > 1.5
            y = y + G(n,x(i));
            n = x(i);
        end
    end
    y = y + G(n,8);
    X = unique(x);
    X(find(X==1)) = [];
    y = y + (6-length(X))*10000;
end

