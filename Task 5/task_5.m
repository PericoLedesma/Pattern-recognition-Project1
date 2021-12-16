%% Task 5: Naive Bayesian rule
clc 
clear all

introduction = "Task 5: Naive Bayesian rule";
disp(introduction);

%% Create a structure for the probabilities of the words 

structure_probabilities = data();

%% Probability than an email is a span or not

email_spam_probabilities = 0.9;
email_nonspam_probabilities = 0.1;

%%  Email texts

email_text1 = "We offer our dear customers a wide selection of classy watches.";
email_text1_orginal_store = email_text1;
email_text2 = "Did you have fun on vacation? I sure did!";
email_text2_orginal_store = email_text2;

%% Upper the text so is easier to compare

email_text1 = upper(email_text1);
email_text2 = upper(email_text2);

%% We have to eliminate dots, exclamation and interrogation signs of the
%email text

email_text1 = erase(email_text1 ,[".", "!", "!"]);
email_text2 = erase(email_text2 ,[".", "!", "!"]);


%% Text 1: Function to create a structure where each word has his probabilities

email_text = split(email_text1);

email_words_probabilities = text_word_probabilities(email_text, structure_probabilities);

% Applicatin of Naive Bayesian

[probability_spam, probability_nospam] = fNaiveBayesian(email_spam_probabilities,email_nonspam_probabilities,email_words_probabilities);

if probability_spam < probability_nospam;
    type_email = "not a spam";
else 
    type_email = "a spam";
end 

fprintf('The email text: "%s"', email_text1_orginal_store);
fprintf(' may be %s.\n', type_email);
fprintf('Probability of spam email: %.12f \n', probability_spam);
fprintf('Probability of not a spam email: %.12f \n', probability_nospam);

%% Text 2: Function to create a structure where each word has his probabilities

email_text = split(email_text2);

email_words_probabilities = text_word_probabilities(email_text, structure_probabilities);

% Applicatin of Naive Bayesian

[probability_spam, probability_nospam] = fNaiveBayesian(email_spam_probabilities,email_nonspam_probabilities,email_words_probabilities);

if probability_spam < probability_nospam;
    type_email = "not a spam";
else 
    type_email = "a spam";
end 

fprintf('The email text: "%s"', email_text2_orginal_store );
fprintf(' may be %s.\n', type_email);
fprintf('Probability of spam email: %.12f \n', probability_spam);
fprintf('Probability of not a spam email: %.12f \n', probability_nospam);




