function [b] = gol2(x)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    global k;
    options = gaoptimset('PopulationSize',floor(x(1)),'Generations',floor(x(2)),'StallGenLimit',floor(x(3)));
    [k,b] = ga(@gol,1,[],[],[],[],0,1,[],options);
end

