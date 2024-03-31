## Load the packages
options(warn.conflicts = FALSE)
library(dplyr)
library(tidyr)
library(ggplot2)

## Load the dataset
sleep_data <- read.csv("https://raw.githubusercontent.com/wsl0917/stat306-group-project/main/Sleep_Efficiency.csv")

## View the summary of the dataset 
head(sleep_data)
tail(sleep_data)
summary(sleep_data)

# Cleaning the dataset
# Remove 'Bedtime' and 'Wakeup time' columns
sleep_data <- select(sleep_data, -Bedtime, -Wakeup.time)
head(sleep_data)
tail(sleep_data)
# The decision to remove the "Bedtime" and "Wakeup time" columns from the
# dataset is because these variables might not directly influence sleep 
# efficiency and including them could create redundancy. Sleep efficiency 
# measures how well someone sleeps during a specific time period, which is
# already captured by other variables like total sleep time.

# We set "Male" as the baseline category for the categorical variable "Gender"
# in the regression analysis.

# Convert gender variable to factor
sleep_data$Gender <- as.factor(sleep_data$Gender)
# Set "male" as the baseline
sleep_data$Gender <- relevel(sleep_data$Gender, ref = "Male")

# We set "No" as the baseline category for the categorical variable 
# "Smoking.status".

# Convert Smoking.status to a factor variable
sleep_data$Smoking.status <- as.factor(sleep_data$Smoking.status)
# Set "No" as the baseline
sleep_data$Smoking.status <- relevel(sleep_data$Smoking.status, ref = "No")

# We noticed that some data are missing. For the accuracy of the analysis, 
# we decided to delete the rows with missing values.

# Delete rows with missing data in each column
sleep_data <- na.omit(sleep_data)

head(sleep_data)
tail(sleep_data)
