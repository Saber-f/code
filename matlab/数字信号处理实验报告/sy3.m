t = [ones(1,4),zeros(1,4)];
N = 20;
x = [];
for i = 1:N
    x = [x,t];
end
n = (0:length(x)-1) - N*4;
subplot(3,1,1)
stem(n,x)
ylabel('x(n)~')

dw = pi/1000;
w = -pi:dw:pi;
X = x*exp(-1i).^(n'*w);

subplot(3,1,2)
plot(w/pi,abs(X))
ylabel('·ù¶È')

subplot(3,1,3)
plot(w/pi,angle(X))
ylabel('ÏàÎ»')
