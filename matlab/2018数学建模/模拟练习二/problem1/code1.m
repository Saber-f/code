clear
R = 1392000; % 地球与太阳之间的距离(km)
r = 6371; % 地球半径(km)
sita1 = 0:0.1:2*pi;%0:0.05:2*pi; % 自转角
sita2 = -(23+26/360)/180*pi; % 太阳直射维度
sita3 = (34.18)/180*pi; %当地维度

[x,y,z] = f(sita1,sita2,sita3,R,r);

t = [];
l = length(x);
for i = 1:length(z)
    if z(i) < 0
        t(end+1) = i;
    end
end

length(t)/l


% x(t) = [];
% y(t) = [];
% z(t) = [];

plot3(x,y,z,'*');


t = 1.2;
n = 500;
hold on;
plot3([linspace(min(x)*t,max(x),n);linspace(min(x),max(x),n)]*t,[linspace(0,0,n);linspace(max(y),max(y),n)]*t,[linspace(0,0,n);linspace(0,0,n)]*t,'g')
plot3([linspace(min(x)*t,min(x),n);linspace(max(x),max(x),n)]*t,[linspace(0,max(y),n);linspace(0,max(y),n)]*t,[linspace(0,0,n);linspace(0,0,n)]*t,'g')

x = [x;zeros(1,size(x,2))];
y = [y;zeros(1,size(y,2))];
z = [z;zeros(1,size(z,2))];
plot3(x,y,z)