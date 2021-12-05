%% Task 9: ROC
clc
clear all
close all

fprintf('Task 9: ROC\n');

%% Parameters of the normal distribution section

x_criterion = 0; %Here we select the threshold. Use 0 for intersection point 

mean = [7 10]; % Mean of both normal distributions

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

if x_criterion == 0
    x_criterion = intersection_point_x;
end

% Cumulative distribution function (CDFs)

cdf_normal(1,:) = cdf(pd(1),x);
cdf_normal(2,:) = cdf(pd(2),x);

% Display PDF

f = figure('Name','Normal distribution provided and Cumulative distribution function');

f.Position = [0 100 800 800];

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
up_point = 100; % We should use inf number, but for this exercise that we dont need accurate results I just use a big number

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

% disp(probability);


%% First part: ROC

%ROCK curve

x1 = -10;
x2 = 25;

x = [x1:0.1:x2];

ROC_array = [0 0];
x_point = x1;


for i =1:length(pdf_normal(1,:))
    
   ROC_array = [ROC_array; cdf_normal(1,i) cdf_normal(2,i)];
       
end

% Discriminability value 

d = (mean(2) - mean(1))/sqrt(variance(1));

figure(2);

f2 = figure(2);
f2.Position = [800 800 400 400];

plot(ROC_array(:,1),ROC_array(:,2), 'red', 'LineWidth',2);

xt = 0.1;
yt = 0.9;
str = "Discriminability value = " + d;

text(xt,yt,str)

title('ROC curve')

%% Second part: psychometrical experiment

array = importdata('task_9_outcomes.mat');

TP = 0; % the signal was presented and detected (hit)
FN = 0; % the signal was presented but the person failed to detect it
FP = 0; % the signal was not presented but the test person indicated to have detected (false alarm)
TN = 0; % the signal was not presented and the test person indicated that there was no signal


for i=1:length(array)
    
    %TP
    if array(i,1) == 1 & array(i,2) == 1
        TP = TP +1;
    end
    
    %FN
    if array(i,1) == 1 & array(i,2) == 0
        FN = FN +1;
    end
    
    %FP
    if array(i,1) == 0 & array(i,2) == 1
        FP = FP +1;
    end
    
    %TN
    if array(i,1) == 0 & array(i,2) == 0
        TN = TN +1;
    end
    
end

fprintf('\nConfusion matrix');

total1 =(TP + FN);
total2 =(FP +TN);

total3 = TP +FP;
total4 = FN +TN;

Rows = ["Positive";"Negative";"Total"];
Predicted_positive = [TP;FP;total3];
Predicted_negative = [FN;TN; total4];
Total = [total1;total2; total2+total1];

Confusion_matrix = table(Rows,Predicted_positive,Predicted_negative,Total)
%  uit.Position = [100 200 400 400];