
library(dplyr)
library(ggplot2)

data <- read.csv("data/diabetes_012_health_indicators_BRFSS2015.csv", header = TRUE)

diabetes_only <- data[c("Diabetes_012")]
#table_diabetes <- as.data.frame(table(diabetes_only))

plot2 <- ggplot(diabetes_only, aes(x=Diabetes_012)) + 
  geom_bar()

print(plot2)