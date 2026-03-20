clear 
%if audio is dual channel y will have two columns
[y, sr, bits, opts]  = wavread('glunker_stew.wav');

%don't forget to convert back to correct type when done!

y = y(:,1);

N = 1024;
H = N/2;
M = 64;

Y = stft(y,N,H);




%cluster the phase and energy seperately
[E_ID, E_CENT] = kmeans(abs(Y)', M,'emptyaction', 'drop','display','iter');

M = 128;
[P_ID, P_CENT] = kmeans(angle(Y)', M,'emptyaction', 'drop','display','iter');


%permutes members of the same cluster
%Ybar = vq_shuffle(Y,ID);

%replaces each frame with the phase of its respective centroid
Ybar = vq_replace(Y, E_ID,E_CENT);

Ybar = vq_replace_phase(Y,P_ID,P_CENT);

%mod = encode(abs(Y)',CENT, 'euclidean', []);
%mod = encode_sorted(abs(Y)',CENT, 'euclidean', []);
%Ybar = mod'.*exp(i.*angle(Y));


clear Y y;

ybar = istft(Ybar,N,H);

ybar = (2^14).*ybar./max(ybar);

ybar = int16(ybar);

save ybar_glunker_seperate_128
%wavplay(ybar,sr)