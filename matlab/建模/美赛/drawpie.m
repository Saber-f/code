load W
x = W(50,2,replace({'HYTCB','CLTCB','PATCB','NGTCB','WYTCB','NUETB','GETCB'}));
%label = {'HYTCB','CLTCB','PATCB','NGTCB','WYTCB','NUETB','GETCB'};
label = {'ˮ','ú̿','ʯ��','��Ȼ��','��','����','����'};
pie(x)
legend(label);
title('California')