% 适用于附件1,,2分类
clear;load NET3;global s s_index S Img
Img = [];num = 209; % 碎片数目

for m = 0:num-1
    Img(:,:,m+1) = imread(['附件3\',num2str(m,'%03d'),'.bmp']);% 导入所有图片
end

s_index = zeros(11,19);
s = int32(zeros(11*size(Img,1),19*size(Img,2)));
fist = zeros(4,num);
for m = 1:num
    fist(1,m) = sum(sum(Img(1:25,:,m)));
    fist(2,m) = sum(sum(Img(:,end-9:end,m)));
    fist(3,m) = sum(sum(Img(end-14:end,m)));
    fist(4,m) = sum(sum(Img(:,1:10,m)));
end

%% 填充
S = 1:num;
% 填充四角
[~, s_index(1,1)] = max(fist(1,:)+fist(4,:));
[~, s_index(1,19)] = max(fist(1,:)+fist(2,:));
[~, s_index(11,19)] = max(fist(2,:)+fist(3,:));
[~, s_index(11,1)] = max(fist(3,:)+fist(4,:));

set_s(); %更新

% 四边
% 上边
m = find(fist(1,S) == max(fist(1,S)));
for i = 2:18
    t = [];
    t2 = Img(:,:,s_index(1,i-1));
    for j = 1:length(m)
        [~,t3] = classify(net_h,[t2(:,end-2:end),Img(:,1:3,S(m(j)))]);
        t(end+1) = t3(1);
    end
    [~, t] = max(t);
    s_index(1,i) = S(m(t));
    m(t) = [];
end

set_s();

%% 
for i = 1:18
    s(1:10,(72*i-1):72*i) = 0;
end
imshow(s,[]) % 展示拼图结果


function [] = set_s()
    global s s_index S Img
    for m = 1:size(s_index,1)
        for n = 1:size(s_index,2)
            if s_index(m,n) > 0
                S(find(S == s_index(m,n))) = [];
                s(180*m-179:180*m,72*n-71:72*n) = Img(:,:,s_index(m,n));
            end
        end
    end
end