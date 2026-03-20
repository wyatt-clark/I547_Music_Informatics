clear 
%if audio is dual channel y will have two columns
[y, sr, bits, opts]  = wavread('glunker_stew.wav');

%don't forget to convert back to correct type when done!

y = y(:,1);

N = 1024;
H = N/2;
M = 64;

Y = stft(y,N,H);
save Y_glunker Y
%load Y_prelude

%Ybar = Y;
%Ybar = Y(:,randperm(size(Y,2)));

%load 64_glunker

%cluster the conplex numbers themselves
[ID, CENT] = kmeans(Y', M,'emptyaction', 'drop','display','iter');



Ybar = vq_replace_2(Y, ID, CENT);



clear Y y;

ybar = istft(Ybar,N,H);

ybar = (2^14).*ybar./max(ybar);

ybar = int16(ybar);
save output
%wavplay(ybar,sr)