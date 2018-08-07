clc,clear all

a = [
inf	12	19	25	32	38	46	55	67	82	100	inf	inf	inf	inf	inf	inf	inf	inf	inf
inf	inf	13	20	26	33	39	47	56	68	83	101	inf	inf	inf	inf	inf	inf	inf	inf
inf	inf	inf	14	21	27	34	40	48	57	69	84	102	inf	inf	inf	inf	inf	inf	inf
inf	inf	inf	inf	15	22	28	35	41	49	58	70	85	103	inf	inf	inf	inf	inf	inf
inf	inf	inf	inf	inf	17	24	30	37	43	51	60	72	87	105	inf	inf	inf	inf	inf
inf	inf	inf	inf	inf	inf	16	23	29	36	42	50	59	71	86	104	inf	inf	inf	inf
inf	inf	inf	inf	inf	inf	inf	16	23	29	36	42	50	59	71	86	104	inf	inf	inf
inf	inf	inf	inf	inf	inf	inf	inf	15	22	28	35	41	49	58	70	85	103	inf	inf
inf	inf	inf	inf	inf	inf	inf	inf	inf	16	23	29	36	42	50	59	71	86	104	inf
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	18	25	31	38	44	52	61	73	88	106
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	17	24	30	37	43	51	60	72	87
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	19	26	32	39	45	53	62	74
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	20	27	33	40	46	54	63
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	21	28	34	41	47	55
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	20	27	33	40	46
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	22	29	35	42
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	20	27	33
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	21	28
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	21
inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf	inf
];
n = input('请输入起点::');
for i = 1:length(a)
    d(i) =  inf;
    p{i} = n;
end
d(n) = 0;
D = [];

%% 迭代求解
for i = 1:length(d)
    for i = 1:length(a)
        l = d(n) + a(n,i);
        if d(i) > l
            d(i) = l;
            p{i} = p{n};
            p{i}(end+1) = i;
        end
    end
    D(length(D)+1) = n;
    t = d;
    t(D) = inf;
    [~,n] = min(t);
end

%% 打印结果
fprintf('距离   |   路径\n')
for i = 1:length(d)
    if d(i) == 0
        continue;
    end
    fprintf('%-4.2f  |  ',d(i))
    for j = 1:length(p{i})
        fprintf(' %d',p{i}(j))
    end
    fprintf('\n');
end
