# Juuso Repo, Nov 4 2019, E2 Linear regression
# data source: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt

# read and test data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
str(lrn14)
dim(lrn14)

# combine variables
library(dplyr)
deep_q <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
stra_q <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
surface_q <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")

deep_columns <- select(lrn14, one_of(deep_q))
lrn14$deep <- rowMeans(deep_columns)
stra_columns <- select(lrn14, one_of(stra_q))
lrn14$stra <- rowMeans(stra_columns)
surface_columns <- select(lrn14, one_of(surface_q))
lrn14$surf <- rowMeans(surface_columns)

# create analysis dataset
keep_columns <- c("gender", "Age", "Attitude", "Points", "stra", "surf", "deep") 
lrning14 <- select(lrn14, one_of(keep_columns))
lrning14 <- filter(lrning14, Points != 0)
dim(lrning14)
str(lrning14)

# set working dir and save dataset
setwd("~/IODS-project")
write.csv(lrning14, file = "learning2014.csv")

# read the dataset
lr14 <- read.csv("learning2014.csv")
head(lr14)
str(lr14)
dim(lr14)



# ANALYSIS - read data
library(dplyr)
lr14 <- read.csv("learning2014.csv")
lr14 <- select(lr14, -1)
head(lr14)
str(lr14)
dim(lr14)


# EDA
library(ggplot2)
library(GGally)
# ggpairs for good overview
p3 = ggpairs(lr14, aes(col=gender), lower = list(combo = wrap("facethist", bins = 20)))
p3
# Bubble chart
p4 = ggplot(lr14, aes(x=Attitude, y=Points, size=stra, col=gender)) + geom_point(alpha=0.7) + scale_size(range = c(.1, 12), name="stra")
p4

# not included: p1 = pairs(lr14[-1], col=lr14$gender)
# not included: p2 = ggplot(lr14, aes(y=Age, y=Points)) + geom_boxplot()


# Multiple linear regression
qplot(Points, Attitude, data = lr14) + geom_smooth(method = "lm")

model_1 <- lm(Points ~ Attitude + stra + deep, data = lr14)
summary(model_1)

model_2 <- lm(Points ~ Attitude, data = lr14)
summary(model_2)

# Model diagnostics
# Using par-fuction to place following 4 graphs to the same plot
par(mfrow = c(2,2))
plot(model_2, which = c(2,1,5))


