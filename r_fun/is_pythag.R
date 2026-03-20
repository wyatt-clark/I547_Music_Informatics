is_pythag <- function(f_name){
	mat <- read.table(f_name)
	
	size <- dim(mat);
	pythag <- 1;
	for (i in 1:(size[1]-2) ){
		for (j in (i+1):(size[1]-1) ){
			
			for (k in (j+1):size[1] ){
				#print(i)
				#print(j)
				#print(k)
				d1 <- mat[i,j];
				d2 <- mat[i,k];
				d3 <- mat[j,k];
				dvect = c(d1,d2,d3)
				sorted = sort(dvect);
				if (sorted[1]^2+sorted[2]^2 != sorted[3]^2) {
						pythag <- 0;
					
					}
					
					
				
				} 
			}
		
		}
		return(pythag);
	
}
