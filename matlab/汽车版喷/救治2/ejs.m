function y = ejs(x)
%����Ⱥ������Ⱥ��
    if x == 0
        y = 0;
    elseif x < 90
        y = 2.25*x^0.88;
    else
        y = 1.180092163535746e+02; %2.25*90^0.88
    end
end