rm(list = ls())

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

dim(outcome)
str(outcome)


# Plot the 30-day mortality rates for heart attack
outcome[, 11] <- as.numeric(outcome[, 11])
hist(na.omit(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))


#Finding the best hospital in a state
best <- function(state,res){
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  df <- data[, c(2,7,11,17,23)]
  df[,3] <- as.numeric(df[,3])
  df[,4] <- as.numeric(df[,4])
  df[,5] <- as.numeric(df[,5])
  
  colnames(df) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  if(!state %in% df[, "state"]){
    stop('invalid state')
  } else if(!res %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  } else {
    df_state <- df[df$state==state,]
    oi <- as.numeric(df_state[, eval(res)])
    min_val <- min(oi,na.rm = T)
    hos <- df_state[,"hospital"][which(oi == min_val)]
    output <- hos[order(hos)]
  }
  return(output)
}

best("SC", "heart attack")


#3 Ranking hospitals by outcome in a state
rankhospital <- function(state, res, num = "best") {
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  df <- data[, c(2,7,11,17,23)]
  df[,3] <- as.numeric(df[,3])
  df[,4] <- as.numeric(df[,4])
  df[,5] <- as.numeric(df[,5])
  
  colnames(df) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  if(!state %in% df[, "state"]){
    stop('invalid state')
  } else if(!res %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  } else if(is.numeric(num)){
    df_state <- df[df$state==state,]
    df_state[, eval(res)] <- as.numeric(df_state[, eval(res)])
    df_state <- df_state[order(df_state[, eval(res)], df_state[, "hospital"]), ]
    output <- df_state[, "hospital"][num]
  }else if (!is.numeric(num)){
    if (num == "best") {
      output <- best(state, res)
    } else if (num == "worst") {
      si <- which(df[, "state"] == state)
      ts <- df[si, ]    
      ts[, eval(res)] <- as.numeric(ts[, eval(res)])
      ts <- ts[order(ts[, eval(res)], ts[, "hospital"], decreasing = TRUE), ]
      output <- ts[, "hospital"][1]
    } else {
      stop('invalid rank')
    }
  }
  return(output)
}

rankhospital("NC", "heart attack", "worst")



#4
rankall <- function(outcome, num = "best"){
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  fd   <- as.data.frame(cbind(data[, 2],  # hospital
                              data[, 7],  # state
                              data[, 11],  # heart attack
                              data[, 17],  # heart failure
                              data[, 23]), # pneumonia
                        stringsAsFactors = FALSE)
  colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  fd[, eval(outcome)] <- as.numeric(fd[, eval(outcome)])
  
  ## Check that state and outcome are valid
  
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
    stop('invalid outcome')
  } else if (is.numeric(num)) {
    by_state <- with(fd, split(fd, state))
    ordered  <- list()
    for (i in seq_along(by_state)){
      by_state[[i]] <- by_state[[i]][order(by_state[[i]][, eval(outcome)], 
                                           by_state[[i]][, "hospital"]), ]
      ordered[[i]]  <- c(by_state[[i]][num, "hospital"], by_state[[i]][, "state"][1])
    }
    result <- do.call(rbind, ordered)
    output <- as.data.frame(result, row.names = result[, 2], stringsAsFactors = FALSE)
    names(output) <- c("hospital", "state")
  } else if (!is.numeric(num)) {
    if (num == "best") {
      by_state <- with(fd, split(fd, state))
      ordered  <- list()
      for (i in seq_along(by_state)){
        by_state[[i]] <- by_state[[i]][order(by_state[[i]][, eval(outcome)], 
                                             by_state[[i]][, "hospital"]), ]
        ordered[[i]]  <- c(by_state[[i]][1, c("hospital", "state")])
      }
      result <- do.call(rbind, ordered)
      output <- as.data.frame(result, stringsAsFactors = FALSE)
      rownames(output) <- output[, 2]
    } else if (num == "worst") {
      by_state <- with(fd, split(fd, state))
      ordered  <- list()
      for (i in seq_along(by_state)){
        by_state[[i]] <- by_state[[i]][order(by_state[[i]][, eval(outcome)], 
                                             by_state[[i]][, "hospital"], 
                                             decreasing = TRUE), ]
        ordered[[i]]  <- c(by_state[[i]][1, c("hospital", "state")])
      }
      result <- do.call(rbind, ordered)
      output <- as.data.frame(result, stringsAsFactors = FALSE)
      rownames(output) <- output[, 2]
    } else {
      stop('invalid num')
    }
  }
  return(output)
}

