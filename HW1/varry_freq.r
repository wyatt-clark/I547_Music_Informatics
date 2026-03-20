library(tuneR)                          # need to link with the sound library
f = 440*(2^(-9/12)) 
f = 440                               # our base frequency in Hz (cycles per sec.)
amp = .5                                 # the amplitude
sr = 32000                              # sampling rate
bits = 16                               # bit depth
secs = 4                            # length of each note in seconds
t = seq(0,secs,by=1/sr)    		# the time points at which we sample sound
samples_per_period = round(sr/f);
#we want to cycle amplitude 5 cycles per second, sr and sec can stay the same
f_mod_f = 1;
f_mod = 10*sin(2*pi*f_mod_f*t)

y = amp*sin(2*pi*f*t + f_mod)			# the sine wave
#y = amp*sin(2*pi*f*t*f_mod)			# the sine wave

s = floor(2^(bits-2)*y)			

plot( y[seq(1,length(y), by = 250)],type="l")
u = Wave(s, samp.rate = sr, bit=bits)  	# make wave struct.
play(u,"~/Desktop/r_fun/playRWave")                         # play it