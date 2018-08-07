%%自动元胞机
clc;clear;close all;
set(gcf,'DoubleBuff','on');
N = 256; % 设置状态矩阵元胞总数
t1 = 4; t2 = 6;
S = zeros(N); % S是状态矩阵
S(fix(29*N/59):fix(30*N/59),fix(29*N/59):fix(30*N/59)) = 1;
sum(S(:))
Ii = imshow(1-S,[]);
axis square; % 设置坐标轴属性
Sm = zeros(N+2); % 生成一个比状态矩阵多2行2列的矩阵

for k = 1:110
    Sm(2:end-1,2:end-1) = S; %把Sm中间NxN的部分复制为状态矩阵S
    M = Sm(1:end-2,2:end-1) + Sm(3:end,2:end-1) + Sm(2:end-1,1:end-2) + Sm(2:end-1,3:end);% 计算4近邻之和   
    S = mod(M,2); % 用模除得到下一时刻状态矩阵的数值
    set(Ii,'CData',1-S); % 跟新显示数据
    pause(0.2); % 暂停0.2秒
    if k == 90
        A = S;
    end
    if k == 108
        B = S;
    end
end
