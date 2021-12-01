%% Function to create a structure where each word has his probabilities

function structure = text_word_probabilities(email_text, probabilities);



for i =1:length(email_text)
    
    structure.word(i) = email_text(i);
    
    for j = 1:length(probabilities.word)
        
        if structure.word(i) == probabilities.word(j);
            
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