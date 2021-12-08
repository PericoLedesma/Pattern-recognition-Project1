clear;
clc;
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
%This is from testing pseudo-predicted values.
y_hat_test = [1, 1, 2, 1, 1, 1, 1, 2, 1, 1, ;2, 2, 2, 2, 2, 1, 1, 1, 1, 2; 1 2 1 1 1 1 1 2 1 2; 2 2 2 1 1 1 2 1 2 2; 1 1 1 1 2 1 2 1 1 1; 1 1 2 2 1 2 2 1 2 1 ;...
    1 2 2 1 2 1 2 1 1 1; 1 1 1 2 2 2 1 2 2 1; 1 2 1 2 1 1 1 1 1 2; 2 2 2 2 1 2 1 2 2 1; 1, 1, 2, 1, 1, 1, 1, 2, 1, 1, ;2, 2, 2, 2, 2, 1, 1, 1, 1, 2;...
    1 2 1 1 1 1 1 2 1 2; 2 2 2 1 1 1 2 1 2 2; 1 1 1 1 2 1 2 1 1 1; 1 1 2 2 1 2 2 1 2 1 ; 1 2 2 1 2 1 2 1 1 1; 1 1 1 2 2 2 1 2 2 1; 1 2 1 2 1 1 1 1 1 2; 2 2 2 2 1 2 1 2 2 1;];

y_hat_train = [1, 1, 2, 1, 1, 1, 1, 2, 1, 1, ;2, 2, 2, 2, 2, 1, 1, 1, 1, 2; 1 2 1 1 1 1 1 1 1 2; 2 2 2 1 1 1 2 1 2 2; 1 1 2 1 2 1 2 1 1 1; 1 1 2 2 1 2 2 1 2 1 ;...
    1 2 2 1 2 1 2 1 1 1; 1 1 1 2 2 2 1 2 2 1; 1 2 1 2 1 1 1 1 1 2; 2 2 2 2 1 1 1 2 2 1; 1, 1, 2, 1, 2, 1, 1, 2, 1, 1, ;2, 2, 2, 1, 1, 1, 1, 2, 1, 2;...
    1 2 1 1 1 1 1 2 1 2; 2 2 2 1 1 1 2 1 2 2; 1 1 1 1 2 1 2 1 1 1; 1 1 2 2 1 2 2 1 2 1 ; 1 2 2 1 2 1 2 1 1 1; 1 1 1 2 2 2 1 2 2 1; 1 2 1 2 1 1 2 1 1 2; 1 1 2 2 1 2 1 2 2 1;];


for k=1:folds
     test_cv = set(cv.training(k), :);
     train_cv = set(cv.test(k), :);
% Use LVQ from 7 to train.
% Use LVQ from 7 to test.
% y_hat_test are the predicted classes for training dataset
% y_hat_train are the predicted values for the training dataset
    error_train = 0;
    error_test = 0;
    for p=1:length(train_cv(:, 3))
        if train_cv(p, 3) ~= y_hat_test(p, k)
          error_test = error_test +1;
        end
        if train_cv(p, 3) ~= y_hat_train(p, k)
          error_train = error_train +1;
        end
    end
    
    errors_test{k} = error_test/length(train_cv(:, 3));
    errors_train{k} = error_train/length(train_cv(:, 3));
end

%% Calculate the mean classification error.
mean_train_error = mean(cell2mat(errors_train));
mean_testing_error = mean(cell2mat(errors_test));

%% Make the bar plots
figure(1)
bar(cell2mat(errors_train).*100)
figure(2)
bar([cell2mat(errors_train).*100; cell2mat(errors_test).*100].')
xlabel('# of Fold.')
ylabel('Error rate (%).')
legend('Training error', 'Testing error')