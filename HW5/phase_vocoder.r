# here are two new versions of the stft where, rather than storing amplitude
# and phase for each time frequency point, we start amplitude and the change
# in phase.  the inverse is then accomplished by "integrating" (taking the
# cumsum of each row of the stft before going through the usual overlap
# add inversion process.

rm(list = ls())


stft = function(y,H,N) {
  v = seq(from=0,by=2*pi/N,length=N)     
  win = (1 + cos(v-pi))/2
  cols = floor((length(y)-N)/H) + 1
  stft = matrix(0,N,cols)
  for (t in 1:cols) {
    range = (1+(t-1)*H): ((t-1)*H + N)
    chunk  = y[range]
    stft[,t] = fft(chunk*win)
  } 
  ph = Arg(stft)
  for (k in 1:nrow(ph)) {
    ph[k,] = c(ph[k,1],diff(ph[k,]))
  }
  stft = matrix(complex(modulus = Mod(stft), argument = ph),nrow(stft),ncol(stft)) 
  return(stft)
}

istft = function(Y,H,N) {
  ph = Arg(Y)
  for (k in 1:nrow(Y)) {
    ph[k,] = cumsum(ph[k,])
  }
  Y = matrix(complex(modulus = Mod(Y), argument = ph),nrow(Y),ncol(Y)) 
  v = seq(from=0,by=2*pi/N,length=N)     
  win = (1 + cos(v-pi))/2
  y = rep(0,N + H*ncol(Y))
  for (t in 1:ncol(Y)) {
    chunk  = fft(Y[,t],inverse=T)/N
    range = (1+(t-1)*H): ((t-1)*H + N)
    y[range]  = y[range]  + win*Re(chunk)
  }
  return(y)
}


library(tuneR)			
N = 1024
H = N/4
bits = 16
#w = readWave("C:/Documents and Settings/wtclark/Desktop/I547/HW5/glunker_stew.wav")    
w = readWave("C:/Documents and Settings/wtclark/Desktop/I547/HW5/octaves.wav")    
sr = w@samp.rate
y = w@left      
Y = stft(y,H,N)



#Ybar = matrix(0,nrow(Y),100)  # freeze frame
#for (t in 1:100) { 
#  Ybar[,t] = Y[,307] 
#}

Ybar = matrix(0,nrow(Y),ncol(Y)/2)  # create a stft that goes twice as fast
for (t in 1:(ncol(Y)/2)) { 
  Ybar[,t] = Y[,2*t] 
}

#rand_cols = sample(1:ncol(Y),ncol(Y),replace=F)
#Ybar = Y[,rand_cols]

N = 1024*2
H = N/4
ybar = istft(Ybar,H,N)
#ybar = istft(Y,H,N)
ybar = (2^14)*ybar/max(ybar)
u = Wave(y, samp.rate = sr, bit=bits)   # make wave struct


play(u)                  
u = Wave(round(ybar), samp.rate = sr, bit=bits)   # make wave struct
play(u)                  

