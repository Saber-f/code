load W
b = zeros(5,2);
b(1,1) = max(max(W(:,:,replace({'TETCB'}))));
b(1,2) = min(min(W(:,:,replace({'TETCB'}))));
b(2,1) = max(max(W(:,:,replace({'FFTCB'}))-W(:,:,replace({'NGTCB'}))));
b(2,2) = min(min(W(:,:,replace({'FFTCB'}))-W(:,:,replace({'NGTCB'}))));
b(3,1) = max(max(W(:,:,replace({'TEPRB'}))));
b(3,2) = min(min(W(:,:,replace({'TEPRB'}))));
b(4,1) = max(max(W(:,:,replace({'REPRB'}))));
b(4,2) = min(min(W(:,:,replace({'REPRB'}))));
b(5,1) = max(max(W(:,:,replace({'NGMPB'}))));
b(5,2) = min(min(W(:,:,replace({'NGMPB'}))));
b(:,1) = b(:,1) - b(:,2);
save b b

