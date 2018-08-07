clear
load snet2.mat;
A = load('allData.txt');


%% 参数设置
range = [3,10];     %打包任务数范围

%% 归一化
A(:,3) = 75;
tinput = tramnmx(A(:,1:3)',minI,maxI);

i = 1;k1 = 0.1,k2 = 0.1;bound = [65 85];n = 0;
while(1)
	tY = sim(snet,tramnmx(A(i,1:3)',minI,maxI));
	if(A(i,3) < bound(1))
		tY(1) = tY(1) + k1 * (bound(1) - A(i,3)).^2;
    end
    if(A(i,3) > bound(2))
		tY(2) = tY(2) + k2 * (A(i,3) - bound(2)).^2;
	end
	if tY(1) > tY(2)	
		if j ~= 1 && n ~= 0
            A(i,3) = A(i,3) + 0.5;
            i = i + 1;
            if i > length(A)
                break;
            end
        end
         A(i,3) = A(i,3) + 0.5;
		j = 1;		
    else	
		if j ~= 2 && n ~= 0
            i = i + 1;
            if i > length(A)
                break;
            end
        end
        A(i,3) = A(i,3) - 0.5;
		j = 2;
    end
    n = n + 1;
end



