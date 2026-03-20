
# a simple program to demponstrate that any two frequencies that have
# the same ratio (c in these experiments) will have the same interval.
# c can be any positive constant

library(tuneR)				# need to like with the sound library
f = 440					# our base frequency
sr = 8000				# sampling rate
bits = 16				# bit depth
secs = 1.				# length of each note
notes = 8				# number notes we'll hear
#c = 3/2				# ratio of frequencies  
c = 2				# ratio of frequencies  
t = seq(0,secs,by=1/sr)			# the time points we create samples for
z = rep(0,0)
z2 = rep(0,0)
for (i in 1:notes) {			# our loop
  y = round(2^(bits-3) * sin(2*pi*f*t)) # make sine at freq f (don't need round)  
  z = c(z,y)
  f = f*c	
  if (i==5){
  	z2 = c(z2,y)
  	}
  
  #if (i==7){
  #	z2 = c(z2,y)
  #	}
  			# new freq for next note
}
#w = Wave(z, samp.rate = sr, bit=16)   # make wave struct
#play(w,"~/Desktop/r_fun/playRWave")                   # play it
w = Wave(z2, samp.rate = sr, bit=16)   # make wave struct
play(w,"~/Desktop/r_fun/playRWave")                   # play it
