
function [spam,nospam] = fNaiveBayesian(email_spam,email_nonspam, text_probabilities);

spam = 1;
nospam = 1;


for i =1:length(text_probabilities.word)
    
    if text_probabilities.spam(i) ~= 0;
        spam = text_probabilities.spam(i) * spam;
        nospam = text_probabilities.nospam(i) * nospam;
        
    end
end

spam = spam * email_spam;
nospam = nospam * email_nonspam;

end