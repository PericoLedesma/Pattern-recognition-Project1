%% Task 9: ROC
clc
clear all
close all

fprintf('Task 9: ROC\n');

%% Parameters of the normal distribution section

mean = [5 10]; % Mean of both normal distributions

x_criterion = [mean(1) 0 mean(2)]; %Here we select the threshold. Use 0 for intersection point

variance = [4 4]; % Variance of both normal distributions

x1 = -10;  % Lower limit 
x2 = 30;   % Up limit 

x = [x1:0.1:x2];

%% Introduction section: Normal distributions

% Normal distributions (PDFs)

fprintf('Normal distributions');

pd(1) = makedist('Normal', mean(1),variance(1));
pd(2) = makedist('Normal', mean(2),variance(2));

pdf_normal = pdf(pd(1),x);
pdf_normal = [pdf_normal ; pdf(pd(2),x)];

%Point where the two distributions cross

intersection_point_x = x1;

for i =1:length(pdf_normal(1,:))
    
    if pdf_normal(1,i) == pdf_normal(2,i)
        intersection_point_y = pdf_normal(1,i);
        break;
    end
    
    intersection_point_x = intersection_point_x + 0.1;
end

for i=1:length(x_criterion)
    if x_criterion(i) == 0
        x_criterion(i) = intersection_point_x;
    end
end

% Cumulative distribution function (CDFs)

cdf_normal(1,:) = cdf(pd(1),x);
cdf_normal(2,:) = cdf(pd(2),x);

%% DISPLAY

% Graph 1 --> Display PDF

titulo = sprintf('Normal distribution provided and Cumulative distribution function (μ1 = %d y μ2 = %d )', mean(1),mean(2));
% titulo  = convertStringsToChars(str)

f = figure('Name',titulo);

f.Position = [0 100 800 800];

subplot(2,1,1);

titulo = sprintf('N(μ1=%d)',mean(1));

plot(x,pdf_normal(1,:),'LineWidth',2,'DisplayName',titulo)

hold on

titulo = sprintf('N(μ2=%d)',mean(2));

plot(x,pdf_normal(2,:),'LineWidth',2,'DisplayName',titulo)

xlim([x1 x2])
ylim([0 0.15])

for i=1:length(x_criterion)
    titulo = sprintf('Threshold= %1.1f',x_criterion(i));
    xline(x_criterion(i),'--','DisplayName',titulo);
end

title('Normal density function')

hold on

% Display intersection point

plot(intersection_point_x,intersection_point_y,'redo', 'MarkerSize',20,'DisplayName','Intersection')  

legend
hold on



% Graph 2 -->  Display CDF

subplot(2,1,2);

titulo = sprintf('N(μ1=%d)',mean(1));

plot(x,cdf_normal(1,:),'LineWidth',2,'DisplayName',titulo)

hold on

titulo = sprintf('N(μ2=%d)',mean(2));

plot(x,cdf_normal(2,:),'LineWidth',2,'DisplayName',titulo)

xlim([x1 x2])
ylim([0 2])

% Display thresholds lines 

for i=1:length(x_criterion)
    
    titulo = sprintf('Threshold= %1.1f',x_criterion(i));
    xline(x_criterion(i),'--','DisplayName',titulo);
end

title('Cumulative distribution function')
legend

hold on



%% Calculation probability

probability_false_alarm = zeros(1,length(x_criterion));
probability_hit = zeros(1,length(x_criterion));

for i=1:length(x_criterion)
    
    low_point = x_criterion(i);
    up_point = 100; % We should use inf number, but for this exercise that we dont need accurate results I just use a big number
    
    points = [low_point up_point];
    
    
    % Area of the first normal distribution (false alarm (fa))
    
    % Cumulative distribution function (CDFs)
    
    probability(1,:) = normcdf(points,mean(1),variance(1));
    
    probability_false_alarm(i) =  probability(1,2) - probability(1,1);
    
    
    % Area of the second normal distribution (hit (fa))
    
    probability(2,:) = normcdf(points,mean(2),variance(2));
    
    probability_hit(i) = probability(2,2) - probability(2,1) - probability_false_alarm(i);
    
    
    figure(2);
    
    % Display probabilities
    
    subplot(3,1,i);
    
    X = categorical({'Hits(h)' 'False alarm'});
    X = reordercats(X,{'Hits(h)' 'False alarm'});
    
    y = [probability_hit(i) probability_false_alarm(i)];
    
    bar(X, y)
    
    ylim([0 1]);
    
    %  xlim([-10 51])
    %  ylim([0 1])
    
    titulo = sprintf('Probabilities for threshold = %1.1f',x_criterion(i));
    
    title(titulo)
    
    hold on
    
    %     disp(probability);
    
end

%% First part: ROCcurve

% Parameters--> Normals distributions 

close all

mean = [7 0.2677 1 2];

% Some display parameters

figure(3);

f2 = figure(3);
f2.Position = [800 800 400 400];
colorstring = 'kbgry';

%Iniciating the loop for each pair of normal distributions

for i=2:length(mean)
    
    x_criterion = [mean(1) 0 mean(2)]; %Here we select the threshold. Use 0 for intersection point
        
    variance = [4 4]; % Variance of both normal distributions
    
    x1 = -10;
    x2 = 25;
    
    x = [x1:0.1:x2];
      
     x_point = x1;
    
    % PDF
    
    pd(1) = makedist('Normal', mean(1),variance(1));
    pd(2) = makedist('Normal', mean(i),variance(2));
    
    clear cdf_normal
    cdf_normal(1,:) = cdf(pd(1),x);
    cdf_normal(2,:) = cdf(pd(2),x);
    
    ROC_array = zeros(length(cdf_normal(1,:))+1,2);
    
    for j = 1:(length(cdf_normal(1,:)))
        
        ROC_array (j+1,1) = cdf_normal(1,j);
        ROC_array (j+1,2) = cdf_normal(2,j);
        
    end
    
    % Discriminability value
    
    d = (mean(2) - mean(1))/sqrt(variance(1));
    
    % Display
    
    titulo = sprintf('μ1=5 & μ2=%d',mean(i));
    plot(ROC_array(:,1),ROC_array(:,2),'Color', colorstring(i), 'LineWidth',2,'DisplayName',titulo);
    legend
    hold on
    
    xt = 0.01;
    yt = 1.05 - i*0.035;
    
    str = "Discriminability (μ1=5 & μ2 = " + mean(i) + ") = " + d;
    
    text(xt,yt,str)
    hold on
    
    titulo = sprintf('ROC curve for differents normal distributions');
    title(titulo)
    
end

