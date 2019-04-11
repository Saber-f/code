% %% (1)
% x = [1,0,1,1];
% X4 = fft(x,4);
% X8 = fft(x,8);
% 
% subplot(2,2,1)
% stem(abs(X4))
% ylabel('幅度')
% title('4点DFT')
% 
% subplot(2,2,2)
% stem(angle(X4))
% ylabel('相位')
% title('4点DFT')
% 
% subplot(2,2,3)
% stem(abs(X8))
% ylabel('幅度')
% title('8点DFT')
% 
% subplot(2,2,4)
% stem(angle(X8))
% ylabel('相位')
% title('8点DFT')
% 
% %% (2)
% n = 0:10;
% x = 0.8.^n;
% subplot(2,1,1)
% stem(n,x)
% xlabel('n')
% ylabel('x(n)')
% title('x=0.8^n')
% 
% y = circshift(x,[0,-7]);
% subplot(2,1,2)
% stem(n,y)
% xlabel('n')
% ylabel('y(n)')
% title('y=x(n+7)R(n)')
% 
% 
% %% (3)
% %[1]
% x1 = [1,2,3];
% x2 = [4,3,2,1];
% y = conv(x1,x2);
% stem(y)
% ylabel('yn = x1*x2')
% title('线性卷积')

%[2]
x1 = [1,2,3];
x2 = [4,3,2,1];
for i = 4:8
    subplot(5,1,i-3)
    stem(cyclic_convolution(x1,x2,i))
    title([num2str(i),'点循环卷积'])
end

%循环卷积
function y = cyclic_convolution(x1,x2,n)
    if max(length(x1),length(x2)) > n
        error('n必须大于x1,x2中长的那个序列的长度')
    end
    
    %补零
    if length(x1) < n
        x1 = [x1,zeros(1,n-length(x1))];
    end
    if length(x2) < n
        x2 = [x2,zeros(1,n-length(x2))];
    end
    
    x1 = x1(n:-1:1);
    y = zeros(1,n);
    for i = 1:n
        x1 = circshift(x1,1);
        y(i) = sum(x1.*x2);    
    end
end