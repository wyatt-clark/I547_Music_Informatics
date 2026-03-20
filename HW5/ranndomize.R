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




#################
#               #
# shift_energy  #
#               #
#################


shift_energy = function(Y){

	#create a container for our mod
	old_mod = Mod(Y);
	old_arg = Arg(Y);
	print("    shifting")
	#go through each even spot from end to start
	skip_back = seq(from=nrow(old_mod), to=2, by = -2);
	erasure = rep(0,length=ncol(old_mod));
	
	for(i in 1:length(skip_back)){
		t = skip_back[i];
		back = t/2;
		old_mod[t,]=old_mod[back,];
		
		#i'm out of phase here, can't seem to figure it out!!
		
		old_arg[t,]=old_arg[back,];
		#old_arg[t,]=c(old_arg[back,1], old_arg[back,2:ncol(Y)]*2   )
		old_arg[t,1]=0;
		#old_arg[t,1]=old_arg[t,1]/2;
		#old_arg[t,]= runif(ncol(Y));
	
	}
	print("    done shifting")
	
	#now go through each odd position and zero it out (maybe not needed, we'll see)
	
	print("    erasing")
	skip = seq(from = 1, to= nrow(old_mod)-1,by=2)
	
	erasure = rep(0,length=ncol(old_mod));
	for(i in 1:length(skip)){
		t = skip[i];
		old_mod[t,]=erasure;
		old_arg[t,]=erasure;
	}
	
	print("    done erasing")
	#plug it back in
	Y = matrix(complex(modulus = old_mod, argument = old_arg),nrow(Y),ncol(Y)) 
	print("    gone")
	return(Y)
}




#################
#               #
#   double_up   #
#               #
#################


double_up = function(Y){
	print("here here")
	new_mod = matrix(nrow = nrow(Y),ncol=ncol(Y)*2);
	new_arg = matrix(nrow = nrow(Y),ncol=ncol(Y)*2)
	mod = Mod(Y);
	arg = Arg(Y);
	erasure = rep(0,length= nrow(Y));
	for(t in 1:ncol(Y)){
		new_mod[,t*2] = mod[,t];
		new_mod[,(t*2)-1] = mod[,t];
		
		#new_arg[,t*2] = arg[,t];
		new_arg[,t*2] = erasure;

		new_arg[,(t*2)-1] = arg[,t]
		
		
		
	}

	Y = matrix(complex(modulus = new_mod, argument = new_arg),nrow(Y),ncol(Y)*2) 
			
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
w = readWave("~/Desktop/I547/HW5/bass_oboe.wav")    
sr = w@samp.rate
y = w@left      
y = y[1:floor(length(y)/4)]

print("take it apart")
Y = stft(y,H,N)





#######################
#######################


rand_cols = sample(1:ncol(Y),ncol(Y),replace=F)
Ybar = Y[,rand_cols]


#######################
#######################




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



