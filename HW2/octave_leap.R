library(tuneR)
amp = .5                     
sr = 16000                     
bits = 16 
##############
#constants above here

#initialize first vector
y_total = rep(0);

#make first wave at f = 1
f = 440*(2^(-9/12))
secs = 2;
t = seq(0,secs,by=1/sr);
y1 = amp*sin(2*pi*f*t);




#make second wave at twice frequency
f = 880*(2^(-9/12))
secs = 2;
t = seq(0,secs,by=1/sr);
y2 = amp*sin(2*pi*f*t);


#now make the connector

#make first wave at f = 1
#
f1 = 440*(2^(-9/12))
f2 = 880*(2^(-9/12))


f = 440*(2^(-9/12))
secs = 4;
t = seq(0,secs,by=1/sr);

f_mod = c(seq(f1,f2, length = 2*sr), rep(f2,2*sr))
#f_mod_f = .25;
#f_mod = (880*(2^(-9/12)))* (-1*cos(2*pi*f_mod_f*t)) + 440

y1_to_2 = amp*sin(2*pi* t * f_mod);

y = c(y1,y1_to_2);
#y = y2;
#plot(y1_to_2)
###no need to modify below here as long as your final vector is y
#######################
s = floor(2^(bits-2)*y)			
u = Wave(s, samp.rate = sr, bit=bits)  	# make wave struct.
play(u,"~/Desktop/r_fun/playRWave")