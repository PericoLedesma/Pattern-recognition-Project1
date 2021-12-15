function ent_val = entropy(dataset)
ent_val = 0;
for i=unique(dataset(:,end))'
    ent_val = ent_val -(sum(dataset(:)== i)/size(dataset,1))...
              * log2(sum(dataset(:)== i )/size(dataset,1));
end
end
