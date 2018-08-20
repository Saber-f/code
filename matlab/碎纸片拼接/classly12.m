% 适用于附件1,,2分类
clear
load NET1
Img = [];
for m = 0:18
    Img(:,:,m+1) = imread(['附件1\',num2str(m,'%03d'),'.bmp']);% 导入所有图片
end

an = zeros(19,19); %an(m,n)表示第m张图在左，第n张图在右，拼在一起合适的概率
for m = 1:19
    for n = 1:19
        [~, e] = classify(net, [Img(:,end-2:end,m),Img(:,1:3,n)]);
        if m ~= n &&  e(1) > e(2)
            an(m,n) = e(1);         
        end
    end
    fist(m) = sum(sum(Img(:,1:3,m)));zeros(19,1); %前三列灰度值和，用于寻找最左边的碎片
end

s = []; % 拼结果
[~, n] = max(fist); % 最左边随便角标
for i = 1:19
    s = [s,Img(:,:,n)];
    [~,n] = max(an(n,:));
end

imshow(s,[]) % 展示拼图结果