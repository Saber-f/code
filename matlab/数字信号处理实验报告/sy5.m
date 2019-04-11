b = 1;
a = [1 -0.8];
subplot(2,2,1)
zplane(b,a)
title('零点分布图')

[H,w] = freqz(b,a);
subplot(2,2,2)
plot(w/pi,abs(H));
xlabel('\omega/\pi');
ylabel('|H(e^i^\omega)|')
title('幅频特性曲线')
subplot(2,2,[3,4])
plot(w/pi,angle(H))
xlabel('\omega/\pi')
ylabel('phi(\omega)')
title('相频特性曲线')

