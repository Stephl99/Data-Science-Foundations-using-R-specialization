
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
  
  for(monitor in id){
    # arreglo de archivos
    archivos <- paste(getwd(), "/", directory, "/", 
                      formatC(monitor, width=3, flag="0"), ".csv", sep = "")
    # lectura de archivos
    monitor_datos <- read.csv(archivos)
    # extracción de datos relevantes
    datos <- monitor_datos[pollutant]
    # filtro de datos faltantes
    medias <- c(medias, datos[!is.na(datos)])
  }
  # cálculo del promedio
  mean(medias)
}
pollutantmean("specdata", "sulfate", 1:10)
