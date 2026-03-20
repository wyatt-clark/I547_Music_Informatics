clear 
%if audio is dual channel y will have two columns
[y, sr, bits, opts]  = wavread('glunker_stew.wav');

%don't forget to convert back to correct type when done!

y = y(:,1);

N = 1024;
H = N/4;
M = 64;

fprintf(1,'data loaded, starting to create stft\n');
Y = stft(y,N,H);



fprintf(1,'done with stft, starting to cluster if needed\n');
%cluster the energies
%[E_ID, E_CENT] = kmeans(abs(Y)', M,'emptyaction', 'drop','display','iter');





%permutes members of the same cluster
%Ybar = vq_shuffle(Y,ID);

%replaces each frame with the phase of its respective centroid
%Ybar = vq_replace(Y, E_ID,E_CENT);
Ybar = Y;

%mod = encode(abs(Y)',CENT, 'euclidean', []);
%mod = encode_sorted(abs(Y)',CENT, 'euclidean', []);
%Ybar = mod'.*exp(i.*angle(Y));


clear Y y;
fprintf(1,'starting to perform inverse stft\n');
ybar = istft(Ybar,N,H);

ybar = (2^14).*ybar./max(ybar);

ybar = int16(ybar);

%wavwrite(ybar, sr,bits, 'prelude_encoded_0.wav');
wavplay(ybar,sr)