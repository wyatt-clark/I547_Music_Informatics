

Freqs = abs(Ybar);

percent = .2;

[V,I] = sort(Freqs,1,'descend');


sampled = 1:floor(size(Freqs,1 ) *.2);

keepers = unique(I(sampled,:));
