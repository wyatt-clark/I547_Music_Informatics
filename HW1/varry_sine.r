library(tuneR)                          # need to link with the sound library
f = 440                                 # our base frequency in Hz (cycles per sec.)
amp = 1                                 # the amplitude
sr = 8000                              # sampling rate
bits = 16                               # bit depth
secs = 2.                               # length of each note in seconds
t = seq(0,secs,by=1/sr)    		# the time points at which we sample sound
y1 = amp*sin(2*pi*f*t)			# the sine wave
y2 = amp*sin(2*pi*-440*t)
y3 = amp*cos(2*pi*f*t)
y = c(y1, y2, y3)
s = floor(2^(bits-2)*y)			
					
	
u = Wave(s, samp.rate = sr, bit=bits)  	# make wave struct.
play(u,"~/Desktop/r_fun/playRWave")                         # play it