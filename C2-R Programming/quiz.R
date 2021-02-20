df <- read.csv("hw1_data.csv")
names(df)
df[1:2,]
nrow(df)
df[152:153,]
df[47,1]
a<-df[is.na(df$Ozone),1]
length(a)
mean(na.omit(df$Ozone))

df.new <- df[df$Ozone>31 & df$Temp>90,]
mean(na.omit(df.new$Solar.R))
df.new1 <- df[df$Month==6,]
mean(na.omit(df$Temp))
df.new1 <- df[df$Month==5,]
max(na.omit(df$Ozone))
