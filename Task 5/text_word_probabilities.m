%Function to create a structure where each word has his probabilities

function structure = text_word_probabilities(email, probabilities);



for i =1:length(email)
    
    structure.word(i) = email(i);
    
    for j = 1:length(probabilities.word)
        
        if email(i,1) == probabilities.word(j);
            
            structure.spam(i) = probabilities.spam(j);
            structure.nospam(i) = probabilities.nospam(j);
            %             j = length(probabilities.word) + 1;
            break
        else
            structure.spam(i) = 0;
            structure.nospam(i) = 0;
        end
    end
end





end