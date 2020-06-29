# Quiz

# 1. The American Community Survey distributes downloadable data about
# United States communities. Download the 2006 microdata survey about
# housing for the state of Idaho using download.file() from here:
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# How many properties are worth $1,000,000 or more?
        
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "quiz1data1.csv")
data <- read.csv("./data/quiz1data1.csv")
nrow(data[which(data$VAL == 24),]) # 24 representa que la propiedad tiene un valor de $1000000 o más


# 2. Use the data you loaded from Question 1. Consider the variable
# FES in the code book. Which of the "tidy data" principles does this
# variable violate?

# Tidy data has one variable per column.

# Al leer la información de esta variable, se evidencia que cada 
# número representa algpun tipo de familia y entre cada tipo puede 
# variar de distintas maneras, por lo que para esta columna de los
# datos se tienen muchas vairables.

# 3. Download the Excel spreadsheet on Natural Gas Aquisition Program
# here:
        
# este sería el código, pero por algún problema con Rtools no me sirve la lectura del paquete xlsx
# fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
# download.file(fileUrl, destfile = paste0(getwd(), '/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'), method = "curl")
# dat <- xlsx::read.xlsx(file = "getdata%2Fdata%2FDATA.gov_NGAP.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
# sum(dat$Zip*dat$Ext,na.rm=T)
# Answer:
# 36534720


# 4. Read the XML data on Baltimore restaurants from here:
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml

# How many restaurants have zipcode 21231?

library(XML)
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
data <- xmlTreeParse(fileURL, useInternalNodes = TRUE) # lectura de los datos
rootNode <- xmlRoot(data) # fijar la raíz de los datos
xmlName(rootNode)
codigos <- xpathSApply(rootNode, "//zipcode", xmlValue) # extraer los zipcodes
length(codigos[which(codigos == "21231")]) # número de zipcodes que cumplen la condición


# 5. The American Community Survey distributes downloadable data about
# United States communities. Download the 2006 microdata survey about
# housing for the state of Idaho using download.file() from here:
        
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv


download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "quiz1data5.csv")
DT <- fread("./data/quiz1data5.csv", sep = ",")


# The following are ways to calculate the average value of the 
# variable "pwgtp15" broken down by sex. Using the data.table package,
# which will deliver the fastest user time?
        

system.time(DT[,mean(pwgtp15), by = SEX])
system.time(rowMeans(DT)[DT$SEX==1]) 
system.time(rowMeans(DT)[DT$SEX==2])
system.time(tapply(DT$pwgtp15, DT$SEX, mean))
system.time(sapply(split(DT$pwgtp15, DT$SEX), mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15))
system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(mean(DT$pwgtp15, by = DT$SEX))


Answer: DT[,mean(pwgtp15), by = SEX].