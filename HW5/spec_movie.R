mod = Mod(Y);
n_rows = nrow(mod)
for(i in 1:ncol(mod)){
	plot(mod[n_rows/2:n_rows,i])
	#,ylim=c(0,1000)
	# type ='l'
	c = scan(what="")	
	
}