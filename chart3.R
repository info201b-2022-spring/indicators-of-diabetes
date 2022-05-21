
library(dplyr)
library(ggplot2)

data <- read.csv("data/diabetes_012_health_indicators_BRFSS2015.csv", header = TRUE)
grouped <- data %>% group_by(Diabetes_012)

bmi_only <- grouped[c("Diabetes_012", "BMI")]
bmi_avg <- bmi_only %>%
  summarise_at(vars(BMI), list(avg = mean))

plot3 <- ggplot(bmi_avg, aes(x = Diabetes_012, y = "Average BMI")) + 
  geom_bar(stat = "identity") +
  ggtitle("Average BMI Amongst Diabetes Cases", 
          subtitle = 
            "0 indicates no diabetes. 1 indicates pre-diabetes. 2 indicates diabetes")

print(plot3)
