# Gestión de marcos de datos con dplyr - Herramientas básicas
library(dplyr)

# 1. La función select() ------------------------------------------------------

# esta es una base de datos sobre polución y clima de los años 1987 hasta 2005,
# los datos fueron recolectados a diario.

## Lectura
chicago <- readRDS("./data/chicago.rds")
dim(chicago)
str(chicago)
names(chicago)

# Una de las cosas que se puede hacer con la función select() es seleccionar
# columnas de un dataframe a partir de sus nombres y no de sus índices.

## Selección de las primeras 3 columnas de la base de datos
head(select(chicago, city:dptp))

# En resumen, select() puede ser usado para tomar subconjuntos de una base de 
# datos teniendo como referencia simplemente los normbes de las columnas

## Selección de todas las columnas excepto las 3 primeras
head(select(chicago, -(city:dptp)))

## El código equivalente con el paquete base de R sería 
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])

# 2. La función filter() --------------------------------------------------------

# La función filter() se usa básicamente para tomar subconjuntos de filas de una
# base de datos a partir de condiciones lógicas

## selección de las filas del data frame chicago para las cuales la variable
## pm25mean2 tiene un valor mayor a 30
chic.f <- filter(chicago, pm25tmean2 > 30)

## Uso de la función select() para mostrar solo las primeras 3 columnas del
## subconjunto de datos sacado anteriormente
head(select(chic.f, 1:3, pm25tmean2), 10)

# Se pueden usar condiciones lógicas complicadas para la extracción de filas
# que cumplan condiciones específicas.
# 3. La función arrange() -------------------------------------------------------

# La función arrange() basicamente se usa para reordenar las filas de un dataframe
# a partir de los valores de una columna. Reordenar las filas de un marco de datos
# (mientras se conserva el orden correspondiente de otras columnas) es normalmente
# una molestia en R.

## Ordenamiento del dataframe chicago de acuerdo a la variable date
chicago <- arrange(chicago, date)
head(select(chicago, date, pm25tmean2), 3)
tail(select(chicago, date, pm25tmean2), 3)

# Se puede usar también las función desc para ordenar de manera descendente.

## Ordenamiento del dataframe chicago de acuerdo a la variable date de manera
## descendente.
chicago <- arrange(chicago, desc(date))
head(select(chicago, date, pm25tmean2), 3)
tail(select(chicago, date, pm25tmean2), 3)

# 4. La función rename() --------------------------------------------------------

# Renombrar variables en R es sorprendentemente díficil de hacer.

chicago <- readRDS("./data/chicago.rds")
head(chicago)

## Renombramiento de las columnas  dptp y pm25mean2 como dewpoint y pm25,
## respectivamente.
chicago <- rename(chicago, dewpoint = dptp, pm25 = pm25tmean2)

head(chicago)

# 5. La función mutate() --------------------------------------------------------

# La función mutate() es usada para transformar variables existentes o crear 
# nuevas variables

## Creación de la variable pm25detrend, que es el valor promedio de la variable
## pm25
chicago <- mutate(chicago, pm25detrend = mean(pm25, na.rm=TRUE))
head(chicago)

# 6. La función group_by() ------------------------------------------------------

# La función group_by() básicamente permite dividir bases de datos de acuerdo a
# ciertas variables categóricas.

## Creación de la variable tempcat que divide los datos en hot o cold de 
## acuerdo a la temperatura registrada ese día (tmpd).
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))

## Creación de un nuevo data frame con la agrupación de los datos según la 
## variable tempcat
hotcold <- group_by(chicago, tempcat)
head(hotcold)

# 7. La función summarize() ---------------------------------------------------

# La función summarize() genera estadísticos de resumen de diferentes variables
# en un data frame, posiblemente sin estratos.


summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2),
          no2 = median(no2tmean2))

# También podría clasificar el conjunto de datos en otras variables, por 
# ejemplo, si se quisiera hacer un resumen de cada año en el conjunto de datos,
# podríamos hacer lo siguiente:

## Creación de la variable year en el data frame
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)

## Creación del data frame years a partir de la agrupación de la variable years
years <- group_by(chicago, year)

## Creación del marco de datos con el resumen de cada año
summarize(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2),
           no2 = median(no2tmean2))

# 8. El operador de tubería %>% ------------------------------------------------------------

# El operador %>% es implementado por el paquete dplyr y permite encadenar 
# distintas operaciones juntas, de forma que se pueda leer más fácilmente las
# operaciones que se están realizando.

## El siguiente comando, usa la función mutate para crear la varaible month,
## luego se hace agrupación a partir de esta variable con la función group_by
## y por último, se generan estadísticos de resumen para algunas variables
## a partir de los grupos hechos con anterioridad.
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% 
        summarize(pm25 = mean(pm25, na.rm = TRUE), 
                  o3 = max(o3tmean2, na.rm = TRUE), 
                  no2 = median(no2tmean2, na.rm = TRUE))

# Es bueno notar que al usar el operador de tubería, solo se necesita 
# especificar el data frame con el que se trabaja al inicio del código.

# El operador de tubería es una herramienta muy útil ya que previene la 
# asignación de variables temporales que luego son necesitadas por otras 
# funciones.

