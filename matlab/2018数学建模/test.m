%%�Զ�Ԫ����
clc;clear;close all;
set(gcf,'DoubleBuff','on');
N = 256; % ����״̬����Ԫ������
t1 = 4; t2 = 6;
S = zeros(N); % S��״̬����
S(fix(29*N/59):fix(30*N/59),fix(29*N/59):fix(30*N/59)) = 1;
sum(S(:))
Ii = imshow(1-S,[]);
axis square; % ��������������
Sm = zeros(N+2); % ����һ����״̬�����2��2�еľ���

for k = 1:110
    Sm(2:end-1,2:end-1) = S; %��Sm�м�NxN�Ĳ��ָ���Ϊ״̬����S
    M = Sm(1:end-2,2:end-1) + Sm(3:end,2:end-1) + Sm(2:end-1,1:end-2) + Sm(2:end-1,3:end);% ����4����֮��   
    S = mod(M,2); % ��ģ���õ���һʱ��״̬�������ֵ
    set(Ii,'CData',1-S); % ������ʾ����
    pause(0.2); % ��ͣ0.2��
    if k == 90
        A = S;
    end
    if k == 108
        B = S;
    end
end
