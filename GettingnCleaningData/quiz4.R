# Quiz 4 

# 1. The American Community Survey distributes downloadable data about United States
# communities. Download the 2006 microdata survey about housing for the state of Idaho
# using download.file() from here:

# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
 
# Apply strsplit() to split all the names of the data frame on the characters "wgtp".
# What is the value of the 123 element of the resulting list?

# es la misma base de datos de la pregunta 1 del quiz 3

data <- read.csv("./data/quiz3data1.csv")

?strsplit
lista <- strsplit(names(data), "wgtp")

# Respuesta
lista[123]

# 2. Load the Gross Domestic Product data for the 190 ranked countries in this data
# set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

# Remove the commas from the GDP numbers in millions of dollars and average them. 
# What is the average?
        
# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile = "./data/quiz4data2.csv")

data <- read.csv("./data/quiz4data2.csv")

library(data.table)
data <- fread("./data/quiz3data3Gross.csv", skip = 9, nrows = 190,
              select = c(1,2,4,5), col.names = c("CountryCode", "Rank",
                                                 "Economy", "Total"))
data$Total <- gsub(",", "", data$Total)
data$Total <- as.integer(data$Total)
mean(data$Total, na.rm = TRUE)

# 3. In the data set from Question 2 what is a regular expression that would allow 
# you to count the number of countries whose name begins with "United"? Assume that
# the variable with the country names in it is named countryNames. How many countries
# begin with United?

names(data) <- c("CountryCode", "Rank", "countryNames", "Total")

# Respuesta: 
grep("^United",Rank[, Country])

# 4. Load the Gross Domestic Product data for the 190 ranked countries in this data
# set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

# Match the data based on the country shortcode. Of the countries for which the end
# of the fiscal year is available, how many end in June?
        
# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats

# son los mismo datos de la pregunta 3 del quiz 3

Gross <- fread("./data/quiz3data3Gross.csv", skip = 9, nrows = 190,
               select = c(1,2,4,5), col.names = c("CountryCode", "Rank",
                                                  "Economy", "Total"))
Educ <- fread("./data/quiz3data3Educ.csv")

data <- merge(Gross, Educ, by = "CountryCode")

head(data)

length(grep("^Fiscal year end: June", data$`Special Notes`))

# 5. You can use the quantmod (http://www.quantmod.com/) package to get historical 
# stock prices for publicly traded companies on the NASDAQ and NYSE. Use the
# following code to download data on Amazon's stock price and get the times the data
# was sampled.

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

tiempos <- data.table(fechas = sampleTimes)

dosmil12 <- tiempos[tiempos$fechas >= "2012-01-01" & tiempos$fechas < "2013-01-01"] 

mondays <- tiempos[tiempos$fechas >= "2012-01-01" & tiempos$fechas < "2013-01-01"
                   & weekdays(tiempos$fechas) == "lunes"]

# Respuesta
paste(dim(dosmil12)[1], dim(mondays)[1])

