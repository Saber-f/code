clc
clear all
x(1)=0;
for j=1:5
    for i=1:300
        x(i+1)=0.5*x(i)+0.1*randn(1);
    end
    a(j,:)=x(100:300);
end
b=1:length(a);
c=0*b;

% plot(b,a(1,:),'b-',b,a(2,:),'g-',b,a(3,:),'c-',b,a(4,:),'k-',b,c,'r-')

a(5,:) = c;
clo = {'b-','g-','c-','k-','r-'};
gif(-1) %初始化
hold on
axis([1 200 -0.4 0.4])
for i = 1:5
    for j = 1:length(c)-1
        plot([b(j),b(j+1)],[a(i,j),a(i,j+1)],clo{i})
        gif(0.05); %时间间隔0.05s
    end
end

