% %单位脉冲信号
% n=-5:5;
% y=[zeros(1,5),1,zeros(1,5)];
% stem(n,y)
% axis([-5,5,0,2]);
% title('单位取样序列')

% %单位阶跃信号
% n=-5:5;
% y=[zeros(1,5),ones(1,6)];
% stem(n,y)
% axis([-5,5,0,2]);
% title('单位阶跃序列')

% %矩形序列
% n=-5:10;
% y=[zeros(1,5),ones(1,6),zeros(1,5)];
% stem(n,y)
% axis([-5,10,0,2]);
% title('矩形序列')

% %实指数序列
% a=1.5;
% n=0:10;
% y=a.^n;
% stem(n,y)
% axis([0,10,0,60]);
% title('实指数序列')

%正弦序列
w = 1/10;
n = -50:50;
y = sin(w*n);
stem(n,y)
title('正弦序列')