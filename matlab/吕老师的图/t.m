function t(xdata1, ydata1, zdata1)
%CREATEFIGURE(XDATA1, YDATA1, ZDATA1)
%  XDATA1:  surface xdata
%  YDATA1:  surface ydata
%  ZDATA1:  surface zdata

%  �� MATLAB �� 20-May-2018 13:01:39 �Զ�����

% ���� figure
figure1 = figure('Color',[1 1 1]);

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ���� mesh
mesh(xdata1,ydata1,zdata1,'Parent',axes1);

% ȡ�������е�ע���Ա���������� Z ��Χ
zlim(axes1,[0 0.4]);
view(axes1,[-37.5 30]);
grid(axes1,'on');
