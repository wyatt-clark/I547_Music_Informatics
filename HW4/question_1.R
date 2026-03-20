#let us assume that n is 100
N = 512;

a = c(-1,1,rep(0,510))

b = c(1,-2,1,rep(0,509))


A = fft(a);


B = fft(b);

plot(Mod(A)[1:(N/2)])