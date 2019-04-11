function [] = g(y)
global pnum ipn ggY iy
    if y < iy
        iy = y;
    end
    ipn = ipn + 1;
    if(ipn == pnum)
        ipn = 0;
        ggY = [ggY, iy];
    end
end

