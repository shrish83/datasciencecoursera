rm(list=ls())

##PART 1
pollutant_mean <- function(directory,pollutant,id=1:332){
 files <- list.files(path = directory, pattern = ".csv", full.names = T)
 mean_values <- numeric()
 
 for(i in id){
   df <- read.csv(files[i])
   mean_values <- c(mean_values,df[[pollutant]])
 }
 mean(mean_values,na.rm = T)
}

pollutant_mean("specdata","sulfate",1:10)



##PART 2
complete <- function(directory,id=1:332){
  files <- list.files(path = directory, pattern = ".csv", full.names = T)
  cases <- c()
  j <- 1
  for(i in id){
    df <- na.omit(read.csv(files[i]))
    cases[j] <- nrow(df)
    j <- j+1
  }
  data <- data.frame("id" = id,"nobs"=cases)
  return(data)
}

complete("specdata",c(2,4,8,10,12))



##PART 3
# corr <- function(directory,threshold=0){
#   #nComplete <- complete(directory=directory)
#   files <- list.files(path = directory, pattern = ".csv", full.names = T)
#   cr <- vector(mode = "numeric",length = 0)
#   for(i in 1:332){
#     df <- read.csv(files[i])
#     df <- na.omit(df)
#     if(nrow(df) > threshold){
#       cr <- c(cr,cor(df$sufhate,df$nitrate))
#     } 
#   }
#   cr
# }
# 
# corr("specdata",150)

corr<- function(directory, threshold = 0) {
  ## obtaining the required files by storing them into mydata variable
  mydata <- list.files(path = "/Users/atawua/Desktop/specdata")
  
  ## creating an empty numeric vector which will hold the final result
  result <- vector(mode = "numeric", length = 0) 
  
  for(i in 1:332) 
  {
    ## Reading and storing the required files without NAs into goodfile variable
    goodfile <- na.omit(read.csv(mydata[i]))
    if( nrow(goodfile) > threshold ) {
      
      ## calculating the correlation and combine in the result empty vector
      corvector <- cor(as.numeric(goodfile$sulfate), as.numeric(goodfile$nitrate))
      result <- append(result,corvector)
    }
  }
  ## return the result
  result
}
