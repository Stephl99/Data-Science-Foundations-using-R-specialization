# Quiz 3

# 1. The American Community Survey distributes downloadable data about
# United States communities. Download the 2006 microdata survey about
# housing for the state of Idaho using download.file() from here:

# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# and load the data into R. The code book, describing the variable names is here:
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

# Create a logical vector that identifies the households on greater than 10 acres
# who sold more than $10,000 worth of agriculture products. Assign that logical 
# vector to the variable agricultureLogical. Apply the which() function like this
# to identify the rows of the data frame where the logical vector is TRUE.

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "./data/quiz3data1.csv")

## Lectura de la base de datos
data <- read.csv("./data/quiz3data1.csv")

library(dplyr)

## Creación de la condición
agricultureLogical <- data$ACR == 3 & data$AGS == 6

## Obtención de los índices
which(agricultureLogical)[1:3]

# Respuesta: 125 238 262

# 2. Using the jpeg package read in the following picture of your instructor
# into R https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the
# resulting data? (some Linux systems may produce an answer 638 different for
# the 30th quantile)

library(jpeg)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
              destfile = "./data/jefrey.jpg", mode = "wb")

## Lectura del archivo
imagen <- readJPEG("./data/jefrey.jpg", native=TRUE)

## Obtención de los valores solicitados
quantile(imagen, probs = c(0.3, 0.8))

# Respuesta: -15258512 -10575416

# 3. Load the Gross Domestic Product data for the 190 ranked countries in this
# data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile = "./data/quiz3data3Gross.csv")

# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile = "./data/quiz3data3Educ.csv")

# Match the data based on the country shortcode. How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is last).
# What is the 13th country in the resulting data frame?
        
# Original data sources:
        
# http://data.worldbank.org/data-catalog/GDP-ranking-table

# http://data.worldbank.org/data-catalog/ed-stats

library(data.table)

## Lectura del primer archivo
Gross <- fread("./data/quiz3data3Gross.csv", skip = 9, nrows = 190,
               select = c(1,2,4,5), col.names = c("CountryCode", "Rank",
                                                  "Economy", "Total"))
dim(Gross)

## Lectura del segundo archivo
Educ <- fread("./data/quiz3data3Educ.csv")
dim(Educ)

## Unión de las dos bases de datos
data <- merge(Gross, Educ, by = "CountryCode")

# el número de filas de data es el número de coincidencias de filas que hubo
# en ambas bases de datos

## Ordenación de la base de datos de acuerdo a la varaible GDP Rank
data <- data %>% arrange(desc(Rank))

# Respuesta:

paste(nrow(data), "matches, 13th country is", data$Economy[13])

# 4. What is the average GDP ranking for the "High income: OECD" and "High 
# income: nonOECD" group?

# GDP se refiere a GDP ranking, es decir, a la variable Rank

## Obtención de la tabla con los valores solicitados
data_grouped <- data %>% 
                group_by(`Income Group`) %>%
                summarise(average = mean(Rank)) %>%
                print

# 5. Cut the GDP ranking into 5 separate quantile groups. Make a table versus
# Income.Group. How many countries are Lower middle income but among the 38 
# nations with highest GDP?

library(Hmisc)

## Creación de una nueva varaible cualitativa que se forma a partir de agrupar
## una variable cuantitativa
data$groups_rank <- cut2(data$Rank, g = 5)

## Creación de la tabla que asocia los valores de la varaible creada anteriormente
## con la variable `income group`
tabla <- table(data$groups_rank, data$`Income Group`)

# Respuesta: 
tabla[1, "Lower middle income"]
