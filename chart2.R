library(dplyr)
library(ggplot2)

data <- read.csv("data/diabetes_012_health_indicators_BRFSS2015.csv", header = TRUE)

diabetes_age <- data %>% 
  select(Diabetes_012, Age)

plot2 <- ggplot(diabetes_age, aes(x = factor(Diabetes_012), y = Age, fill = factor(Diabetes_012))) +
  geom_boxplot(alpha = 0.5) +
  scale_fill_brewer(name = "Diabetes Classification", palette = "Paired") +
  ggtitle("Age Range Distribution Across Diabetes Cases", 
          subtitle = "0 indicates no diabetes. 1 indicates pre-diabetes. 2 indicates diabetes") +
  xlab("Without Diabetes, Pre-Diabetes, With Diabetes") +
  ylab("Age Range")

#diabetes_only <- data[c("Diabetes_012")]
#table_diabetes <- as.data.frame(table(diabetes_only))

# plot2 <- ggplot(diabetes_only, aes(x = Diabetes_012)) + 
#  geom_bar() +
#  gtitle("Quantities of Responses to Diabetes Survey",
        #  subtitle = 
           # "0 indicates no diabetes. 1 indicates pre-diabetes. 2 indicates diabetes")

print(plot2)
