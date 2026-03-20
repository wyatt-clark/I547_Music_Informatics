# show a movie of the sequence of spectra for the "octaves.wav" sound file.

end_point = 256000
library(tuneR)				# need to like with the sound library
N = 512



						#length of fft
w = readWave("~/Desktop/I547/HW3/bass_oboe.wav")
#play(w,"play")                         # play it
y = w@left

t = seq(from=0,by= 2*pi/N,length=N);
win = (1 + cos(t-pi))/2
#plot(win)

loop_end = end_point / N;

old_x = 0;
means = rep(0,loop_end);
for (i in 1:loop_end) {  
  	x = y[(i*N) : ((i+1)*N-1)]
  	plot(x)
  	c = scan(what="")
	x = x*win;
	plot(x)
  	c = scan(what="")
	
  	X = fft(x)/N
  	plot(Mod(X[1:(N/2)]),type='l',ylim=c(0,1000))
  	this_x = Mod(X[1:(N/2)])
  	diff = this_x - old_x;
  	
  	diff = abs(diff)
  	print(i)
  #	print(sum(diff))
  #	print(mean(diff))
  	old_x = Mod(X[1:(N/2)]);
	means[i] = mean(diff)
	c = scan(what="")		# wait for keyboard input
}

temp = seq(from=1,by=1,length=length(means))
temp = temp[means > 10]

plot(temp, means[temp],'l')
#plot(seq(from=1,by=1,length=length(means)),means,'l')
#w = w[1:end_point];
#play(w,"~/Desktop/r_fun/playRWave")                         # play it

