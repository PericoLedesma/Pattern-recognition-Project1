function [clusters, mean_clusters] = kmeans(input, K, improved_flag)
    
    dimensions = length(input(1,:));
    distances = zeros(length(input),2);
    
    %Regular k-means cluster setup
    if improved_flag == false
        rand_idx = randperm(length(input),K);
        mean_clusters = input(rand_idx,:);
        

    %k-means++ cluster setup    
    else
        %Pick random prototype point from dataset
        rand_index = randi(size(input,1));
        prototypes = input(rand_index,:);

        distance_matrix = [];

        %compute D(x) for each data point x
        for x = 1:K-1
            prob_dist = [];
            distance_squared = [];
            for iterator = 1:length(input)
                dist = sqrt(sum((prototypes(x,:) - input(iterator,:)).^ 2));
                distance_squared = [distance_squared dist];
            end
            distance_matrix = [distance_matrix distance_squared'];
            
            for iterator = 1:length(input)
                prob_dist = [prob_dist min(distance_matrix(iterator,:))^2];
            end

            %assign a new prototype based on the squared distance
            prob_dist = prob_dist / sum(prob_dist);
            cum_sum_dist = cumsum(prob_dist);
            random_number = rand();
            for idx = 1:length(cum_sum_dist)
                if idx == 1
                    if random_number < cum_sum_dist(idx) && random_number >= 0
                        prototypes = [prototypes ; input(idx,:)];
                        break
                    end
                else
                    if random_number < cum_sum_dist(idx) && random_number >= cum_sum_dist(idx-1)
                        prototypes = [prototypes ; input(idx,:)];
                        break
                    end
                end
            end
        end
        mean_clusters = prototypes;
    end
    
    %move the center clutsers
    while true
        distances = zeros(length(input),3);
        old_avg = mean_clusters;
        for i = 1:length(input)
            test = zeros(K,2);
            for k = 1:length(mean_clusters)
                test(k,:) = [sqrt(sum((mean_clusters(k,:) - input(i,:)).^ 2)), k];
            end
            [val,idx1] = min(test(:,1));
            distances(i,:) = [i test(idx1,2) val];
        end
        for idx = 1:K
           mean_clusters(idx,:) = mean(input(distances(distances(:,2) == idx),:));
        end
        
        %stop condition
        if old_avg == mean_clusters
            break
        end
    end
    clusters = distances;
end