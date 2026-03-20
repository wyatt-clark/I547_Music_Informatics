rm(list = ls())
library(tuneR) 
sr = 1024*8;                     
bits = 32;  
secs = 1;
amp = 1;
t = seq(1/sr, secs,by=1/sr);
f = seq(0,sr/4, length = length(t));
N = length(t)
##############################
##############################

#create chirp
y = amp*sin(2*pi*t*f);
y_single = y;
y = c(y,y,y,y)

N = length(y)


#take fft of all chirps or just a single one
Y = fft(y[1:((N/4)*1)]);
#Y = fft(y);


plot(Mod(Y)[1:(length(Y)/2)])
c = scan(what="")
plot(Arg(Y)[1:(length(Y)/2)])
c = scan(what="")
  	
  	
#create the reverse chirp  	
yr = y_single[seq(length(y_single),1,by=-1)]
yr_single = yr;
yr = c(yr,yr,yr,yr)


#take fft of all chirps or just a single one
YR = fft(yr[1:((N/4)*1)]);
#YR = fft(yr);


plot(Mod(YR)[1:(length(YR)/2)])
c = scan(what="")
plot(Arg(YR)[1:(length(YR)/2)])
c = scan(what="")

#lets look at a single ascending and descending
y_temp = c(y_single, yr_single)
Y = fft(y_temp);
plot(Mod(Y)[1:(length(Y)/2)])


#play the sound
y = c(y,rep(0,1000),yr)
s = floor(2^(bits-2)*y)			
u = Wave(s, samp.rate = sr, bit=bits)  	# make wave struct.
play(u,"~/Desktop/r_fun/playRWave")