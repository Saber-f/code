% ×îÖÕ½á¹û
global C_x CD CD_ xi MAX
load C_x;
load CD;
C_x = C_x / 3;
MAX = 43408.89657 * 0.88;

options = gaoptimset('PopulationSize',500,'Generations',100,'StallGenLimit',100);
[a,b] = ga(@f,30,[],[],[],[],CD(1:30,8).*0.5,CD(1:30,8).*1.5,[],options);

function y = f(x)
    global C_x CD CD_ xi MAX
    xi = CD_(:,8) + C_x(1,:)' .* (x' - CD(1:30,8));
    if min(xi) < 1 || max(xi) > 10 || sum(x) > MAX
        y = 0;
    else
        y = -x * xi;
    end
end