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
highest_diabetes_age <- diabetes_df %>% 
  filter(Diabetes_012 == 2) %>% 
  group_by(Age) %>% 
  count(diabetes_type = Diabetes_012) %>% 
  summarise(highest_age = max(n, na.rm = TRUE)) %>% 
  filter(Age == 10)

lowest_diabetes_age <- diabetes_df %>% 
  filter(Diabetes_012 == 2) %>% 
  group_by(Age) %>% 
  count(diabetes_type = Diabetes_012) %>% 
  summarise(lowest_age = min(n, na.rm = TRUE)) %>% 
  filter(Age == 1)

# The age with the highest cases of diabetes is 10.
# The age with the lowest cases of diabetes is 1.

# What gender has the lowest count of diabetes? What about the highest?
highest_diabetes_sex <- diabetes_df %>% 
  filter(Diabetes_012 == 2) %>% 
  group_by(Sex) %>% 
  count(diabetes_type = Diabetes_012) %>% 
  summarise(highest_sex = max(n, na.rm = TRUE)) %>% 
  filter(Sex == 0)

lowest_diabetes_sex <- diabetes_df %>% 
  filter(Diabetes_012 == 2) %>% 
  group_by(Sex) %>% 
  count(diabetes_type = Diabetes_012) %>% 
  summarise(lowest_sex = min(n, na.rm = TRUE)) %>% 
  filter(Sex == 1)

# The male gender has the lowest count of diabetes.
# The female gender has the highest count of diabetes.

# What is the likelihood of someone to have CHD/MI while also having diabetes?
heart_disease <- diabetes_df %>% 
  filter(Diabetes_012 == 2) %>% 
  group_by(HeartDiseaseorAttack) %>% 
  count(diabetes = Diabetes_012)

heart_disease_zero <- heart_disease %>% filter(HeartDiseaseorAttack == 0) %>% pull(n)
heart_disease_one <- heart_disease %>% filter(HeartDiseaseorAttack == 1) %>% pull(n)

likelihood <- heart_disease %>% 
  mutate(ratio = heart_disease_one / heart_disease_zero) * 100

# Someone with diabetes has a likelihood of 28.68% chance of having heart disease.

# Reflection ------------------------------------------------------------
# Write a paragraph of reflection on the summary information calculated by your
# summary information function.
