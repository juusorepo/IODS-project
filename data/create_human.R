# November 24, 2019.  Juuso Repo
# Human development and Gender inequality datas

# libraries
library(tidyr)
library(dplyr)

# read the datasets
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# explore the datasets
str(hd)
dim(hd)
head(hd)
summary(hd)
str(gii)
dim(gii)
head(gii)
summary(gii)

# shorten variable names
names(hd) <- c("HDI.Rank", "country", "hdi", "le", "eye", "uoe", "gni", "gni_rank")  
str(hd)
names(gii) <- c("gii.rank", "country", "gii", "matmor", "birth", "repinp", "secedF", "secedM", "labourF", "labourM")
str(gii)

# create new variables, female-male ratios
gii$edu2FMratio <- gii$secedF / gii$secedM
gii$labFMratio <- gii$labourF / gii$labourM

# join the datasets and save the file
human <- inner_join(hd, gii, "country")
dim(human)
glimpse(human)
write.csv(human, file ="~/IODS-project/data/human.csv")

# Exercise 5 begins here

# read the data
read.csv(file ="~/IODS-project/data/human.csv") %>% head()

# string manipulation
library(stringr)
colnames(human)
str(human$gni)
human$gni <- str_replace(human$gni, pattern = ",", replace = "") %>% as.numeric

# Keep following variables: 
# "country"       --> country name
# "edu2FMratio"   --> ratio of second education of female/male
# "labFMratio"    --> ratio of labour forced female/male
# "eye"           --> expected years of schooling
# "le"            --> life expectancy at birth
# "gni"           --> Gross National Income per capita
# "matmor"        --> maternal mortality ratio
# "birth"         --> adolescent birth rate
# "repinp"        --> percetange of female representatives in parliament

keep <- c("country", "edu2FMratio", "labFMratio", "eye", "le", "gni", "matmor", "birth", "repinp")
human <- select(human, one_of(keep))

# filter out rows with missing values
human <- filter(human, complete.cases(human))
dim(human)

# filter out regions, keep countries
human$country
tail(human, 10)
# regions are last 7 rows
# get a row number for the first region row and filter
last <- nrow(human) -7
# filter, first feature is row, second is for columns
human <- human[1:last, ]
tail(human, 10)

# add countries as rownames
rownames(human) <- human$country
human <- select(human, -"country")
head(human)
dim(human)

# save dataset
write.csv(human, file ="~/IODS-project/data/human.csv", row.names = TRUE)



