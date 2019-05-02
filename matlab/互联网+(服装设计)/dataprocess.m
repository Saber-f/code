D = importdata('data.txt');
data = D.data;
x = data(:,1);
y = data(:,2);
n = 8;
z = data(:,n);
D.textdata{n}