%(1)����x(n)=0.8nu(n)����FT֮��ķ�Ƶ����λͼ���۲�ͼ���˽�x(ejw)��������
n = -10:10;
x = (0.8).^n .* [zeros(1,10),ones(1,11)];
dw = pi/100;
w = -4*pi:dw:4*pi;
X = x*exp(-1i).^(n'*w);
subplot(2,1,1);
plot(w/pi,abs(X))
ylabel('����|x|')
subplot(2,1,2)
plot(w/pi,angle(X)/pi)
ylabel('��λ')

%(2)����x(n)=ejwn�ĶԳ��ԣ�����ͼ�������֤
figure
subplot(2,1,1)
plot(w/pi,real(X))
ylabel('ʵ��')
subplot(2,1,2)
plot(w/pi,imag((X)))
ylabel('�鲿')
