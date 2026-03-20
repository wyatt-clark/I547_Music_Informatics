function y = istft(Y,N,H)

ph = angle(Y);

for k = 1:size(Y,1)
    ph(k,:) = cumsum(ph(k,:));
end

Y = abs(Y).*exp(i.*ph);


v = 0:2*pi/N:(N-1)*(2*pi/N);
win = (1+ cos(v-pi))/2;

y = zeros(1, N+H*size(Y,2));

for t = 1:size(Y,2)
    chunk = ifft(Y(:,t), 'symmetric');
    start = 1+ (t-1) * H;
    stop = (t-1) * H + N;
   % chunk = chunk./win';
    y(start:stop) = y(start:stop) + chunk';
end
