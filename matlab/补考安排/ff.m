function y = ff(x)
    global BX1 NUMC ZNP average_c average_s zy CN1 CN2 cn11 cn22;% Y;
    x = floor(x * 100 + 1);
        NP = zeros(NUMC,length(BX1));
        for i = 1 : length(x)
             NP(x(i),:) = NP(x(i),:) + BX1(i,:);
        end
        cn1 = sum(abs(sum(NP(:,CN1),2) - average_c));
        cn2 = sum(abs(sum(NP(:,CN2),2) - average_s));
        y = sum(sum(NP > 2)) * 10000 + sum(sum(NP == 2)) * 10 + (cn1 + cn2)/NUMC;
        if y < zy
           cn11 = cn1;
           cn22 = cn2;
           zy = y;
           ZNP = NP;
        end
        %Y= [Y,y];     
end

