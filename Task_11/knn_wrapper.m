clear all;
load lab3_2.mat;

K=1;
samples=64;
data = lab3_2;
nr_of_classes = 4;
% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

for K = [1 3 5 7]
    % Sample the parameter space
    result=zeros(samples);
    for i=1:samples
      X=(i-1/2)/samples;
      for j=1:samples
        Y=(j-1/2)/samples;
        result(j,i) = KNN([X Y],K,data,class_labels);
      end
    end
    

% Show the results in a figure
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
plot(scaled_data(  1:50,   1),scaled_data(  1:50,2),'go');
plot(scaled_data(  51:100,   1),scaled_data(  51:100,2),'b*');
plot(scaled_data(  101:150,   1),scaled_data(  101:150,2),'mx');
plot(scaled_data(  151:200,1),scaled_data(151:200,2),'r+');
end

error_rate_list = zeros(1,13);
counter = 1;
for K = [1 3 5 7 9 11 13 15 17 19 21 23 25]
    accuracy = 0;
    for n = 1 : length(data)
        test_x = data(n,:);
        train_x = data;
        train_x(n,:) = [];
        test_y = class_labels(n);
        train_y = class_labels;
        train_y(n) = [];
   
        guess = KNN(test_x, K, train_x, train_y);
        if isequal(guess, test_y)
            accuracy = accuracy + 1;
        end
    end
    accuracy = accuracy / length(data);
    fprintf('K = %f, accuracy = %f\n', K, accuracy);
    error_rate_list(counter) = 1 - accuracy;
    counter = counter + 1;
end


x = [1 3 5 7 9 11 13 15 17 19 21 23 25];
y = error_rate_list;
xx = linspace(min(x),max(x),100);
yy = spline(x,y,xx);
figure,plot(x,y,'r+',xx,yy, 'black' ,'LineWidth',2)
xlabel('K value') 
ylabel('error rate')