# Lectura de archivo XML

getwd()
library(XML)
doc <- xmlTreeParse("./data/simple.xml", useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

# Acceso directo a partes del documento XML

rootNode[[1]]
rootNode[[1]][[1]]

# Acceso programático a partes del documento XML

xmlSApply(rootNode,xmlValue)

# Lectura de archivo JSON

library(jsonlite)

# La función fromJSON nos entrega un data frame estructurado
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

names(jsonData$owner)

names(jsonData$owner$login) # este comando no entrega lo mismo que en el ejemplo

# Pasar un data frame a formato JSON

myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)
