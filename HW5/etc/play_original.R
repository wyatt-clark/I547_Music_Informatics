y = (2^14)*y/max(y)
u = Wave(round(y), samp.rate = sr, bit=bits)   # make wave struct
play(u,"~/Desktop/r_fun/playRWave")  