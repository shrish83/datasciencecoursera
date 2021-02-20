rm(list=ls())
#Vectors
x <- c("a","b","c","c","d","a")
x[1]
x[2:5]

#lists
x <- list(foo = 1:5,bar=0.7)
x[1]
x[[1]]
x[["bar"]]
x["bar"]

x <- list(foo = 1:6,bar=0.7,baz="hhh")
x[c(1,3)]
x$bar

x <- list(foo = 1:5,bar=c(0.7,9.3))
x[[2]][[2]]


#Matrices
x <- matrix(1:6,2,3)
x
x[1,2]
x[2,]   ##all these give output as a vector even
x[,3]   ## when if x is a matrix

#hence
x[1,2,drop=F]  #use 'drop=FALSE' to get output as matrix

##Partial MAtching
x <- list(aabcgssr = 1:5)
x$aab
x$gss
x[["aab"]]
x[["aab",exact=F]]
x[["gss",exact=F]]

##Removing NA
x <- c("1","A",2,NA,Inf,TRUE,"hello",NA,3.5)
!is.na(x)
x[!is.na(x)]
complete.cases(x)
x[complete.cases(x)]
