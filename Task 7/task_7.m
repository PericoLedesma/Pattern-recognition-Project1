% Task 7: Learning Vector Quantization
clc
clear all

introduction = "Task 7: Learning Vector Quantization";
disp(introduction);


array_lvq_A = importdata('data_lvq_A.mat');
array_lvq_B = importdata('data_lvq_B.mat');


% %Display of features of each class/category
%
% feature_x = array_lvq_A(:,1);
% feature_y = array_lvq_A(:,2);
%
% scatter(feature_x,feature_y, 'x', 'red')
%
% hold on;
%
% feature_x2 = array_lvq_B(:,1);
% feature_y2 = array_lvq_B(:,2);
%
% scatter(feature_x2,feature_y2,'o', 'green')


% Creating dataset

size_A = size(array_lvq_A);
number_rows_A = size_A(1,1);

category_A = zeros(number_rows_A,1) + 1;

array_lvq_A = [array_lvq_A category_A ];

size_B = size(array_lvq_B);
number_rows_B = size_B(1,1);

category_B = zeros(number_rows_B,1) + 2;

array_lvq_B = [array_lvq_B category_B];

dataset = [array_lvq_A; array_lvq_B];




% %Pruebas

dataset = [ 5 4 2; 1 1 1;  2 1 1; 1 2 1; 3 1 1; 0 1 1; 5 5 2; 7 7 2; 7 6 2; 7 5 2; 5 6 2];

array_lvq_A = [1 1 ; 2 2; 2 1; 1 2; 3 1; 0 1];
array_lvq_B = [5 5 ; 7 7; 7 6; 7 5; 5 6];

%Fin de pruebas

size_dataset = size(dataset);
number_rows_dataset = size_dataset(1,1);



% %Display dataset

figure('Name','Dataset and the prototypes calculation');

feature_x = array_lvq_A(:,1);
feature_y = array_lvq_A(:,2);

scatter(feature_x,feature_y, 'x', 'red')

hold on;

feature_x2 = array_lvq_B(:,1);
feature_y2 = array_lvq_B(:,2);

scatter(feature_x2,feature_y2,'o', 'green')

xlim([(min(dataset(:,1)) - 1) (max(dataset(:,1)) + 1)])
ylim([(min(dataset(:,2)) - 1) (max(dataset(:,2)) + 1)])

hold on;



%Weight vector

weight = [dataset(1,1); dataset(1,2)];
weight2 = [dataset(2,1); dataset(2,2)];
weight = [weight weight2]

weight_history_1 = [dataset(1,1) dataset(1,2)];
weight_history_2 = [dataset(2,1) dataset(2,2)];


feature_x3 = weight(1,1);
feature_y3 = weight(2,1);
scatter(feature_x3,feature_y3,'x', 'red');

hold on;

feature_x3 = weight(1,2);
feature_y3 = weight(2,2);
scatter(feature_x3,feature_y3,'o', 'green');

hold on;

%Parameters

m = 2;

step = 0.01;

row = 3;

E = 50;

% Step 1




% Array misclassified training examples

epoch = 1;

misclassified = [0 0];

while epoch < 1000
    
    E = 0;
    
    for row = 3:number_rows_dataset
        
        Distance_1 = (weight(1,1)- dataset(row,1))^2 + (weight(2,1)- dataset(row,2))^2;
        Distance_2 = (weight(1,2)- dataset(row,1))^2 + (weight(2,2)- dataset(row,2))^2;
        
        if Distance_1 < Distance_2
            if dataset(row,3) == 1
                
                weight(1,1) = weight(1,1) + step * (dataset(row,1) - weight(1,1));
                weight(2,1) = weight(2,1) + step * (dataset(row,2) - weight(2,1));
                
                weight_history_1 = [weight_history_1; weight(1,1)  weight(2,1)];
                
            elseif  dataset(row,3) == 2
                
                weight(1,1) = weight(1,1) - step * (dataset(row,1) - weight(1,1));
                weight(2,1) = weight(2,1) - step * (dataset(row,2) - weight(2,1));
                
                weight_history_1 = [weight_history_1; weight(1,1)  weight(2,1)];
                
                E = E + 1;
            end
            
        elseif Distance_1 > Distance_2
            if dataset(row,3) == 2
                
                weight(1,2) = weight(1,2) + step * (dataset(row,1) - weight(1,2));
                weight(2,2) = weight(2,2) + step * (dataset(row,2) - weight(2,2));
                
                
                weight_history_2 = [weight_history_2; weight(1,2)  weight(2,2)];
                
            elseif dataset(row,3) == 1
                
                weight(1,2) = weight(1,2) - step * (dataset(row,1) - weight(1,2));
                weight(2,2) = weight(2,2) - step * (dataset(row,2) - weight(2,2));
                
                weight_history_2 = [weight_history_2; weight(1,2)  weight(2,2)];
                
                E = E + 1;
            end
        end
    end
    
    
    misclassified = [misclassified; epoch E];
    
    epoch = epoch + 1;
    
end


feature_x3 = weight_history_1(:,1);
feature_y3 = weight_history_1(:,2);
scatter(feature_x3,feature_y3,'x', 'blue');

hold on;

feature_x3 = weight_history_2(:,1);
feature_y3 = weight_history_2(:,2);
scatter(feature_x3,feature_y3,'.', 'blue');

hold on;



fprintf('\nFinito\n');
format long
disp(weight);


%Weight vector

feature_x3 = weight(1,1);
feature_y3 = weight(2,1);
scatter(feature_x3,feature_y3,'*', 'magenta');

feature_x3 = weight(1,2);
feature_y3 = weight(2,2);
scatter(feature_x3,feature_y3,'*', 'magenta');

hold on;

figure('Name','Misclasified points');
scatter(misclassified(:,1),misclassified(:,2), 10,'*', 'magenta');

hold on;

