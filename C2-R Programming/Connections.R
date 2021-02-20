#Connections: Interfaces to Outside WOrld

#file : opens to a connection to a file
#gzfile : opens to a connection to a file compressed with gzip
#bzfile : opens to a connection to a file compressed with bzip2
#url : opens to a connection to a webpage

##example with connection is same as "data <- read.csv("data.R")"
#first build a connection (here read-only)
con <- file("y.R","r")
data <- read.csv(con)
close(con)
