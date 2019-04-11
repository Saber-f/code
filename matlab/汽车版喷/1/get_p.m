function y = get_p(po,n)
    sc = zeros(size(po,1),1);
    for i = 1:size(po,1)
        sc(i) = f1(po(i,:));
    end
    y = po(sc <= n,:);
    if ~isempty(y) 
        y = y(randi([1,size(y,1)],[floor(length(po)*0.1),1]),:);
        %     y = [y;y(randi([1,size(y,1)],[size(po,1)-size(y,1),1]),:)];
        %     y = [];
    end
end