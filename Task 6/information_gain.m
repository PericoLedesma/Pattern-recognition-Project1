function [gain] = information_gain(entropy, subsets, S, entropy_v)

    for j=1:size(entropy_v, 1)
        temp = 0;
        for i=1:size(subsets, 1)
    
            S_v = length(subsets{j, i}(:,1));
            temp = temp + (S_v/S) * entropy_v(j, i);
              
        end
        gain{j} = entropy - temp;
    end

end

