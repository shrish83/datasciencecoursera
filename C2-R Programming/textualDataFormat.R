##dput()
##on a single R object
y <- data.frame(a=1,b='a')
dput(y)
dput(y,file='y.R')
new.y <- dget("y.R")
new.y
y

##dump()
##on multiple R objects
x <- "foo"
dump(c("x","y"),file="data.R")
rm(x,y)
source("data.R")
y
x
