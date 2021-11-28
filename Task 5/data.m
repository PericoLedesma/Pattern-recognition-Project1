% Data Task 1
function data = data();

email_words = [ "Anti-aging" ; "Customers"; "Fun"  ;"Groningen"  ; "Lecture" ;"Money" ;"Vacation"  ;"Viagra"  ; "Watches"]  ;
email_words_stats = [0.00062 0.000000035; 0.005 0.0001; 0.00015 0.0007; 0.00001 0.001; 0.000015 0.0008; 0.002 0.0005; 0.00025 0.00014; 0.001 0.0000003; 0.0003 0.000004];

email_words = upper(email_words);

for i =1:length(email_words)
    
    data.word(i) = email_words(i);
    data.spam(i) = email_words_stats(i,1);
    data.nospam(i) = email_words_stats(i,2);
    
end

end
