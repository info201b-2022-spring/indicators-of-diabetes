# Summary ---------------------------------------------------------------
# Store summary information into a list.
# Compute at least 5 different values from your data that you believe are pertinent to share.
diabetes_df <- read.csv("/Users/daniella/desktop/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")

# What is the average BMI of those without diabetes? What about pre-diabetes? 
# What about those with diabetes?
mean_BMI <- diabetes_df %>% 
  group_by(Diabetes_012) %>% 
  summarise(sum_BMI = mean(BMI, na.rm = TRUE))
  
avg_without_diabetes <- mean_BMI %>% 
  filter(Diabetes_012 == 0) %>% 
  select(sum_BMI)
  
avg_pre_diabetes <- mean_BMI %>% 
  filter(Diabetes_012 == 1) %>% 
  select(sum_BMI)
  
avg_diabetes <- mean_BMI %>% 
  filter(Diabetes_012 == 2) %>% 
  select(sum_BMI) 

# The average BMI of those without diabetes is 27.74252.
# The average BMI of people pre-diabetes is 30.72447.
# THe average BMI of people with diabetes is 34.94401.
  
# Is there a correlation between diabetes and income?

# What age has the highest count of diabetes? What about the lowest?

# What gender has the lowest count of diabetes? What about the highest?

# What is the likelihood of someone to have CHD/MI while also having diabetes?

# Reflection ------------------------------------------------------------
# Write a paragraph of reflection on the summary information calculated by your
# summary information function.
