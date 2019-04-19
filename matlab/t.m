A = [
    12 11 2 3 32 3 4 5 6 1 9 8 9 7 7;
    1  1  2 2 3  4 4 5 5 6 6 7 8 9 5;
    2  6  3 5 4  1 6 3 4 2 5 1 2 5 9];
W = A(1,:);
DG = sparse(A(2,:),A(3,:),W);

UG = trilfsdg(DG + DG');
[ST,pred] = graphminspantree(UG);
view(biograph(ST,[],'ShowArrows','off','ShowWeights','on'))