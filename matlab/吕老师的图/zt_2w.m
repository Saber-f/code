clc;clear;
global flage
flage = true;
x = -4:0.1:4;y = x;
[X,Y] = meshgrid(x,y);

figure('Color',[1 1 1]);
set(gcf,'outerposition',get(0,'screensize'));% matlab窗口最大化

mux = [0:0.03:1.5,1.5:-0.05:-1.5,-1.5:0.05:0];
sgmx = [1:0.02:1.5,1.5:-0.02:0.5,0.5:0.02:1];
r = [0:0.02:0.5,0.5:-0.02:-0.5,-0.5:0.02:0];

Z = f(X,Y,0,0,1,1,r(1));
C = del2(Z);

for i = 1:length(mux)
    
    Z = f(X,Y,0,mux(i),1,1,0);
    %Z = f(X,Y,0,0,1,sgmx(i),0);
    %Z = f(X,Y,0,0,1,1,r(i));
    
    mesh(X,Y,Z,C,'FaceLighting','gouraud','LineWidth',1);hold on;mesh([0,0,;0,0],[0,0;0,0],[0.16 0.16;0.16 0.16]);legend(['Mu y = ',num2str(mux(i),'%.2f')]);hold off
    %mesh(X,Y,Z,C,'FaceLighting','gouraud','LineWidth',1);hold on;mesh([0,0,;0,0],[0,0;0,0],[0.35 0.35;0.35 0.35]);legend(['Sigma y = ',num2str(sgmx(i),'%.2f')]);hold off
    %mesh(X,Y,Z,C,'FaceLighting','gouraud','LineWidth',1);hold on;mesh([0,0,;0,0],[0,0;0,0],[0.2 0.2;0.2 0.2]);legend(['r = ',num2str(r(i),'%.2f')]);hold off
    
    generate_gif(0.1);
end