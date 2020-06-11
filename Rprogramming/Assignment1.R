# 1 Programming assignment 1 - Stephany Lobo

# 1. Función pollutantmean --------------------------------------------------

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of  the pollutant for which we will calcultate the
  ## mean; either "sulfate" or "nitrate"
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result
  medias <- c()
  
  for(numero in id){
    # arreglo de archivos
    archivos <- paste(getwd(), "/", directory, "/", 
                      formatC(numero, width=3, flag="0"), ".csv", sep = "")
    # lectura de archivos
    dato_numero <- read.csv(archivos)
    # extracción de datos relevantes
    datos <- dato_numero[pollutant]
    # filtro de datos faltantes
    medias <- c(medias, datos[!is.na(datos)])
  }
  # cálculo del promedio
  mean(medias)
}


# 2. función complete --------------------------------------------------------

complete <- function(directory, id = 1:332){
  ## 'directory' is a character vector of length 1 indicating the location of
  ## the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  
  ## where 'id' is the monitor ID number and 'nobs' is the number of complete
  ## cases
  
  # creación de un data frame
  completos <- data.frame(id = numeric(0), nobs = numeric(0))
  for (numero in id) {
    # arreglo de archivos
    archivos <- paste(getwd(), "/", directory, "/", 
                      formatC(numero, width=3, flag="0"), ".csv", sep = "")
    # lectura de archivos
    dato_numero <- read.csv(archivos)
    # extracción de datos relevantes
    datos <- dato_numero[(!is.na(dato_numero$nitrate)), ]
    datos <- dato_numero[(!is.na(dato_numero$sulfate)), ]
    nobs <- nrow(datos)
    completos <- rbind(completos, data.frame(id = numero,nobs = nobs))
  }
  completos
}

complete("specdata", c(2, 4, 8, 10, 12))

# 3. función corr1 -----------------------------------------------------------

corr <- function(directory, threshold = 0){
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the 
  ## number of completely observed observations (on all
  ## variables) requi?red to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  # creación de un vector vacío en donde se almacenarán los resultados
  resultados <- numeric(0)
  
  # utilización de la función complete, para ver cuantos datos están completos 
  # y así comparar con el límite (threshold).
  casos <- complete(directory)
  casos <- casos[casos$nobs >= threshold, ]

  # comprobar si se cumple la condición de que haya datos completos
  if(nrow(casos)>0){
    for(numero in casos$id){
      # arreglo de los nombres
      path <- paste(getwd(), "/", directory, "/", formatC(numero,width = 3, flag = "0"),
                    ".csv", sep = "") 
      # lectura de los datos
      datos <- read.csv(path)
      # extracción de los datos relevantes (los que no presentan NA)
      relevantes <- datos[(!is.na(datos$sulfate)), ]
      relevantes <- relevantes[(!is.na(relevantes$nitrate)), ]
      # extracción de las columnas en los datos que contienen a nitrato y sulfato
      sulfate_data <- relevantes["sulfate"]
      nitrate_data <- relevantes["nitrate"]
      # concatenación de los resultados en el vector vacío creado
      # anteriormente
      resultados <- c(resultados, cor(sulfate_data, nitrate_data))
    }
  }
  resultados
}

# Quiz 

## 1
round(pollutantmean("specdata", "sulfate", 1:10), 3)

## 2
round(pollutantmean("specdata", "nitrate", 70:72), 3)

## 3
round(pollutantmean("specdata", "sulfate", 34), 3)

## 4
round(pollutantmean("specdata", "nitrate"), 3)

## 5
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

## 6
cc <- complete("specdata", 54)
print(cc$nobs)

## 7
RNGversion("3.5.1")  
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

## 8
cr <- corr("specdata")                
cr <- sort(cr)   
RNGversion("3.5.1")
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

## 9
cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)    
RNGversion("3.5.1")
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

## 10
cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))
