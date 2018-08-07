function [b] = gol2(x)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
    global k;
    options = gaoptimset('PopulationSize',floor(x(1)),'Generations',floor(x(2)),'StallGenLimit',floor(x(3)));
    [k,b] = ga(@gol,1,[],[],[],[],0,1,[],options);
end

