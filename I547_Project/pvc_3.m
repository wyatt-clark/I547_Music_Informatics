clear 
%if audio is dual channel y will have two columns
[y, sr, bits, opts]  = wavread('glunker_stew.wav');

%don't forget to convert back to correct type when done!

y = y(:,1);

N = 1024;
H = N/2;
M = 64;

Y = stft(y,N,H);

%load Y_prelude

%Ybar = Y;
%Ybar = Y(:,randperm(size(Y,2)));

%load 64_glunker

%cluster the concatenation of the phases and energies
concat = [abs(Y)' angle(Y)'];
[ID, CENT] = kmeans(concat, M,'emptyaction', 'drop','display','iter');

save incase_of_poop

Ybar = vq_replace_3(Y, ID, CENT,N);



clear Y y;

ybar = istft(Ybar,N,H);

ybar = (2^14).*ybar./max(ybar);

ybar = int16(ybar);
save ybar_glunker_concatenated_64
%wavplay(ybar,sr)