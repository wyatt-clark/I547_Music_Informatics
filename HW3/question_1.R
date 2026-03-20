


N = 1024;
n = seq(0,N-1, by= 1);
n = n/N;
y = (4*sin(2*pi*5*n)) + (cos(2*pi*5*n));
#y = 3*cos(2*pi*8*n-1) #
Y = fft(y)
Y = Y[1:(N/2)]
plot(Mod(Y))
b = seq(1,length(Mod(Y)),by=1)
freq_pos = b[Mod(Y)>1]
modulus = Mod(Y)[freq_pos]
amplitude = modulus/ (N/2)
argument  = Arg(Y)[freq_pos]
phase = argument / (N/2)
frequency = freq_pos -1;
print("frequency is: ")
print(round(frequency))
print("amplitude is: ")
print(round(amplitude))
print("phase is: ")
print(phase)
argument = round(argument)
modulus = round(modulus)
print("argument is:")
print(argument)
print("modulus is:")
print (modulus)
#plot(amp,freq)
#plot(Mod( Y[1:N/2] )) 