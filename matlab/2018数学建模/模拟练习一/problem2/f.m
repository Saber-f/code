function y = f(x)
    global C_x CD CD_ xi MAX
    xi = CD_(:,8) + C_x(1,:)' .* (x' - CD(1:30,8));
    if min(xi) < 1 || max(xi) > 10 || sum(x) > MAX
        y = 0;
    else
        y = -x * xi;
    end
end