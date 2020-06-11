install.packages("data.table")
library(data.table)

pollutantmean <- function(directory, pollutant, id = 1:332){
  # vector vacío
  pollutants <- c()
  # lista de archivos
  fileNames <- list.files(directory)
  for (i in id) {
    # arreglo de los nombres de los archivos
    fileNames <- paste(directory, '/', fileNames[i], sep = "")
    # lectura de los archivos
    data = read.csv(fileNames, header = TRUE)
    
    #concatenación de los archivos
    pollutants <- c(pollutants, data[,pollutant])
    
  }
  
  
  # cálculo de la media
  pollutants_mean = mean(pollutants, na.rm=TRUE)
  
  pollutants_mean
}

pollutantmean("specdata", "sulfate", 1:10)
?formatC
xx <- pi * 10^(-5:4)
cbind(format(xx, digits = 4), formatC(xx))


directory <- "specdata"
id <- c(10:14)
fileNames <- paste(directory, '/', formatC(id, width=3, flag="0"), ".csv",sep = "" )
lst <- lapply(fileNames, read.csv)
ab <- lapply(fileNames, read.csv)
dt <- rbindlist(lst)
lista <- rbind(lst)

?rbindlist
?fread
?lapply

pollutants<- c()
pollutants <- c(pollutants, data[,pollutant])

?list.files
fileNames <- list.files(directory)

########################################33

pollutants <- c()
directory <-"specdata"
fileNames <- list.files(directory)

