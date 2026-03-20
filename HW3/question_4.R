
library(tuneR)	
start = 64000
sr = 8000 
bits = 16			# need to like with the sound library
N = 1024



						#length of fft
w = readWave("/Users/wyattclark/Desktop/I547/HW3/bass_oboe.wav")
#play(w,"play")                         # play it
y = w@left

t = seq(from=0,by= 2*pi/N,length=N);
win = (1 + cos(t-pi))/2
#plot(win)
new_wave = rep(0,0)
#loop_end = end_point / N;



for (i in 1:8) {
	begin = start + ((i-1)*N);
	end = begin+N -1 
  	x = y[begin : end]
	x = x*win;
  	X = fft(x)
  	X = 2*X/N
  	
  	X = X[1:N/2]
  	
  	Amps = Mod(X);
	places = order(Amps,decreasing = TRUE)
	
	X = X[places]
  	
  	
	freqs = seq(from = 1, to = length(X), by = 1)
	freqs = places
	X = X[1:N/2]
  	local_wave = rep(0,N);
	for (j in 1:length(X)){
		f = freqs[j]
		reconstructed = Mod(X[ j ]) * cos(( f-1)*t + Arg(X[j]))	
		local_wave = local_wave + reconstructed;
		
	} 
	new_wave = c(new_wave, local_wave)
	
}
y_temp = y[start:72192];
top = max(y_temp)
bottom = min(y_temp)
new_wave[new_wave > top] = top;
new_wave[new_wave < bottom] = bottom;
new_wave = c(y_temp, new_wave)
plot(new_wave)
u = Wave(new_wave, samp.rate = sr, bit=bits)  	# make wave struct.
play(u,"~/Desktop/r_fun/playRWave")                        # play it

