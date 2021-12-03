%% Task 9: ROC
clc
clear all
close all

%% Load of the data provided (structure 200×2 double])

data_structure = load('task_9_outcomes.mat');

%% Normal distributions:

% Parameters

x_criterion = 0;

mean = [2 10];
variance = [4 4];


x1 = -10;
x2 = 30;

x = [x1:0.1:x2];


% Normal distributions (PDFs)

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

if x_criterion ~= 0
    x_criterion = intersection_point_x;
end

% Cumulative distribution function (CDFs)

cdf_normal(1,:) = cdf(pd(1),x);
cdf_normal(2,:) = cdf(pd(2),x);

% Display PDF

f = figure('Name','Normal distribution provided and Cumulative distribution function');

f.Position = [100 100 800 800];

subplot(3,1,1);

plot(x,pdf_normal(1,:),'LineWidth',2,'DisplayName','N(μ=7)')

hold on

plot(x,pdf_normal(2,:),'LineWidth',2,'DisplayName','N(μ=10)')

xlim([x1 x2])
ylim([0 0.15])

xline(x_criterion,'--','DisplayName','Threshold');

title('Normal density function')

% legend('N(mean = 7', 'Intersection point')

hold on

% Display intersection point

plot(intersection_point_x,intersection_point_y,'redo', 'MarkerSize',20,'DisplayName','Intersection')  

legend
hold on

% Display CDF

subplot(3,1,2);
plot(x,cdf_normal(1,:),'LineWidth',2,'DisplayName','N(μ=7)')

hold on

plot(x,cdf_normal(2,:),'LineWidth',2,'DisplayName','N(μ=10)')

xlim([x1 x2])
ylim([0 2])

xline(x_criterion,'--','DisplayName','Threshold');


title('Cumulative distribution function')
legend

hold on



%% Calculation probability

low_point = x_criterion;
up_point = 1000; % We should use inf number, but for this exercise that we dont need accurate results I just use a big number

points = [low_point up_point];


% Area of the first normal distribution (false alarm (fa))

% Cumulative distribution function (CDFs)

probability(1,:) = normcdf(points,mean(1),variance(1));

probability_false_alarm =  probability(1,2) - probability(1,1);


% Area of the second normal distribution (hit (fa))

probability(2,:) = normcdf(points,mean(2),variance(2));

probability_hit = probability(2,2) - probability(2,1) - probability_false_alarm;



% Display probabilities

subplot(3,1,3); 

X = categorical({'Hits(h)' 'False alarm'});
X = reordercats(X,{'Hits(h)' 'False alarm'});

y = [probability_hit probability_false_alarm];

bar(X, y)

ylim([0 1]);

%  xlim([-10 51])
%  ylim([0 1])

title('Probabilities')

hold on

disp(probability);


%% Second part: ROC

% cdf_normal(1,:) 
% 
% 
% x1 = -10;
% x2 = 25;
% 
% x = [x1:0.1:x2];
% 
% cdf_normal(1,:) = cdf(pd(1),x);
% cdf_normal(2,:) = cdf(pd(2),x);
% 
