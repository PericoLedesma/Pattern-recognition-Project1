function correlation_array = fcorrelation(array);


%C = cov(array);
C = fcovariance(array);

correlation_array = [0; 0; 0];

size_array = size(array);
number_rows = size_array(1, 1);
number_columns = size_array(1, 2);
 

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
    
    correlation_array = [correlation_array c];
    
    %fprintf('The correlation between the column %d and column %d is: %f\n',column1,column2, correlation);
end


end