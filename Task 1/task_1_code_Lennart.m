% load_file = load("Assignment1-files/Task_1/task_1.mat");
matrix = importdata('task_1.mat');


% matrix = load_file.lab1_1;
correlation_coeff_1_2 = covariance(matrix(1:24, 1), matrix(1:24, 2)) / sqrt(covariance(matrix(1:24, 1), matrix(1:24, 1)) * covariance(matrix(1:24, 1), matrix(1:24, 1)));
correlation_coeff_1_3 = covariance(matrix(1:24, 1), matrix(1:24, 3)) / sqrt(covariance(matrix(1:24, 1), matrix(1:24, 1)) * covariance(matrix(1:24, 3), matrix(1:24, 3)));
correlation_coeff_2_3 = covariance(matrix(1:24, 2), matrix(1:24, 3)) / sqrt(covariance(matrix(1:24, 2), matrix(1:24, 2)) * covariance(matrix(1:24, 3), matrix(1:24, 3)));

disp(correlation_coeff_1_2)
disp(correlation_coeff_1_3)
disp(correlation_coeff_2_3)

figure;

subplot(1,2,1)
scatter(matrix(1:24, 1),matrix(1:24, 3), '+', 'black', 'LineWidth',2);
xlabel('length (cm)');
ylabel ('weight (kg)');
title('correlation coefficient: ', correlation_coeff_1_3)

subplot(1,2,2)
scatter(matrix(1:24, 2),matrix(1:24, 3), 'x', 'r', 'LineWidth',2);
ylabel('age (cm)');
xlabel ('weight (kg)');
title('correlation coefficient: ', correlation_coeff_2_3)

function covar = covariance(x,y)
    x_bar = mean(x);
    y_bar = mean(y);
    covar = 0;
    for n = 1 : length(x)
        covar = covar + (x(n) - x_bar) * (y(n) - y_bar);
    end
    covar = covar / (length(x) - 1);
end

