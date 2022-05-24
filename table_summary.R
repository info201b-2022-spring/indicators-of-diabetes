library(dplyr)

setwd("C:/Users/brand/INFO 201/final-projects-daniellatsing/data")
diabetes_df <- read.csv("diabetes_012_health_indicators_BRFSS2015.csv")

summary_table <- group_by(diabetes_df, Diabetes_012) %>%
  summarise(numRespondants = length(Diabetes_012), 
            meanAge = mean(Age), 
            meanBMI = mean(BMI), meanIncome = mean(Income), 
            highCholesterol = sum(HighChol), highBP = sum(HighBP), 
            Avg.Days.Poor.Phys.Health = mean(PhysHlth), 
            Avg.Days.Poor.Mental.Health = mean(MentHlth)) %>% 
  round(digits = 0)

summary_table$Diabetes_012[1] <- "No Diabetes" 
summary_table$Diabetes_012[2] <- "Pre-Diabetes" 
summary_table$Diabetes_012[3] <- "Diabetes" 

colnames(summary_table)[1] <- "Diabetes Classification"
  
