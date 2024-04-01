## Instal the packages 
install.packages("corrplot")
## Load the packages
options(warn.conflicts = FALSE)
library(dplyr)
library(tidyr)
library(ggplot2)
library(corrplot)


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

#Lets now perform some Exploratory Data Analysis; 
#For this, we are going to generate some statistical summaries for the variables
#We are then going to move on to a correlation analysis and calculate correlation coefficients for the same
#Finally, we would be building some visualisations in order to better understand our data.

#Lets begin with the statistical summaries
# Summary statistics for each variable
summary(sleep_data)

# Generate a quick overview of the structure and summary statistics
glimpse(sleep_data)

## What does this tell us? 

#now lets move on to the correlations between the variables
# Select only numerical variables for correlation analysis
numerical_data <- select(sleep_data, Age, Sleep.efficiency, Caffeine.consumption, Alcohol.consumption, Exercise.frequency, REM.sleep.percentage, Deep.sleep.percentage, Light.sleep.percentage)

# Calculate correlation matrix
correlation_matrix <- cor(numerical_data, use = "complete.obs") # Handles missing data by using complete observations


# View the correlation matrix
print(correlation_matrix)

# For a more visual representation, you can use the corrplot package
corrplot(correlation_matrix, method = "circle")

#What does this tell us??

#Now lets move on to some more Visualisations

# Histogram of sleep efficiency
ggplot(sleep_data, aes(x = Sleep.efficiency)) + geom_histogram(binwidth = 5, fill = "blue", color = "black") + theme_minimal() + labs(title = "Distribution of Sleep Efficiency")

# Box plot for sleep efficiency by gender
ggplot(sleep_data, aes(x = Gender, y = Sleep.efficiency)) + geom_boxplot() + theme_minimal() + labs(title = "Sleep Efficiency by Gender")

#now for visualisations of sleep efficiency with possible predictors
# Scatter plot for sleep efficiency and caffeine consumption
ggplot(sleep_data, aes(x = Caffeine.consumption, y = Sleep.efficiency)) + geom_point() + theme_minimal() + labs(title = "Sleep Efficiency vs. Caffeine Consumption")

# Scatter plot with a smooth line for age and sleep efficiency
ggplot(sleep_data, aes(x = Age, y = Sleep.efficiency)) + geom_point() + geom_smooth(method = "lm", color = "red") + theme_minimal() + labs(title = "Sleep Efficiency vs. Age")
