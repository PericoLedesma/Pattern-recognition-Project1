function mean_array = faverage(array);

    size_array = size(array);

    number_rows = size_array(1, 1);
 
    sumatory_columns = sum(array);

    mean_array =  sumatory_columns / number_rows;

end