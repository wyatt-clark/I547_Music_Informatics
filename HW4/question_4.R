library(tuneR)	

sr = 8000 
bits = 16			# need to like with the sound library
N = 1024

A = rep(0,N);
#we want to keep 1000 to 3000
start = 1000/(sr/N);
stop = 3000/(sr/N);

A[start:stop] = 1;
A[(N-stop):(N-start)] = 1
plot(A)
a = Re(fft(A, inverse=TRUE))

#plot(a)


w = readWave("~/Desktop/I547/HW3/bass_oboe.wav")
y = w@left
y = y[1:(length(y)/6)]


#a = c(a, rep(0,( length(y)-length(a) ))    )
#A = fft(a)
Y=fft(y)
#Z = A*Y
#z = Re(fft(Z, inverse=TRUE))
plot(Mod(Y)[1:(length(y)/2)])
c = scan(what="")




z = filter(y,a,method="conv",circular=T)
Z = fft(z)
plot(Mod(Z)[1:(length(Z)/2)])
c = scan(what="")
#stopp
u = Wave(z, samp.rate = sr, bit=bits)
play(u,"~/Desktop/r_fun/playRWave")