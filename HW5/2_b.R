#Always clean up before working damnit
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
  stft
}

istft = function(Y,H,N) {
  v = seq(from=0,by=2*pi/N,length=N)     
  win = (1 + cos(v-pi))/2
  y = rep(0,N + H*ncol(Y))
  for (t in 1:ncol(Y)) {
    chunk  = fft(Y[,t],inverse=T)/N
    range = (1+(t-1)*H): ((t-1)*H + N)
    y[range]  = y[range]  + win*Re(chunk)
  }
  y
}



spectrogram = function(y,N) {
  bright = seq(0,1,by=.01)
  power = .2
  bright = seq(0,1,by=.01)^power
  grey = rgb(bright,bright,bright)
  cols = floor(length(y)/N)
  spect = matrix(0,cols,200)
  v = seq(from=0,by=2*pi/N,length=N)      # N evenly spaced pts 0 -- 2*pi
  win = (1 + cos(v-pi))/2
  for (t in 1:cols) {
    chunk  = y[(1+(t-1)*N):(t*N)]
    Y = fft(chunk*win)
    spect[t,] = Mod(Y[900:1100)])
  }
  image(spect,col=grey)
}




library(tuneR)			
N = 1024
H = N/8



bits = 16
  
w = readWave("~/Desktop/I547/HW5/glunker_stew.wav")    
    
sr = w@samp.rate
y = w@left      
spectrogram(y,N)
c = scan(what="")
Y = stft(y,H,N)
 

Y = matrix(complex(modulus = Mod(Y), argument = 2*pi*runif(length(Y))),nrow(Y),ncol(Y))  # whisperiz ation


ybar = istft(Y,H,N)

ybar = (2^14)*ybar/max(ybar)
u = Wave(round(ybar), samp.rate = sr, bit=bits)   # make wave struct
play(u,"~/Desktop/r_fun/playRWave")                  



