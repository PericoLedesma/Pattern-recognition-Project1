clear;
close all;
clc;

dataset = ["small", "yellow" "Yes"; 
           "small", "yellow", "Yes";
           "small", "red", "No";
           "large", "red", "Yes";
           "small", "yellow", "Yes";
           "large", "yellow", "No";
           "small", "red", "No";
           "small", "yellow", "Yes"];

%% Initialize variables and calculate entropy of dataset using entropy() function.

Entropy_of_Labels = entropy(dataset);
ent_counter = 1;
sum_of_attribues = 0;
array = zeros();
sub = [];
subsets = {};

%% Calculate number of features
for j=1:size(dataset,2)-1
    sum_of_attribues = sum_of_attribues +...
                       sum(length(unique(dataset(:, j))));
end

%% For every feature in the dataset calculate entropy

for j=1:size(dataset,2)-1
    dat_counter = 1;
    for i=unique(dataset(:, j))'

% Create subsets necessary for calculating the entropy.
        rows = find(dataset(:, j) == i);
        sub = dataset(rows', :);
        subsets{j, dat_counter} = sub;
        array(ent_counter) = entropy(sub);
        ent_counter = ent_counter + 1;
        dat_counter = dat_counter +1; 
    end
end

%% Calculate Information gain for each feature.

array = reshape(array, [size(dataset, 2) - 1, size(dataset, 2) - 1]);

gain = information_gain(Entropy_of_Labels, subsets , size(dataset, 1), array);

%% Pick root node

[val, idx] = max(cell2mat(gain));

%% idx is the number of feature (column) from left to right that is the root node.
root_node_label = idx;