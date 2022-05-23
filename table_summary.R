library(dplyr)

diabetes_df <- read.csv("/Users/daniella/desktop/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")

summary_table <- group_by(diabetes_df, Diabetes_012) %>%
  summarise(meanAge = mean(Age), meanBMI = mean(BMI), meanIncome = mean(Income)) %>% 
  round(digits = 0)
