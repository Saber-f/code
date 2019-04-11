T = 1;
Fs = 1/T;
wpz = 0.2;
wsz = 0.3;
wp = 2*tan(wpz*pi);
ws = 2*tan(wsz*pi/2);
rp = 1;rs = 15;

[N,wc] = buttord(wp,ws,rp,rs,'s');
[B,A] = butter(N,wc,'s');
fk = 0:1/512:1;
wk = 2*pi*fk;
Hk = freqs(B,A,wk);
subplot(1,2,1);
plot(fk,20*log10(abs(Hk)));grid on
xlabel('\omega/\pi')
ylabel('幅度(dB)')
axis([0,1,-100,5])
title('(b)');

[N,wc] = buttord(wpz,wsz,rp,rs);
[Bz,Az] = butter(N,wc);
wk = 0:pi/512:pi;
Hz = freqz(Bz,Az,wk);
subplot(1,2,2)
plot(wk/pi,20*log10(abs(Hz)));grid on
xlabel('\omega/\pi')
ylabel('幅度(dB)')
axis([0,1,-100,5])
title('(b)');

%% (2)
wp = 0.2*pi;
ws = 0.3*pi;
Rp = 1;
As = 15;
T = 1;
Fs = 1/T;
Omgp = (2/T)*tan(wp/2);
Omgs = (2/T)*tan(ws/2);
[m,Omgc] = buttord(Omgp,Omgs,Rp,As,'s');
[ba1,aa1] = butter(m,Omgc,'s');
[bd,ad] = bilinear(ba1,aa1,Fs);
[H,w] = freqz(bd,ad);
x = [-4,-2,0,-4,-6,-4,-2,-4,-6,-6,-4,-4,-6,-6,-2,6,12,8,0,-16,...
-38,-60,-84,-90,-66,-32,-4,-2,-4,8,12,12,10,6,6,6,4,0,0,0,...
0,0,-2,-4,0,0,0,-2,-2,0,0,-2,-2,-2,-2,0];
figure(1)
subplot(2,1,1)
plot(w/pi,abs(H))
title('幅频响应')

subplot(2,1,2)
plot(w/pi,angle(H)/pi)
title('相位相应')


%% 
figure(2)
subplot(2,1,1)
stem(x)
title('心电图信号采样序列x(n)')
xlabel('n')
ylabel('x(n)')

y = filter(bd,ad,x);
subplot(2,1,2)
stem(y)
title('滤波后的心电图')
xlabel('n')
ylabel('x(n)')


%%
figure(3)
N = 1024;
n = 0:N/2-1;
Xk = fft(x,N);
AXk = abs(Xk(1:N/2));
f = (0:N/2-1)*Fs/N;
f = f/Fs;
subplot(2,1,1)
plot(f,AXk)
title('x(n)的频谱')
xlabel('f')
ylabel('|X(k)|')

Yk = fft(y,N);
AYk = abs(Yk(1:N/2));
subplot(2,1,2)
plot(f,AYk)
title('y(n)的频谱')
xlabel('f')
ylabel('|Y(K)|')