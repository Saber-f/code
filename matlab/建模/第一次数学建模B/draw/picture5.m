RC = load('huiwei.txt'); %原始数据

figure
plot(RC(:,2),RC(:,1),'*g');
title('会员分布图','FontSize',14);
xlabel('经度','FontSize',12);
ylabel('纬度','FontSize',12);

text(113.7517900000,23.0206700000,'东莞市','FontSize',12);
text(113.1219200000,23.0218500000,'佛山市','FontSize',12);
text(113.2643600000,23.1290800000,'广州市','FontSize',12);
text(113.0561500000,23.6820100000,'清远市','FontSize',12);
text(114.0595600000,22.5428600000,'深圳市','FontSize',12);