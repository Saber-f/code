x = linspace(30,40,50);
p = linspace(15.2,22.5,50);
y = linspace(0.3,0.5,50);

[p,x] = meshgrid(p,x);y=0.3;
z = x./(p.*(1+y))-1;
surf(p,x,z)