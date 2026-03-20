library(tuneR)                 
f_base = 440*(2^(-9/12))       


amp = .75                      
sr = 8000                     
bits = 16                      
secs = 1.                       
t = seq(0,secs,by=1/sr)

y_total = rep(0);

for (i in 1:8){
	f = f_base*i; 
	print(i)
	print(f)   		
	y = amp*sin(2*pi*f*t);
	y_total = c(y_total, y)			
}

s = floor(2^(bits-2)*y_total)			
					
	
u = Wave(s, samp.rate = sr, bit=bits)  	# make wave struct.
play(u,"~/Desktop/r_fun/playRWave")       