# November 15, Juuso Repo
# data source: UCI Machine Learning Repository, Student Performance Data
# https://archive.ics.uci.edu/ml/datasets/Student+Performance

# 3 read dataset and check structure and dimensions
mat = read.csv("~/IODS-project/data/student-mat.csv", sep =";", header = TRUE)
por = read.csv("~/IODS-project/data/student-por.csv", sep =";", header = TRUE)
str(mat)
dim(mat)
str(por)
dim(por)

# 4 join the datasets and explore data
library(dplyr)
join_by = c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")
mat_por <- inner_join(mat, por, join_by, suffix = c(".m",".p"))
str(mat_por)
dim(mat_por)

# 5 combine duplicated answers
alc <- select(mat_por, one_of(join_by))
# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]
# print out the columns not used for joining
notjoined_columns
# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# 6 average alcohol consumption
library(dplyr); library(ggplot2)
alc <- mutate(alc, alc_us = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_us > 2)

# 7 glimse
glimpse(alc)
write.csv(alc, file ="~/IODS-project/data/alc.csv")

