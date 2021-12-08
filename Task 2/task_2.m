clear;
clc;
close all;

%% Create list for random picking people

list_of_people = strings(1, 20);
for i=1:20
list_of_people(i) = sprintf('person%02d.mat', i);
end

%% Task_2.1 Calculate the Hamming distance on two random rows from one(a) and two(b) random subjects.
for i=1:1000
    
    % First generate two random subjects.
    people = randi([1,20], 1, 2);
    sub1 = importdata(sprintf('person%02d.mat', people(1)));
    sub2 = importdata(sprintf('person%02d.mat', people(2)));

    %Pick random rows from two subjects 
    % For the (a) part I pick sub1 but it's the same with sub2.
    row_sel = randi([1,20],1,3);
    s1_1 = sub1(row_sel(1), :);
    s1_2 = sub1(row_sel(2), :);
    s2 = sub2(row_sel(3), :);

    %Calculate the normalized Hamming distance.

    Ham_dist_S = sum(xor(s1_1,s1_2))/size(sub1, 2);
    Ham_dist_D = sum(xor(s1_1, s2))/size(sub1, 2);
    
    %Create structures for S, D sets with person id, the compared rows, and
    %the hamming distance between them.

    S.person(i) = {sprintf('person%02d.mat', people(1))};
    D.person(i) = {sprintf('person%02d.mat and person%02d.mat', people)};
    S.rows(i) = {sprintf('row%2d and row%2d', row_sel([1, 2]))};
    D.rows(i) = {sprintf('row%2d and row%2d', row_sel([1, 3]))};
    S.distance(i) = Ham_dist_S;
    D.distance(i) = Ham_dist_D;

    %Task2(b)


end

%% Task_2.2 Plot S, D.

%Bins are marginalized between the [0,1] interval with a number of bins
%equal to 30. With this number of bins you can correctly represent the
%smallest error which is 1 bit out of 30. Bin width is the inteval divided
%by  the number of bins.

h = histogram(S.distance, 30);
h.BinLimits = [0, 1];
h.BinWidth = 1/30;
hold on
h1 = histogram(D.distance, 30);
h1.BinLimits = [0, 1];
h1.BinWidth = 1/30;



%% Task 2.3 Mean and variance of S, D.

mu = [mean(S.distance), mean(D.distance)];
std = [std(S.distance), std(D.distance)];

%% Task 2.4

%Create interval and Gaussians.
q = 0:0.001:1;
f1 = normpdf(q, mu(1), std(1));
f2 = normpdf(q, mu(2), std(1));

%Calculate the scaling.
e1 = mod(mu(1)/h.BinWidth, 1);
scalar_s = (h.Values(floor((mu(1)/h.BinWidth))) * (1-e1) + h.Values(ceil((mu(1)/h.BinWidth))) * e1)/max(f1);
e2 = mod(mu(2)/h.BinWidth, 1);
scalar_d = (h1.Values(floor((mu(2)/h.BinWidth))) * (1-e2) + h1.Values(ceil((mu(2)/h.BinWidth))) * e2)/max(f2);

%Scale the Gaussian and plot them alongside histograms.

f1 = f1 * scalar_s;
f2 = f2 * scalar_d;
plot(q, f1, 'r');
plot(q, f2, 'g');

%% Task 2.5

% Calcuate decision boundary based on False alarm rateprobability value 
% divided by class prior. We have equals priors in this case.

db = norminv(0.0005/0.5,mu(2),std(2));

% Use this value to calculate the the FRR
FRR = normcdf(db, mu(1),std(1));

%% Task 2.6

% First we should filter the testperson iriscode. Then based on that filter
% we should apply the same to all people. Then we test the HD and keep the
% one with the smallest.

load('testperson.mat')
% Extract the index of interest to create the mask.
index_vector = [];
index = 1;
for i=1:length(iriscode)
    if iriscode(i)==2
        index_vector(index) = i;
        index = index +1;
    end

end

% Filter iriscode.

iriscode(:, index_vector) = [];

% Read every person's data and filter them.
for i=1:20
    per = list_of_people(i);
    per = importdata(per);
    per(:, index_vector) = [];

    % For every filtered row calculate the Hamming distance. If it is the
    % current smallest value out of all tested, keep value and person in a
    % structure. To extract the closest person to the 'testperson.mat' you
    % index the structure's index.
    for row=1:size(per, 1)
        ham = 0;
        ham = ham + sum(xor(per(row,:), iriscode));
        if ham < size(iriscode, 1)
            s.ham = ham;
            s.index = i;
        end
    end
end
