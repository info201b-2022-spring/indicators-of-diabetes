library(dplyr)

setwd("C:/Users/brand/INFO 201/final-projects-daniellatsing/data")
diabetes_df <- read.csv("diabetes_012_health_indicators_BRFSS2015.csv")

summary_table <- group_by(diabetes_df, Diabetes_012) %>%
  summarise(meanAge = mean(Age), meanBMI = mean(BMI), meanIncome = mean(Income))