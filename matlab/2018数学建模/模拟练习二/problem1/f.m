function [x,y,z] = f(sita1,sita2,sita3,sita4,R,r)
s1 = sin(sita1);
s2 = sin(sita2);
s3 = sin(sita3);
s4 = sin(sita4);
c1 = cos(sita1);
c2 = cos(sita2);
c3 = cos(sita3);
c4 = cos(sita4);
x = -R .* (c3 .* c4 .* s2 + s3 .* (c1 .* c2 .* c4 + s1 .* s4));
y = -r - R.*(c1 * c2 * c3 .* c4 - c4 .* s2 .* s3 + c3 * s1 .* s4);
z = R .* (c2 .* c4 .* s1 - c1 .* s4);

% x = R*cos(sita2).*sin(sita1);
% y = -R*(cos(sita3).*sin(sita2)+cos(sita1).*cos(sita2).*sin(sita3));
% z = -r-R*cos(sita1).*cos(sita2).*cos(sita3)+R*sin(sita2).*sin(sita3);
end