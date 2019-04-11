%(1)绘制x(n)=0.8nu(n)经过FT之后的幅频—相位图，观察图像了解x(ejw)的周期性
n = -10:10;
x = (0.8).^n .* [zeros(1,10),ones(1,11)];
dw = pi/100;
w = -4*pi:dw:4*pi;
X = x*exp(-1i).^(n'*w);
subplot(2,1,1);
plot(w/pi,abs(X))
ylabel('幅度|x|')
subplot(2,1,2)
plot(w/pi,angle(X)/pi)
ylabel('相位')

%(2)分析x(n)=ejwn的对称性，给出图像进行验证
figure
subplot(2,1,1)
plot(w/pi,real(X))
ylabel('实部')
subplot(2,1,2)
plot(w/pi,imag((X)))
ylabel('虚部')
