function t(xdata1, ydata1, zdata1)
%CREATEFIGURE(XDATA1, YDATA1, ZDATA1)
%  XDATA1:  surface xdata
%  YDATA1:  surface ydata
%  ZDATA1:  surface zdata

%  由 MATLAB 于 20-May-2018 13:01:39 自动生成

% 创建 figure
figure1 = figure('Color',[1 1 1]);

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 创建 mesh
mesh(xdata1,ydata1,zdata1,'Parent',axes1);

% 取消以下行的注释以保留坐标轴的 Z 范围
zlim(axes1,[0 0.4]);
view(axes1,[-37.5 30]);
grid(axes1,'on');
