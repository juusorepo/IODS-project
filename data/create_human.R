# November 24, 2019.  Juuso Repo
# Human development and Gender inequality datas

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
hd$Gross.National.Income..GNI..per.Capita  
# uups, this only added a new one, lets delete it
hd$gni <- NULL
# found a better way
names(hd) <- c("HDI.Rank", "country", "hdi", "le", "eye", "uoe", "gni", "gni_rank")  
str(hd)
names(gii) <- c("gii.rank", "country", "gii", "matmor", "birth", "repinp", "secedF", "secedM", "labourF", "labourM")
str(gii)

# create new variables, female-male ratios
gii$edu2FM <- gii$secedF / gii$secedM
gii$labFM <- gii$labourF / gii$labourM

# join the datasets and save the file
human <- inner_join(hd, gii, "country")
dim(human)
glimpse(human)
write.csv(human, file ="~/IODS-project/data/human.csv")
