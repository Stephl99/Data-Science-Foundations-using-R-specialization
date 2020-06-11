# Assignment 3 - Stephany Lobo
getwd()
setwd("C:/Users/ASUS/Desktop/Assignment3")
getwd()
ls()

## 1. read the 30 - day mortality rates for heart attack

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

dim(outcome)
names(outcome)
summary(outcome)
names(outcome)[23]
## To make a simple histogram of the 30-day death rates from heart attack 

outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])

## Because we originally read the data in as character (by specifying 
## colClasses = "character" we need to coerce the column to be numeric.
## You may get a warning about NAs being introduced but that is okay.

## 2. Finding the best hospital in a state

## Write a function called best that take two arguments: the 2-character
## abbreviated name of a state and an outcome name. The function reads the
## outcome-of-care-measures.csv file and returns a character vector with the
## name of the hospital that has the best (i.e. lowest) 30-day mortality for
## the specified outcome in that state. The hospital name is the name provided
## in the Hospital.Name variable. The outcomes can be one of "heart attack",
## "heart failure", or "pneumonia". Hospitals that do not have data on a
## particular outcome should be excluded from the set of hospitals when
## deciding the rankings.

source("best.R") # Al llamar la función source el nombre debe ir entre comillas
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

## 3. Ranking hospitals by outcome in a state

## Write a function called rankhospital that takes three arguments: the 
## 2-character abbreviated name of a state (state), an outcome (outcome), and
## the ranking of a hospital in that state for that outcome (num). The
## function reads the outcome-of-care-measures.csv file and returns a
## character vector with the name of the hospital that has the ranking
## specified by the num argument

source("rankhospital.R")
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)

## 4. Ranking hospitals in all states

## Write a function called rankall that takes two arguments: an outcome name
## (outcome) and a hospital ranking (num). The function reads the 
## outcome-of-care-measures.csv file and returns a 2-column data frame
## containing the hospital in each state that has the ranking specified in num.
## For example the function call rankall("heart attack", "best") would return
## a data frame containing the names of the hospitals that are the best in 
## their respective states for 30-day heart attack death rates. The function
## should return a value for every state (some may be NA). The first column in
## the data frame is named hospital, which contains the hospital name, and the
## second column is named state, which contains the 2-character abbreviation
## for the state name. Hospitals that do not have data on a particular outcome
## should be excluded from the set of hospitals when deciding the rankings.

source("rankall.R")
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

## Quiz

# 1.
best("SC", "heart attack")
# 2.
best("NY", "pneumonia")
# 3.
best("AK", "pneumonia")
# 4. 
rankhospital("NC", "heart attack", "worst")
# 5. 
rankhospital("WA", "heart attack", 7)
# 6. 
rankhospital("TX", "pneumonia", 10)
# 7. 
rankhospital("NY", "heart attack", 7)
# 8.
r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)
# 9.
r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)
# 10.
r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
