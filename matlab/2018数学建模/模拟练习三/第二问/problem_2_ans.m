global G path
G = [
    0	300	360	210	590	475	500	690
    300	0	380	270	230	285	200	390
    360	380	0	510	230	765	580	770
    210	270	510	0	470	265	450	640
    590	230	230	470	0	515	260	450
    475	285	765	265	515	0	460	650
    500	200	580	450	260	460	0	190
    690	390	760	640	450	650	190	0
    ]/(100/3); % �ڽӾ���(����ʱ��)

n = factorial(6); % ���п��ܵ��߷�����
path = [ones(n,1),perms(2:7),ones(n,1)*8]; % ���п��ܵ��߷�

c = [];
for i = 1:720
    if path(i,2) == 4
        c = [c,i];
    end
end
path(c,:) = [];
dist = zeros(1,size(path,1)); % ÿ���߷��ľ���
for i = 1:size(path,1) % ����ÿ���߷�����ʱ��
    for j = 1:7
        dist(i) = dist(i) + G(path(i,j),path(i,j+1));
    end
end
[~,z] = sort(dist);
path = path(z,:);dist = dist(z);
options = gaoptimset('PopulationSize',100,'Generations',60,'StallGenLimit',60); % �˿��裬����������
[a,b] = ga(@f,6,[],[],[],[],[1;10;20;30;20;30],[10;30;60;60;60;60],[],options);

n = floor(a(1));p = path(n,:); % ѡ��·��
fprintf("�����ʱ��::%f\n",-b);
fprintf("����ʱ��Ϊ::%f\n",dist(n));
fprintf("����ʱ::%fmin\n·��::",dist(n)-b);
for i = 1:8
    fprintf('%d',p(i))
    if i < 8
        fprintf(" -> ")
    else
        fprintf("\n")
    end
end
label = {'��ʯ','�οͷ�������','�����ƺ','ɭ��С�糡','��ͯ����������','��ͯϷˮ��','ʪ�ز����','ʪ����ҵ��'};
t = 12 * 60; % ��ǰʱ��
for i = 1:7
    fprintf(['��',label{p(i)},'����ʱ�� %02d:%02d:%.2f            '],floor(t/60),floor(mod(t,60)),60*mod(t,1))
    t = t + G(p(i),p(i+1));
    fprintf(['����',label{p(i+1)},'��ʱ�� %02d:%02d:%.2f\n'],floor(t/60),floor(mod(t,60)),60*mod(t,1))
    if p(i+1) == 4 %�����������С�糡
        if mod(t,30) > 1e-4
            t = t + (30-mod(t,30));
        end
        t = t + 30;
    elseif p(i+1) < 4
        t = t + a(p(i+1));
    elseif p(i+1) < 8
        t = t + a(p(i+1)-1);
    end
end