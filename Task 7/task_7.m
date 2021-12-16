%% Task 7: Learning Vector Quantization
clc
close all
clear all

introduction = "Task 7: Learning Vector Quantization";
disp(introduction);

%% Import data from file

array_lvq_A = importdata('data_lvq_A.mat');
array_lvq_B = importdata('data_lvq_B.mat');

%% Creating dataset with both datasets

size_A = size(array_lvq_A);
number_rows_A = size_A(1,1);

category_A = zeros(number_rows_A,1) + 1;

array_lvq_A = [array_lvq_A category_A ];

size_B = size(array_lvq_B);
number_rows_B = size_B(1,1);

category_B = zeros(number_rows_B,1) + 2;

array_lvq_B = [array_lvq_B category_B];

dataset = [array_lvq_A; array_lvq_B];


%% Test data
% 
% dataset = [ 5 4 2; 1 1 1;  2 1 1; 1 2 1; 3 1 1; 0 1 1; 5 5 2; 7 7 2; 7 6 2; 7 5 2; 5 6 2];
% 
% array_lvq_A = [1 1 ; 2 2; 2 1; 1 2; 3 1; 0 1];
% array_lvq_B = [5 5 ; 7 7; 7 6; 7 5; 5 6];

%End of test


%% Size of the dataset for the loops

size_dataset = size(dataset);
number_rows_dataset = size_dataset(1,1);

%% Display dataset

f = figure('Name','Dataset and the prototypes calculation');

f.Position = [0 100 1200 800];

feature_x = array_lvq_A(:,1);
feature_y = array_lvq_A(:,2);

scatter(feature_x,feature_y, '.', 'red') %Category A = red

hold on;

feature_x2 = array_lvq_B(:,1);
feature_y2 = array_lvq_B(:,2);

scatter(feature_x2,feature_y2,'.', 'blue') %Category B = blue

xlim([(min(dataset(:,1)) - 1) (max(dataset(:,1)) + 1)])
ylim([(min(dataset(:,2)) - 1) (max(dataset(:,2)) + 1)])

hold on;

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



% Displayed initial weights

for i = 1:length(weight_A(:,1))
    
    feature_display_X = weight_A(i,1);
    feature_display_Y = weight_A(i,1);
    scatter(feature_display_X,feature_display_Y,60,'*','red');
    
    hold on;
end

for i = 1:length(weight_B(:,1))
    
    feature_display_X = weight_B(i,1);
    feature_display_Y = weight_B(i,1);
    scatter(feature_display_X,feature_display_Y,60,'*','blue');
    
    hold on;
end


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
    for row = 1:number_rows_dataset
        
        %% Euclidean distance from weight points to the select point
        
        for i=1:length(weight(:,1))
            Distance(i) = (weight(i,1)- dataset(row,1))^2 + (weight(i,2)- dataset(row,2))^2;
        end
        
        [val, idx] = min(Distance);
        
%         fprintf('\nPoint: %f  %f',dataset(row,1),dataset(row,2))
%         fprintf('\nWeights: %f  %f',weight(idx,1),weight(idx,2))
        

        if dataset(row,3) == 1
            if weight(idx,3) == 1
                
                weight(idx,1) = weight(idx,1) + step * (dataset(row,1) - weight(idx,1));
                weight(idx,2) = weight(idx,2) + step * (dataset(row,2) - weight(idx,2));
                
                weight_history_A = [weight_history_A; weight(idx,1) weight(idx,2)];
                
                
            end
            
            if weight(idx,3) == 2
                
                weight(idx,1) = weight(idx,1) - step * (dataset(row,1) - weight(idx,1));
                weight(idx,2) = weight(idx,2) - step * (dataset(row,2) - weight(idx,2));
                
                weight_history_B = [weight_history_B; weight(idx,1) weight(idx,2)];
                E = E +1;
            end
            
        elseif  dataset(row,3) == 2
            if weight(idx,3) == 2
                
                weight(idx,1) = weight(idx,1) + step * (dataset(row,1) - weight(idx,1));
                weight(idx,2) = weight(idx,2) + step * (dataset(row,2) - weight(idx,2));
                
                weight_history_B = [weight_history_B; weight(idx,1) weight(idx,2)];
                
                
            end
            if weight(idx,3) == 1
                
                weight(idx,1) = weight(idx,1) - step * (dataset(row,1) - weight(idx,1));
                weight(idx,2) = weight(idx,2) - step * (dataset(row,2) - weight(idx,2));
                
                weight_history_A = [weight_history_A; weight(idx,1) weight(idx,2)];
                E = E +1;
            end
        end
        
        %         fprintf('\nWeights after: %f  %f',weight(idx,1),weight(idx,2))
        
        threshold = E/number_rows_dataset;
        
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


%% Display of the history of weights in all the epocchs

feature_x3 = weight_history_A(:,1);
feature_y3 = weight_history_A(:,2);
scatter(feature_x3,feature_y3,10,'x', 'red');

hold on;

feature_x3 = weight_history_B(:,1);
feature_y3 = weight_history_B(:,2);
scatter(feature_x3,feature_y3,10,'x', 'blue');

hold on;


%% Displayed final weights

for i = 1:length(weight(:,1))
    
    
    feature_display_X = weight(i,1);
    feature_display_Y = weight(i,2);
    scatter(feature_display_X,feature_display_Y,70,'p','magenta');
    
    hold on;
end


%% Misclasified points in each epoch

figure('Name','Misclasified points');

feature_display_X = misclassified(:,1);
feature_display_Y = misclassified(:,2);
scatter(feature_display_X,feature_display_Y,10,'*', 'magenta');

hold on;
