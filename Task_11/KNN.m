function class = KNN(point, K, data, class_labels)
    distances = [];
    for n = 1 : length(data)
        distances(n) = [sqrt(sum((point - data(n,:)).^ 2))];
    end
    table_ = table(transpose(distances), transpose(class_labels));
    table_ = sortrows(table_);
    k_nearest = table_([1:K], :);
    class = mode(table2array(k_nearest(:,2)));
end