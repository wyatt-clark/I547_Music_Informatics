function Y = stft(y,N,H)



v = 0:2*pi/N:(N-1)*(2*pi/N);
win = (1+ cos(v-pi))/2;


cols = floor((length(y) - N)/H) +1;

Y = zeros(N, cols);

for t = 1:cols
    
    start = 1+ (t-1) * H;
    stop = (t-1) * H + N;
    
    chunk = y(start:stop);
  %  chunk = chunk.*win';
    Y(:,t) = fft(chunk);
    
end


%abs = mod = freq energy
%angle = arg =  phase
ph = angle(Y);


for k = 1:size(ph,1)
   ph(k,:) = [ph(k,1) diff(ph(k,:))];
    
    
end


Y = abs(Y).*exp(i.*ph);
%To convert back to the original complex number
%z = r *exp(i *theta)