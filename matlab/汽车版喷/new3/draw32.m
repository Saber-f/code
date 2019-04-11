clear
global PD car L o fai2 N
l = 0.1;
E1 = -120^0.88;
E2 = 2.25*360^0.88;
o = l*E2;
fai2 = -o/120^0.88+2.25;

PD = importdata('���۾���.txt');
load car
L = length(car);

%% �޲�����ȣ���������ʱ��
ans32 = zeros(10,2);
options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100);

N = 1300;
pn = 0;
while true
    [x,y,~,~,po] = ga(@f32,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    ans32(1,1) = N;ans32(1,2) = y;
    
    % ɸѡ��ʼ��Ⱥ
    init_p = get_p(po,N);
    if ~isempty(init_p)  
        x32(1,:) = x;
        break
    end
    pn = pn + 100
    options = optimoptions('ga','PopulationSize',600 + pn,'MaxGenerations',100 + pn);
end

for i = 2:10
    N = 1300 + 500*i;
    options = optimoptions('ga','PopulationSize',600,'MaxGenerations',100,'InitialPopulationMatrix',init_p);
    [x,y,~,~,po] = ga(@f32,L+1,[],[],[],[],ones(1,L+1),ones(1,L+1)*(L+1)-0.00001,[],options);
    % ɸѡ��ʼ��Ⱥ
    init_p = get_p(po,N);
    ans32(i,1) = N;ans32(i,2) = y;
    x32(i,:) = x; 
end

%%�淶��
% for i = 2:10
%     ans32(i,2) = min([ans32(i-1,2),ans32(i,2)]);
% end
plot(ans32(:,1),ans32(:,2));
ylabel('���ʱ��')
xlabel('�������')
save('ans32.mat','ans32','x32')