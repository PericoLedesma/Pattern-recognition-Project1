% Task 1: Pairwise correlation coeﬀicients
clear all
clc

% Firts element Height, Second element Age, Third element Weight(kg)

%Load file
array = importdata('task_1.mat');

size_array = size(array);

number_rows = size_array(1, 1);
number_columns = size_array(1, 2);



% % Correlacion = +-1 for validating the formulas
% 
%  array(1, 1) = -1;
%  array(1, 2) = 1;
% 
% for i = 2:number_rows
%       j = i -1;
%        
%       array(i, 1) = array(j, 1) - 1;
%       array(i, 2) = array(j, 2) + 1 ;
% end 
% 
% %Delete until here



%Display of all the features (1vs1)

figure;

for i = 1: number_columns

    %Columns 
    column1 = i;
    column2 = column1 +1;
    
    if column2 > 3
        column2 = 1;
    end 

    %Plot graph
    subplot(3,1,i);
    scatter(array(:,column1), array(:,column2),'x', 'red', 'LineWidth',2);
    xlim([(min(array(:,column1)) - 1) (max(array(:,column1)) + 1)])
    ylim([(min(array(:,column2)) - 1) (max(array(:,column2)) + 1)])

    %Title of axis
    label_column1 = 'Height(cm)';
    label_column2 = 'Age(years)';
    label_column3 = 'Weight(Kg)';

    %Axis labels X
    if column1 == 1
        xlabel(label_column1)
    end 
    if column1 == 2
        xlabel(label_column2)
    end 
    if column1 == 3
        xlabel(label_column3)
    end 

    %Axis labels Y
    if column2 == 1
        ylabel(label_column1)
    end 
    if column2 == 2
        ylabel(label_column2)
    end 
    if column2 == 3
        ylabel(label_column3)
    end 


    title('Array display')
        
 end


%  We calculate the mean of the features
 %avg = mean(array);
 avg = function_averague(array);

 
%Correlation
C = cov(array);

correlation = [0; 0; 0];

for i = 1: number_columns

    %Columns 
    column1 = i;
    column2 = column1 +1;
    
    if column2 > 3
        column2 = 1;
    end 
    
    a = C(column1, column1)*C(column2, column2);
    b = C(column1, column2)/sqrtm(a);
    c = [b; column1; column2];
    
    correlation = [correlation c];   
    
    %fprintf('The correlation between the column %d and column %d is: %f\n',column1,column2, correlation);
end 
   



%Max value 
  
correlation = abs(correlation);
correlation1 = max(correlation(1,:));

%Display the two features for which the correlation coeﬀicient is largest

for i = 1:length(correlation)
    if correlation(1,i) == correlation1
        column1 = correlation(2,i);
        column2 = correlation(3,i);
    end 
end 



%Title of column
if column1 == 1
    column_name1 = label_column1;
end 
if column1 == 2
    column_name1 = label_column2;
end 
if column1 == 3
    column_name1 = label_column3;
end 

if column2 == 1
    column_name2 = label_column1;
end 
if column2 == 2
    column_name2 = (label_column2);
end 
if column2 == 3
    column_name2 = (label_column3);
end 

fprintf('The two features for which the correlation coeﬀicient is largest are the feature %s(column %d) and the feature %s(column %d).\nThe coeficient is %f\n', column_name1,column1, column_name2,column2,  correlation1);

%Display of the plot A --> Max correlation


%Plot graph
figure;
subplot(2,1,1);
scatter(array(:,column1), array(:,column2),'x', 'red', 'LineWidth',2);
xlim([(min(array(:,column1)) - 1) (max(array(:,column1)) + 1)])
ylim([(min(array(:,column2)) - 1) (max(array(:,column2)) + 1)])

xlabel(column_name1)
ylabel(column_name2)

title('Plot A')


%Second largest correlation 

for i =1:length(correlation)
    if correlation(1,i)== correlation1
        correlation(1,i) = 0;
        i = length(correlation);
    end 
end

correlation2 = max(correlation(1,:));

%Display the two features for which the correlation coeﬀicient is largest

for i = 1:length(correlation)
    if correlation(1,i) == correlation2
        column1 = correlation(2,i);
        column2 = correlation(3,i);
    end 
end 


%Display of the plot B --> Second higher correlation

%Title of column
if column1 == 1
    column_name1 = label_column1;
end 
if column1 == 2
    column_name1 = label_column2;
end 
if column1 == 3
    column_name1 = label_column3;
end 

if column2 == 1
    column_name2 = label_column1;
end 
if column2 == 2
    column_name2 = (label_column2);
end 
if column2 == 3
    column_name2 = (label_column3);
end 

fprintf('The the two features for which the second largest correlation coeﬀicient are the feature %s(column %d) and the feature %s(column %d).\n The coeficient is: %f\n', column_name1,column1, column_name2,column2,  correlation2);

%Plot graph
%figure;
subplot(2,1,2);
scatter(array(:,column1), array(:,column2),'x', 'red', 'LineWidth',2);
xlim([(min(array(:,column1)) - 1) (max(array(:,column1)) + 1)])
ylim([(min(array(:,column2)) - 1) (max(array(:,column2)) + 1)])

xlabel(column_name1)
ylabel(column_name2)

title('Plot B')