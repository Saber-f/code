load C
f=fittype('a*x+b');    %引号里的是你的函数模型，默认是以x为自变量，其余为待定参数
xt = (1980:2009);

figure

fity=fit(xt',C(21:50,1),f);
hold on;plot(1980:2050,fity(1980:2050),'r')

fity=fit(xt',C(21:50,2),f);
hold on;plot(1980:2050,fity(1980:2050),'b')

fity=fit(xt',C(21:50,3),f);
hold on;plot(1980:2050,fity(1980:2050),'g')

fity=fit(xt',C(21:50,4),f);
hold on;plot(1980:2050,fity(1980:2050),'m')

hold on;plot(xt,C(21:50,1),'rx')
hold on;plot(xt,C(21:50,2),'bx')
hold on;plot(xt,C(21:50,3),'gx')
hold on;plot(xt,C(21:50,4),'mx')

S(1) = {'Arizoxa'};
S(2) = {'Califorxia'};
S(3) = {'New Mexico'};
S(4) = {'Texas'};
legend(S)