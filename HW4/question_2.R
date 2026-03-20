
rm(list = ls())
N = 512

t = seq(from=0,by= 2*pi/N,length=N);
win = (1 + cos(t-pi))/2
win = (cos(t-pi))/2

plot(win)

WIN = fft(win);
#WIN = WIN[1:(N/2)]
plot(Mod(WIN))




b = seq(1,length(Mod(WIN)),by=1)
freq_pos = b[Mod(WIN)>.1]
frequency = freq_pos#/ (N*2);
print("frequency is: ")
print(frequency)





