load W
x = W(50,2,replace({'HYTCB','CLTCB','PATCB','NGTCB','WYTCB','NUETB','GETCB'}));
%label = {'HYTCB','CLTCB','PATCB','NGTCB','WYTCB','NUETB','GETCB'};
label = {'水','煤炭','石油','天然气','风','核能','地热'};
pie(x)
legend(label);
title('California')