%% Second part: psychometrical experiment
array = importdata('task_9_outcomes.mat');

TP = 0; % the signal was presented and detected (hit)
FN = 0; % the signal was presented but the person failed to detect it
FP = 0; % the signal was not presented but the test person indicated to have detected (false alarm)
TN = 0; % the signal was not presented and the test person indicated that there was no signal


for i=1:length(array)
    
    %TP
    if array(i,1) == 1 & array(i,2) == 1
        TP = TP +1
    end
    
    %FN
    if array(i,1) == 1 & array(i,2) == 0
        FN = FN +1
    end
    
    %FP
    if array(i,1) == 0 & array(i,2) == 1
        FP = FP +1
    end
    
    %TN
    if array(i,1) == 0 & array(i,2) == 0
        TN = TN +1
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

hit = TP / total1;
fa = FN / total1;

point = [fa hit];

scatter(point(1),point(2),'*', 'red');
hold on

