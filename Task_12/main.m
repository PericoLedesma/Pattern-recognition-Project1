clear all;
load checkerboard.mat;

data = checkerboard;
K=100;

error_regular = [];
error_optimized = [];

for iteration = 1:20
    disp(iteration)
    [clusters, means] = kmeans(data, K, false);
    [clusters1, means1] = kmeans(data, K, true);
    error_row = [];
    for k = 1:K
        error_row = [error_row mean(clusters(clusters(:,2) == k,3))];
    end
    error_regular = [error_regular ; error_row];

    error_row = [];
    for k = 1:K
        error_row = [error_row mean(clusters1(clusters1(:,2) == k,3))];
    end
    error_optimized = [error_optimized ; error_row];    
end

disp(mean(mean(error_regular,2)));
disp(mean(mean(error_optimized,2)));

disp(std(mean(error_regular,2)));
disp(std(mean(error_optimized,2)));

[h,p,ci,stats] = ttest2(mean(error_regular,2),mean(error_optimized,2),'Vartype','unequal');
disp(p)