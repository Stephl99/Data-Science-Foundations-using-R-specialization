# Quiz 2

# 1. Register an application with the Github API here 
# https://github.com/settings/applications. Access the API to get information on
# your instructors repositories (hint: this is the url you want
# "https://api.github.com/users/jtleek/repos"). Use this data to find the time that
# the datasharing repo was created. What time was it created?

# This tutorial may be useful
# (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also
# need to run the code in the base R package and not R studio.


library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "c40c3fc528206daeec89",
                   secret = "a1614e9c3bf1e90e2978c0d082e5d9069048b80a")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos ", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)

# Respuesta: "2013-11-07T13:25:07Z"

# 2. The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with the 
# dbSendQuery command in RMySQL.

# Download the American Community Survey data and load it into an R object 
# called acs

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile = "./data/quiz2data2.csv")
acs <- read.csv("./data/quiz2data2.csv")

# Which of the following commands will select only the data for the probability
# weights pwgtp1 with ages less than 50?

library(sqldf)
sqldf("select pwgtp1 from acs")
sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select * from acs")
sqldf("select * from acs where AGEP < 50 and pwgtp1")

# Respuesta: sqldf("select pwgtp1 from acs where AGEP < 50")

# 3. Using the same data frame you created in the previous problem, what is the
# equivalent function to unique(acs$AGEP)

unique(acs$AGEP)

sqldf("select distinct AGEP from acs") # este si

sqldf("select unique AGEP from acs") # da error

sqldf("select AGEP where unique from acs") # da error

sqldf("select distinct pwgtp1 from acs") # da muchos datos

# Respuesta: sqldf("select distinct AGEP from acs")

# 4. How many characters are in the 10th, 20th, 30th and 100th lines of HTML
# from this page: http://biostat.jhsph.edu/~jleek/contact.html

htmlUrl <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(htmlUrl)
close(htmlUrl)

nchar(htmlCode[10]) # número de carácteres en la línea 10
nchar(htmlCode[20]) # número de carácteres en la línea 20
nchar(htmlCode[30]) # número de carácteres en la línea 30
nchar(htmlCode[100]) # número de carácteres en la línea 100

# Respuesta: 45 31 7 25

# 5. Read this data set into R and report the sum of the numbers in the fourth
# of the nine columns.

?read.fwf

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
data <- read.fwf(url, skip = 4, 
                 widths = c(-1, 9, -5, 4, 4, -5, 4, 4, -5, 4, 4, -5, 4, 4),
                 header = FALSE)
head(data)

# suma de los valores de la cuarta columna
sum(data$V4)

# Respuesta: 32426.7