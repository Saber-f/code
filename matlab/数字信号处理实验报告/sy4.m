a = 2;
b = [2,-3,1];
y0 = [4,0];

n = 0:10;
x = 0.25.^n;

z = filtic(b,a,y0);
y = filter(b,a,x,z);

plot(n , x ,'R-', n, y, 'b--');
xlabel('n'); ylabel('(n)--y(n)');
legend('Input x' , 'Output y');
grid;