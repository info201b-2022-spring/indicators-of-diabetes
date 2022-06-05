
library(dplyr)
library(ggplot2)

#data <- read.csv("data/diabetes_012_health_indicators_BRFSS2015.csv", header = TRUE)
data <- read.csv("C:/Users/rober/Documents/College/Year 2/Quarter 3/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")

grouped <- data %>% group_by(Diabetes_012)

income_only <- grouped[c("Diabetes_012", "Income")]
table_income <- as.data.frame(table(income_only))

plotqqq <- ggplot(table_income, aes(fill=Income, y=Freq, x=Diabetes_012)) + 
  geom_bar(position="fill", stat="identity") +
  ggtitle("Income Amongst Diabetes cases", subtitle = 
            "0 indicates no diabetes. 1 indicates pre-diabetes. 2 indicates diabetes")

print(plot1)