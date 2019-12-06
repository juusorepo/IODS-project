# Juuso Repo, Dec 5, 2019

# libraries
library(dplyr)
library(tidyr)

# read and save datasets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)
write.csv(BPRS, file = "~/IODS-project/data/bprs.csv")
write.csv(RATS, file = "~/IODS-project/data/rats.csv")

names(BPRS)
names(RATS)
str(BPRS)
str(RATS)

# categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$Group <- factor(RATS$Group)
RATS$ID <- factor(RATS$ID)
glimpse(RATS)
glimpse(BPRS)

# Convert datasets from wide to long form and add week and time variables
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,5)))
BPRSL <- BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject) %>% mutate(weeks = as.integer(substr(weeks,5,5)))
glimpse(RATSL)
glimpse(BPRSL)
names(BPRSL)
names(RATSL)
str(BPRSL)
str(RATSL)

# save datasets for analysis
write.csv(BPRSL, file = "~/IODS-project/data/bprsl.csv")
write.csv(RATSL, file = "~/IODS-project/data/ratsl.csv")
