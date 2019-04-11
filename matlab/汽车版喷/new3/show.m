function [] = show(x,y)
    global L car
    k = get_k(x);
    [~,s] = sort(x(1:L));
    l = floor(x(end));
    a1 = [car(s(1:l)',:),k(s(1:l))]
    a2 = [car(s(l+1:L)',:),k(s(l+1:L))]
    y
end