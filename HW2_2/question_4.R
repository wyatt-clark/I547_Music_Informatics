library(tuneR)                 
f_base = 440*(2^(-5/12))       


amp = .1                      
sr = 16000                     
bits = 16                      
secs = 2.
f_temp = 440*(2^(-9/12))*.5
t = seq(0,secs,by=1/sr)
y_original = 1*sin(2*pi*f_temp*t + runif(1) );
y_total = rep(0,length(y_original))
#y_total = rep(0,0)
f_vector = c(0, 2, 0, 4, 0, 6, 0, 8, 0, 10)
#f_vector = c(3, 6, 9, 0, 0, 0, 0, 0, 0, 0)

for (i in 1:10){
	f = f_base*f_vector[i]; 
	print(i)
	print(f)   		
	y = amp*sin(2*pi*f*t + (2*runif(1)) );
	y_total = y_total + y			
}

y_total = c(y_total)
s = floor(2^(bits-2)*y_total)			
					
	
u = Wave(s, samp.rate = sr, bit=bits)  	# make wave struct.
play(u,"~/Desktop/r_fun/playRWave")       