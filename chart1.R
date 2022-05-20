
library(dplyr)
library(ggplot2)

data <- read.csv("data/diabetes_012_health_indicators_BRFSS2015.csv", header = TRUE)
grouped <- data %>% group_by(Diabetes_012)

income_only <- grouped[c("Diabetes_012", "Income")]
table_income <- as.data.frame(table(income_only))

plot1 <- ggplot(table_income, aes(fill=Income, y=Freq, x=Diabetes_012)) + 
  geom_bar(position="fill", stat="identity")

print(plot1)