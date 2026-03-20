library(tuneR)                          # need to link with the sound library
f = 900                                 # our base frequency in Hz (cycles per sec.)
amp = .75                                 # the amplitude
sr = 8000                              # sampling rate
bits = 16                               # bit depth
secs = 2.                               # length of each note in seconds
t = seq(0,secs,by=1/sr)    		# the time points at which we sample sound
y = amp*sin(2*pi*f*t)			# the sine wave

s = floor(2^(bits-2)*y)			
					
	
u = Wave(s, samp.rate = sr, bit=bits)  	# make wave struct.
play(u,"~/Desktop/r_fun/playRWave")                         # play it