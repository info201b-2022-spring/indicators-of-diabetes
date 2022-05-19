
# Summary ---------------------------------------------------------------
# Load libraries
library("dplyr")

# Compute at least 5 different values from your data that you believe are pertinent to share.
diabetes_df <- read.csv("/Users/daniella/desktop/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")

# What is the average BMI of those without diabetes? What about pre-diabetes? 
# What about those with diabetes?
mean_BMI <- diabetes_df %>% 
  group_by(Diabetes_012) %>% 
  summarise(sum_BMI = mean(BMI, na.rm = TRUE))
  
avg_without_diabetes <- mean_BMI %>% 
  filter(Diabetes_012 == 0) %>% 
  pull(sum_BMI)
  
avg_pre_diabetes <- mean_BMI %>% 
  filter(Diabetes_012 == 1) %>% 
  pull(sum_BMI)
  
avg_diabetes <- mean_BMI %>% 
  filter(Diabetes_012 == 2) %>% 
  pull(sum_BMI) 

# The average BMI of those without diabetes is 27.74252.
# The average BMI of people pre-diabetes is 30.72447.
# THe average BMI of people with diabetes is 34.94401.
  
# Is there a correlation between diabetes and income?
correlation_applicable <- diabetes_df %>% 
  group_by(Income) %>% 
  filter(Diabetes_012 == 2) %>% 
  count(Diabetes_012)

correlation_total_surveyed <- diabetes_df %>% 
  group_by(Income) %>% 
  count(Diabetes_012) %>% 
  summarize(total = sum(n))

combine <- merge(correlation_applicable, correlation_total_surveyed) %>% 
  mutate(ratio = n / total)

lowest_income <- combine %>%
  filter(Income == 1) %>% 
  pull(ratio)

highest_income <- combine %>% 
  filter (Income == 8) %>% 
  pull(ratio)

# There is a inversely proportional relationship where those in lower income are
# more likely to have diabetes while those in higher income are less likely to 
# have diabetes. This could be due to a lack of access to healthcare, or due to
# a lack of access to healthier food.

# What age has the highest count of diabetes? What about the lowest?
highest_diabetes_age <- diabetes_df %>% 
  filter(Diabetes_012 == 2) %>% 
  group_by(Age) %>% 
  count(diabetes_type = Diabetes_012) %>% 
  summarise(highest_age = max(n, na.rm = TRUE)) %>% 
  filter(highest_age == 6558) %>% 
  pull(Age)

lowest_diabetes_age <- diabetes_df %>% 
  filter(Diabetes_012 == 2) %>% 
  group_by(Age) %>% 
  count(diabetes_type = Diabetes_012) %>% 
  summarise(lowest_age = min(n, na.rm = TRUE)) %>% 
  filter(lowest_age == 78) %>% 
  pull(Age)

# The age with the highest cases of diabetes is 10.
# The age with the lowest cases of diabetes is 1.

# What gender has the lowest count of diabetes? What about the highest?
highest_diabetes_sex <- diabetes_df %>% 
  filter(Diabetes_012 == 2) %>% 
  group_by(Sex) %>% 
  count(diabetes_type = Diabetes_012) %>% 
  summarise(highest_sex = max(n, na.rm = TRUE)) %>% 
  filter(highest_sex == 18411) %>% 
  pull(Sex)

lowest_diabetes_sex <- diabetes_df %>% 
  filter(Diabetes_012 == 2) %>% 
  group_by(Sex) %>% 
  count(diabetes_type = Diabetes_012) %>% 
  summarise(lowest_sex = min(n, na.rm = TRUE)) %>% 
  filter(lowest_sex == 16395) %>% 
  pull(Sex)

# The male gender has the lowest count of diabetes of 16935.
# The female gender has the highest count of diabetes of 18411.

# What is the likelihood of someone to have CHD/MI while also having diabetes?
heart_disease <- diabetes_df %>% 
  filter(Diabetes_012 == 2) %>% 
  group_by(HeartDiseaseorAttack) %>% 
  count(diabetes = Diabetes_012)

heart_disease_zero <- heart_disease %>% 
  filter(HeartDiseaseorAttack == 0) %>% 
  select(n) %>% 
  pull(n)

heart_disease_one <- heart_disease %>% 
  filter(HeartDiseaseorAttack == 1) %>% 
  select(n) %>% 
  pull(n)

likelihood <- heart_disease %>% 
  mutate(ratio = heart_disease_one / heart_disease_zero) %>% 
  select(ratio) %>% 
  filter(HeartDiseaseorAttack == 1) %>% 
  pull(ratio)

# Someone with diabetes has a likelihood of 0.2868 chance of having heart disease.

# Store summary information into a list.
diabetes_summary <- list()
diabetes_summary$avg_bmi_diabetes <- avg_diabetes
diabetes_summary$low_income_trend <- lowest_income
diabetes_summary$highest_income_trend <- highest_income
diabetes_summary$age_trend <- highest_diabetes_age
diabetes_summary$heart_disease_with_diabetes <- likelihood

# Reflection ------------------------------------------------------------
# Write a paragraph of reflection on the summary information calculated by your
# summary information function.

# The summary function calculates several values on the diabetes dataset, such as
# the highs and averages within the data. The first value of summary includes 
# the average BMI of those who are diabetic, which allows us to look at how diabetes
# impacts a patient's BMI. The second and third values of summary includes the ratio of 
# those in low income and high income who have diabetes, allowing us to see the 
# trend of if having diabetes is correlated to income, in which it is. The fourth
# value of summary consists of the age with the highest counts of diabetic cases,
# examining what age is most likely to have diabetes based on the highest amount of
# cases. The last value of summary displays the likelihood for someone with diabetes
# to have heart disease, which is quantified from filtering diabetes cases, and
# analyzing the cases where patients do have both diabetes and heart disease, or
# simply diabetes.
