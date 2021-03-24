##Q1
df <- read.csv("week1Q1.csv")
dim(df)

na.omit(nrow(df[df$VAL>=1000000,]))
 
##q2
str(df)

##q3
#library(xlsx)
df1 <- readxl::read_excel("gasdata.xlsx")
dat <- df1[18:23,7:15]
sum(dat$Zip*dat$Ext,na.rm=T)
