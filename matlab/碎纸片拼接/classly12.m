% �����ڸ���1,,2����
clear
load NET1
Img = [];
for m = 0:18
    Img(:,:,m+1) = imread(['����1\',num2str(m,'%03d'),'.bmp']);% ��������ͼƬ
end

an = zeros(19,19); %an(m,n)��ʾ��m��ͼ���󣬵�n��ͼ���ң�ƴ��һ����ʵĸ���
for m = 1:19
    for n = 1:19
        [~, e] = classify(net, [Img(:,end-2:end,m),Img(:,1:3,n)]);
        if m ~= n &&  e(1) > e(2)
            an(m,n) = e(1);         
        end
    end
    fist(m) = sum(sum(Img(:,1:3,m)));zeros(19,1); %ǰ���лҶ�ֵ�ͣ�����Ѱ������ߵ���Ƭ
end

s = []; % ƴ���
[~, n] = max(fist); % ��������Ǳ�
for i = 1:19
    s = [s,Img(:,:,n)];
    [~,n] = max(an(n,:));
end

imshow(s,[]) % չʾƴͼ���