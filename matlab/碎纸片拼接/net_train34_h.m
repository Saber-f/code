%% ������Ϊ����3,4����ƴ��ѵ��������
% Read the data and process the training sample.
clear
wen = 3; % ��Ե���
test_ratio = 0.2; % ���ڲ��Եı���
XTrain = [];XTest = []; % ѵ����������������
TTrain = categorical({});TTest = categorical({}); % ѵ����ǩ�����Ա�ǩ

% ��������ͼƬ
for m = 0:208
    Img(:,:,m+1) = imread(['����3\',num2str(m,'%03d'),'.bmp']);
end

% ������ȷѵ��,��������
for m = 1:size(Img,3)
    for n = 1:size(Img,2) + 1 - 2 * wen
        if rand() < test_ratio
            XTest(:,:,:,size(TTest,1) + 1) = Img(:,n:n + 2 * wen - 1,m); % ����ѵ������
            TTest(size(TTest,1) + 1,1) = 'Y'; % ����ѵ��������ǩ
        else
            XTrain(:,:,:,size(TTrain,1) + 1) = Img(:,n:n + 2 * wen - 1,m); % ����ѵ������
            TTrain(size(TTrain,1) + 1,1) = 'Y'; % ����ѵ��������ǩ
        end
    end
end

% ������������ѵ��,��������
for m = 1:size(XTrain,4)
    while true
        m1 = randi([1,size(Img,3)]);m2 = randi([1,size(Img,3)]);
        n1 = randi([1,size(Img,2) + 1 - wen]);n2 = randi([1,size(Img,2) + 1 - wen]);
        if (m1 == m2 && n1 ~= n2) || (m1 ~= m2 && (n1 ~= size(Img,2) + 1 - wen || n2 ~= 1)) % ����������������ȷƴ��
            XTrain(:,:,:,size(TTrain,1) + 1) = [Img(:,n1:n1 - 1 + wen,m1), Img(:,n2:n2 - 1 + wen,m2)]; % ����ѵ������
            TTrain(size(TTrain,1) + 1,1) = 'N'; % ����ѵ��������ǩ
            break;
        end
    end
end
for m = 1:size(XTest,4)
    while true
        m1 = randi([1,size(Img,3)]);m2 = randi([1,size(Img,3)]);
        n1 = randi([1,size(Img,2) + 1 - wen]);n2 = randi([1,size(Img,2) + 1 - wen]);
        if (m1 == m2 && n1 ~= n2) || (m1 ~= m2 && (n1 ~= size(Img,2) + 1 - wen || n2 ~= 1)) % ����������������ȷƴ��
            XTest(:,:,:,size(TTest,1) + 1) = [Img(:,n1:n1 - 1 + wen,m1), Img(:,n2:n2 - 1 + wen,m2)]; % ����ѵ������
            TTest(size(TTest,1) + 1,1) = 'N'; % ����ѵ��������ǩ
            break;
        end
    end
end


%%
% Define the convolutional neural network architecture.
layers = [imageInputLayer([size(XTrain,1) size(XTrain,2) 1]);
          convolution2dLayer(5,16);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2);
          fullyConnectedLayer(2);  %��ǩ����
          softmaxLayer();
          classificationLayer();];
      
%%
% Set the options to default settings for the stochastic gradient descent
% with momentum.
options = trainingOptions('sgdm',...
      'InitialLearnRate',0.0001,...
      'MaxEpochs',8);

%%
% Train the network.
rng('default') % For reproducibility
net = trainNetwork(XTrain,TTrain,layers,options);

%%
% Run the trained network on a test set that was not used to train the
% network and predict the image labels (letters).
YTest = classify(net,XTest);

%%
% Calculate the accuracy.
accuracy = sum(YTest == TTest)/numel(TTest)
