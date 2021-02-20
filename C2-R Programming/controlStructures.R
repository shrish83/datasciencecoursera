rm(list = ls())

#for
x <- matrix(1:6,2,3)

for(i in seq_len(nrow(x))){
  for(j in seq_len(ncol(x)))
    print(x[i,j])
}

#while
count <- 0
while(count < 10){
  print(paste("num",count))
  count <- count + 1
}

#break and next just like break and continue

#FUNCTIONS

#1. Assign defaut values to arguments
function(f,a=1,b=3,c=NULL){}

#2. Lazy Evaluation: evaluated only as needed
f <- function(a,b){a*2}
f(2)  #wil not produce error since b is not needed inside fucntion
f <- function(a,b){
  a*2
  b*3
}
f(2)  #will produce error


##SYMBOL BINDING