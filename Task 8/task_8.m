clear; clc; close all;
%% Assign K-folds and importing data
folds = 10;
set1 = importdata("data_lvq_A.mat");
set2 = importdata("data_lvq_B.mat");

%% Creating label column and randomly merging two datasets into one.
set1(:, 3) = 1; %Label 1='A'
set2(:, 3) = 2; %Label 2='B'
set = cat(1, set1, set2);
rand = randperm(size(set, 1));
set = set(rand,:);

%% Use cvpartition built-in function to create random splits to the dataset.
cv = cvpartition(set(:,3), 'kfold', folds);

%% Train and test for every fold, while keeping the error in each fold.
errors_test = cell(1, folds);
errors_train = cell(1, folds);


%% FROM HERE ONE THE CODE IS COPIED.
%% Weight vector

weight_A = [2.12 3.95; 7.4 6]; % Label A prototype, point [x y]
weight_B = [5 5.4]; % Label B prototype


%Third colums is the category

a = length(weight_A(:,1));
category_A = zeros(a,1) + 1;
weight_A = [weight_A category_A];

a = length(weight_B(:,1));
category_B = zeros(a,1) + 2; %Category b = 2
weight_B = [weight_B category_B];


weight = [weight_A ; weight_B]

%Weight history for mapping %%%%% THIS Weight history A and B are stored
%already in the weight A and B before loop.

weight_history_A = [weight_A(1,1) weight_A(1,2)];

if length(weight_A(:,1)) > 1
    a = length(weight_A(:,1));
    for i = 2:a
        weight_history_A = [weight_history_A; weight_A(i,1) weight_A(i,1)];
    end
end


weight_history_B = [weight_B(1,1) weight_B(1,2)];

if length(weight_B(:,1)) > 1
    a = length(weight_B(:,1));
    for i = 2:a
        weight_history_B = [weight_history_B; weight_B(i,1) weight_B(i,1)];
    end
end

for k=1:folds
    train_cv = set(cv.training(k), :);
    test_cv = set(cv.test(k), :);
    %% Size of the dataset for the loops

    size_train_cv = size(train_cv);
    number_rows_train_cv = size_train_cv(1,1);
    size_test_cv = size(test_cv);
    number_rows_test_cv = size_test_cv(1,1);
    %% Parameters for the loop
    
    step = 0.01;
    
    epoch_limit = 50000;
    
    %% Loop with the calculations
    
    epoch = 1;
    
    E = 0; %number_rows_dataset;
    
    misclassified = [0 0];
    threshold_array = [0 0];
    
    fprintf('Inicialization of the iterations');
    
    a = length(weight_A(:,1))+length(weight_B(:,1));
    
    Distance = zeros (1,a);
    
    strop_criteria = 2;
    
    while  strop_criteria > 0.1
    
    % while epoch < epoch_limit
        for row = 1:number_rows_train_cv
            
            %% Euclidean distance from weight points to the select point
            
            for i=1:length(weight(:,1))
                Distance(i) = (weight(i,1)- train_cv(row,1))^2 + (weight(i,2)- train_cv(row,2))^2;
            end
            
            [val, idx] = min(Distance);
            
    %         fprintf('\nPoint: %f  %f',dataset(row,1),dataset(row,2))
    %         fprintf('\nWeights: %f  %f',weight(idx,1),weight(idx,2))
            
    
            if train_cv(row,3) == 1
                if weight(idx,3) == 1
                    
                    weight(idx,1) = weight(idx,1) + step * (train_cv(row,1) - weight(idx,1));
                    weight(idx,2) = weight(idx,2) + step * (train_cv(row,2) - weight(idx,2));
                    
                    weight_history_A = [weight_history_A; weight(idx,1) weight(idx,2)];
                    
                    
                end
                
                if weight(idx,3) == 2
                    
                    weight(idx,1) = weight(idx,1) - step * (train_cv(row,1) - weight(idx,1));
                    weight(idx,2) = weight(idx,2) - step * (train_cv(row,2) - weight(idx,2));
                    
                    weight_history_B = [weight_history_B; weight(idx,1) weight(idx,2)];
                    E = E +1;
                end
                
            elseif  train_cv(row,3) == 2
                if weight(idx,3) == 2
                    
                    weight(idx,1) = weight(idx,1) + step * (train_cv(row,1) - weight(idx,1));
                    weight(idx,2) = weight(idx,2) + step * (train_cv(row,2) - weight(idx,2));
                    
                    weight_history_B = [weight_history_B; weight(idx,1) weight(idx,2)];
                    
                    
                end
                if weight(idx,3) == 1
                    
                    weight(idx,1) = weight(idx,1) - step * (train_cv(row,1) - weight(idx,1));
                    weight(idx,2) = weight(idx,2) - step * (train_cv(row,2) - weight(idx,2));
                    
                    weight_history_A = [weight_history_A; weight(idx,1) weight(idx,2)];
                    E = E +1;
                end
            end
            
            %         fprintf('\nWeights after: %f  %f',weight(idx,1),weight(idx,2))
            
            threshold = E/number_rows_train_cv;
            
            misclassified = [misclassified; epoch E];
            
            threshold_array = [threshold_array; epoch threshold];
            
            epoch = epoch + 1
            
            strop_criteria = threshold_array (epoch,2)/ threshold_array (epoch -1,2);
            strop_criteria = strop_criteria - 1;
        end
        
        if epoch >= epoch_limit
            break
        end
        
               
        fprintf('\nError: %f',threshold);
        
    end
    
    fprintf('\nFinish iterations\n');
    format long
    disp(weight);
%% FOR HERE I CALCULATE THE MEAN TRAIN AND TESTING ERROR BASED ON IMPLEMENTED ALGORITHM
    error_train = 0;
    error_test = 0;
    for row = 1:number_rows_train_cv
            
            %% Euclidean distance from weight points to the select point
            
            for i=1:length(weight(:,1))
                Distance1(i) = (weight(i,1)- train_cv(row,1))^2 + (weight(i,2)- train_cv(row,2))^2;
            end
            
            [val_train(row), idx_train(row)] = min(Distance1);
            if idx_train(row) == 3
                idx_train(row) = 2 ;
            end
    end
    for row = 1:number_rows_test_cv

            %% Euclidean distance from weight points to the select point
            
            for i=1:length(weight(:,1))
                Distance2(i) = (weight(i,1)- test_cv(row,1))^2 + (weight(i,2)- test_cv(row,2))^2;
            end
            
            [val_test(row), idx_test(row)] = min(Distance2);
            if idx_test(row) == 3
                idx_test(row) = 2;
            end
    end

    for p=1:length(train_cv(:, 3))
         if train_cv(p, 3) ~= idx_train(p)
           error_train = error_train +1;
         end
     end
     for q=1:length(test_cv(:, 3))
         if test_cv(q, 3) ~= idx_test(q)
           error_test = error_test +1;
         end
    end
     
     errors_test{k} = error_test/length(test_cv(:, 3));
     errors_train{k} = error_train/length(train_cv(:, 3));
end

%% Calculate the mean classification error.
mean_train_error = mean(cell2mat(errors_train));
mean_testing_error = mean(cell2mat(errors_test));

%% Make the bar plots
figure(1)
bar([cell2mat(errors_train).*100; cell2mat(errors_test).*100].')
xlabel('# of Fold.')
ylabel('Error rate (%).')
legend('Training error', 'Testing error')
