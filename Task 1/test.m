% Functions

clear all
clc


% Array definition
% array = importdata('task_1.mat');
% size_array = size(array);


array = [1 1;3 0;-1 -1];
% array = [1 1;-1 -1]

array = rand(12,4)





% Calculation

C = cov(array)
 

c = fcovariance(array)