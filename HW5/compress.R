#REMEMBER!!
#ARG(I)=PHASE at FREQ(I)
#MOD(i)=ENERGY at FREQ(I)


#########
#       #
# stft  #
#       #
#########

#Always clean up before working damnit
rm(list = ls())


stft = function(y,H,N) {
	
	
 #create a hanning window	
  v = seq(from=0,by=2*pi/N,length=N)     
  win = (1 + cos(v-pi))/2
  
  #calculate the number of ffft's that we do
  cols = floor((length(y)-N)/H) + 1
  
  #create a mattrix to hold each fft in its columns
  stft = matrix(0,N,cols)
  
  #go over each piece of our signal and take the fft of the windowed frames
  for (t in 1:cols) {
  	
    range = (1+(t-1)*H): ((t-1)*H + N)
    chunk  = y[range]
    stft[,t] = fft(chunk*win)
  }
  
  
  #after taking the fft of each frame extract the ARG=PHASE     
  ph = Arg(stft)
  
  #We not go over each frequecies = rows
  #and find the difference between each pahse: frame(i) - frame(i-1)
  #concatenated with the first value so we know where we started
  
  
  for (k in 1:nrow(ph)) {
    ph[k,] = c(ph[k,1],diff(ph[k,]))
  }
  
  
  #we now replace the argument with the new matrix of differences for arguments that we created
  stft = matrix(complex(modulus = Mod(stft), argument = ph),nrow(stft),ncol(stft)) 

  return(stft)


}




##########
#        #
# istft  #
#        #
##########


#put it back together
istft = function(Y,H,N) {
   
  #ph is our phase matrix with the first column as the start phase for each frequency
  ph = Arg(Y)
  
  #now we reconstruct the original phase values by taking the cumulative sum of each row
  for (k in 1:nrow(Y)) {
    ph[k,] = cumsum(ph[k,])
  }
  
  #replace first derivative with original
  Y = matrix(complex(modulus = Mod(Y), argument = ph),nrow(Y),ncol(Y)) 
  
 #reconstruct the hanning window
  v = seq(from=0,by=2*pi/N,length=N)     
  win = (1 + cos(v-pi))/2
 
  #create a signal to be filled
  y = rep(0,N + H*ncol(Y))
  
  #take the inverse fft and add it to the frame of your signal where it belongs
  for (t in 1:ncol(Y)) {
    chunk  = fft(Y[,t],inverse=T)/N
    range = (1+(t-1)*H): ((t-1)*H + N)
    y[range]  = y[range]  + win*Re(chunk)
  }
  return(y)
}


compress = function(Y,percent){
	mod = Mod(Y);
	phase = Arg(Y);
		

	x = sort(mod,decreasing=T);
	cutoff = x[(percent/100) * length(x)];
	mod[mod<cutoff] = 0;
	phase[mod<cutoff] = 0;
	
	
	Y = matrix(complex(modulus = mod, argument = phase),nrow(Y),ncol(Y));
	return(Y)
	
	
}



##############################
#        #####################
#  main  #####################
#        #####################
##############################

print("load it up")

library(tuneR)			
N = 1024 #window size
H = N/4  #overlap
bits = 16
#w = readWave("sound/octaves.wav")    
w = readWave("~/Desktop/I547/HW5/octaves.wav")    
sr = w@samp.rate
y = w@left      
y = y[1:floor(length(y)/4)]


#######################


print("take it apart")
Y = stft(y,H,N)

#######################



Ybar = compress(Y,1)




#no need to change this except to possibly change path to player
#######################
#######################
print("put it back together")
ybar = istft(Ybar,H,N)

print("round it and play it")
ybar = (2^14)*ybar/max(ybar)
u = Wave(round(ybar), samp.rate = sr, bit=bits)   # make wave struct
play(u,"~/Desktop/r_fun/playRWave")   
#######################
#######################











