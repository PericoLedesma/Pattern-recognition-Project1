% sprintf
% 
% sprintf(’person%02d.mat’,3)
% 
% char
% 

clear all 
clc


array2 = importdata('person01.mat');



for i =1:20

str = sprintf('person%02d.mat',i)


URL  = convertStringsToChars(str)

array.person(i) = importdata(URL)



end

