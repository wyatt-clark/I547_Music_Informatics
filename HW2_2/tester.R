library(tuneR)                 
f_base = 880*(2^(-5/12))       


amp = .75                      
sr = 16000                     
bits = 16                      
secs = 2.                       
t = seq(0,secs,by=1/sr)
y = .5*sin(2*pi*f_base*t + runif(1) );

s = floor(2^(bits-2)*y)			
					
	
u = Wave(s, samp.rate = sr, bit=bits)  	# make wave struct.
play(u,"~/Desktop/r_fun/playRWave")       