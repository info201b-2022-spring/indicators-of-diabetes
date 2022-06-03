library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(bslib)
library(stringr)
library(plyr)

# Introduction---------------------------------------------------------
intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    h1("As diabetes is so prevalent, what risk factors are most indicative of diabetes risk?"),
    br(),
    imageOutput("diabetes_awareness_month"),
    br(), br(),
    a("Dataset Source", href = "https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset"),
    #HTML('<a href="https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset" class="link-text"> Data is aggregated from the Behavioral Risk Factor Surveillance System (BRFSS) survey<\a>'),
    p("The data set contains information about the indicators of diabetes for 253,680 survey 
    respondents. Indicators include factors such as cholesterol levels, BMI, and income. The 
    data was collected by the Centers for Disease Control and Prevention (CDC) via a telephone 
    survey called the Behavioral Risk Factor Surveillance System (BRFSS) in 2015. The data set 
    contains 22 columns and 253,680 rows. From this dataset, we are able to determine factors 
    that influence an individual's likelihood of becoming diagnosed with diabetes. These factors 
    include social and behavioral factors along with health factors, so we will also be able to 
    analyze the intersection between an individual's social environment and an individual's 
    physical well-being. The social factors provided in this dataset include age and income. From 
    these categories, we may discern how socioeconomic status may be likely correlate with 
    diabetes risk, such as how income factors into healthcare, and what age group has the 
    highest number of diabetics. By analyzing social factors, we can ask further questions to 
    explore the cause and effect relationships created by these factors. Moreover, the dataset 
    contains information about an individual's behavior, such as smoking and eating habits, and
    how it predisposes them to diabetes. Along with health factors such as cholesterol levels, 
    these social and behavioral patterns will give us a more well-rounded understanding of the 
    contributors to diabetes. The following are questions that we want to explore:"),
    br(),
    strong("1. What is the income distribution of people who do not have diabetes, are 
           pre-diabetic, or have diabetes and what are the possible reasons?"),
    br(), br(),
    strong("2. At what age range do people typically have diabetes? How does this compare to 
           people who are not diabetic, or are pre-diabetic?"),
    br(), br(),
    strong("3. What health factors might influence the risk of diabetes?")
  )
)

# Data Cleaning--------------------------------------------------------

# load in data
healthIndicators_df <- read.csv("/Users/daniella/Desktop/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")
# setwd("C:/Users/brand/INFO 201/final-projects-daniellatsing/data") # path for brandon
# healthIndicators_df <- read.csv("diabetes_012_health_indicators_BRFSS2015.csv")

# cleaned dataframes
diabetes_df <- na.omit(healthIndicators_df) %>%
  filter(Diabetes_012 == 2) %>%
  select(Income, Age, Sex, BMI, Smoker, HighBP, HighChol, HeartDiseaseorAttack)

no_diabetes_df <- na.omit(healthIndicators_df) %>%
  filter(Diabetes_012 == 0) %>%
  select(Income, Age, Sex, BMI, Smoker, HighBP, HighChol, HeartDiseaseorAttack)

pre_diabetes_df <- na.omit(healthIndicators_df) %>%
  filter(Diabetes_012 == 1) %>%
  select(Income, Age, Sex, BMI, Smoker, HighBP, HighChol, HeartDiseaseorAttack)

# income data
diabetes_income_df <- count(diabetes_df, 'Income')  
diabetes_income_df$classification <- rep("Diabetes", 8) 

no_diabetes_income_df <- count(no_diabetes_df, 'Income')
no_diabetes_income_df$classification <- rep("No Diabetes", 8) 

pre_diabetes_income_df <- count(pre_diabetes_df, 'Income')
pre_diabetes_income_df$classification <- rep("Pre-Diabetes", 8) 

income_df <- bind_rows(no_diabetes_income_df, pre_diabetes_income_df, diabetes_income_df)

# age data
diabetes_age_df <- count(diabetes_df, 'Age')
diabetes_age_df$classification <- rep("Diabetes", 13) 

no_diabetes_age_df <- count(no_diabetes_df, 'Age')
no_diabetes_age_df$classification <- rep("No Diabetes", 13) 

pre_diabetes_age_df <- count(pre_diabetes_df, 'Age')
pre_diabetes_age_df$classification <- rep("Pre-Diabetes", 13) 

age_df <- bind_rows(no_diabetes_age_df, pre_diabetes_age_df, diabetes_age_df)

# sex data
diabetes_sex_df <- count(diabetes_df, 'Sex')
diabetes_sex_df$Sex[1] <- "Female"
diabetes_sex_df$Sex[2] <- "Male"
diabetes_sex_df$classification <- rep("Diabetes", 2) 

no_diabetes_sex_df <- count(no_diabetes_df, 'Sex')
no_diabetes_sex_df$Sex[1] <- "Female"
no_diabetes_sex_df$Sex[2] <- "Male"
no_diabetes_sex_df$classification <- rep("No Diabetes", 2) 

pre_diabetes_sex_df <- count(pre_diabetes_df, 'Sex')
pre_diabetes_sex_df$Sex[1] <- "Female"
pre_diabetes_sex_df$Sex[2] <- "Male"
pre_diabetes_sex_df$classification <- rep("Pre-Diabetes", 2) 

sex_df <- bind_rows(no_diabetes_sex_df, pre_diabetes_sex_df, diabetes_sex_df)

# bmi data
diabetes_bmi_df <- count(diabetes_df, 'BMI')
diabetes_bmi_df$classification <- rep("Diabetes", 77) 

no_diabetes_bmi_df <- count(no_diabetes_df, 'BMI')
no_diabetes_bmi_df$classification <- rep("No Diabetes", 81) 

pre_diabetes_bmi_df <- count(pre_diabetes_df, 'BMI')
pre_diabetes_bmi_df$classification <- rep("Pre-Diabetes", 59) 

bmi_df <- bind_rows(no_diabetes_bmi_df, pre_diabetes_bmi_df, diabetes_bmi_df)

# smoking habit data
diabetes_smoker_df <- count(diabetes_df, 'Smoker')
diabetes_smoker_df$Smoker[1] <- "No"
diabetes_smoker_df$Smoker[2] <- "Yes"
diabetes_smoker_df$classification <- rep("Diabetes", 2) 

no_diabetes_smoker_df <- count(no_diabetes_df, 'Smoker')
no_diabetes_smoker_df$Smoker[1] <- "No"
no_diabetes_smoker_df$Smoker[2] <- "Yes"
no_diabetes_smoker_df$classification <- rep("No Diabetes", 2) 

pre_diabetes_smoker_df <- count(pre_diabetes_df, 'Smoker')
pre_diabetes_smoker_df$Smoker[1] <- "No"
pre_diabetes_smoker_df$Smoker[2] <- "Yes"
pre_diabetes_smoker_df$classification <- rep("Pre-Diabetes", 2) 

smoker_df <- bind_rows(no_diabetes_smoker_df, pre_diabetes_smoker_df, diabetes_smoker_df)

# bp data
diabetes_bp_df <- count(diabetes_df, 'HighBP')
diabetes_bp_df$HighBP[1] <- "No"
diabetes_bp_df$HighBP[2] <- "Yes"
diabetes_bp_df$classification <- rep("Diabetes", 2) 

no_diabetes_bp_df <- count(no_diabetes_df, 'HighBP')
no_diabetes_bp_df$HighBP[1] <- "No"
no_diabetes_bp_df$HighBP[2] <- "Yes"
no_diabetes_bp_df$classification <- rep("No Diabetes", 2) 

pre_diabetes_bp_df <- count(pre_diabetes_df, 'HighBP')
pre_diabetes_bp_df$HighBP[1] <- "No"
pre_diabetes_bp_df$HighBP[2] <- "Yes"
pre_diabetes_bp_df$classification <- rep("Pre-Diabetes", 2) 

bp_df <- bind_rows(no_diabetes_bp_df, pre_diabetes_bp_df, diabetes_bp_df)

# cholesterol data
diabetes_chol_df <- count(diabetes_df, 'HighChol')
diabetes_chol_df$HighChol[1] <- "No"
diabetes_chol_df$HighChol[2] <- "Yes"
diabetes_chol_df$classification <- rep("Diabetes", 2) 

no_diabetes_chol_df <- count(no_diabetes_df, 'HighChol')
no_diabetes_chol_df$HighChol[1] <- "No"
no_diabetes_chol_df$HighChol[2] <- "Yes"
no_diabetes_chol_df$classification <- rep("No Diabetes", 2) 

pre_diabetes_chol_df <- count(pre_diabetes_df, 'HighChol')
pre_diabetes_chol_df$HighChol[1] <- "No"
pre_diabetes_chol_df$HighChol[2] <- "Yes"
pre_diabetes_chol_df$classification <- rep("Pre-Diabetes", 2) 

chol_df <- bind_rows(no_diabetes_chol_df, pre_diabetes_chol_df, diabetes_chol_df)

# heart problems data
diabetes_heart_df <- count(diabetes_df, 'HeartDiseaseorAttack')
diabetes_heart_df$HeartDiseaseorAttack[1] <- "No"
diabetes_heart_df$HeartDiseaseorAttack[2] <- "Yes"
diabetes_heart_df$classification <- rep("Diabetes", 2) 

no_diabetes_heart_df <- count(no_diabetes_df, 'HeartDiseaseorAttack')
no_diabetes_heart_df$HeartDiseaseorAttack[1] <- "No"
no_diabetes_heart_df$HeartDiseaseorAttack[2] <- "Yes"
no_diabetes_heart_df$classification <- rep("No Diabetes", 2)

pre_diabetes_heart_df <- count(pre_diabetes_df, 'HeartDiseaseorAttack')
pre_diabetes_heart_df$HeartDiseaseorAttack[1] <- "No"
pre_diabetes_heart_df$HeartDiseaseorAttack[2] <- "Yes"
pre_diabetes_heart_df$classification <- rep("Pre-Diabetes", 2)

heart_df <- bind_rows(no_diabetes_heart_df, pre_diabetes_heart_df, diabetes_heart_df)

merged_df <- merge(income_df, age_df, by = "classification")

# Page 1---------------------------------------------------------------

# create the bar plots
plot1 <- ggplot(data = income_df, aes(x = Income, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "Median Household Income on Scale of 1-8", x = "Scale", y = "Frequency")
plot(plot1)

plot1b <- ggplot(data = age_df, aes(x = Age, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "Age & Diabetes Classification", x = "Age (years)", y = "Frequency")
plot(plot1b)

plot1c <- ggplot(data = sex_df, aes(x = Sex, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "Sex & Diabetes Classification", x = "Sex", y = "Frequency")
plot(plot1c)

plot1d <- ggplot(data = bmi_df, aes(x = BMI, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "BMI & Diabetes Classification", x = "BMI", y = "Frequency")
plot(plot1d)

plot1e <- ggplot(data = smoker_df, aes(x = Smoker, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "Smoking Habits", x = "Has Smoked At Least 100 Cigarettes in Lifetime", y = "Frequency")
plot(plot1e)

plot1f <- ggplot(data = bp_df, aes(x = HighBP, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "High Blood Pressure & Diabetes Classification", x = "Has High Blood Pressure", y = "Frequency")
plot(plot1f)

plot1g <- ggplot(data = chol_df, aes(x = HighChol, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "High Cholesterol & Diabetes Classification", x = "Has High Cholesterol", y = "Frequency")
plot(plot1g)

plot1h <- ggplot(data = heart_df, aes(x = HeartDiseaseorAttack, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "Heart Complications", x = "Had Coronary Heart Disease or Myocardial Infarction", y = "Frequency")
plot(plot1h)

bar_plots_vector <- c(plot1, plot1b, plot1c, plot1d, plot1e, plot1f, plot1g, plot1h)

# create the tab
bar_chart_tab <- tabPanel(
  "Bar Chart Comparison",
  titlePanel("Comparing Different Factors"),
  
  sidebarLayout(
    sidebarPanel(
      # Select factor to analyze on bar graph
      selectInput(inputId = "bar_chart", label = strong("Select health indicator"),
                  choices = colnames(diabetes_df), selected = "Income")
    ),
    mainPanel(
      plotOutput(outputId = "income_bar_chart", click = "income_bar_click"),
      tableOutput(outputId = "income_table")
    )
  )
)

# Page 2---------------------------------------------------------------
violin_plot_tab <- tabPanel(
  "Violin Plot",
  titlePanel("Diabetes Clasification vs. Income"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "age", 
                  label = "Age groups from 1 - 13",
                  min = 1, max = 13, value = c(1, 13))
    ),
    mainPanel(
      h3("Chart"),
      plotlyOutput(outputId = "violin")
    )
  )
)

# Page 3---------------------------------------------------------------
# plot3 <-

box_plot_tab <- tabPanel(
  "Box Plots",
  titlePanel("Income vs. BMI"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "select", label = strong("Select Health Indicator"),
                  choices = colnames(diabetes_df))
    ),
    mainPanel(
      h3("Chart")
    )
  )
)

# Conclusion ----------------------------------------------------------
# conclusion_tab <- 

# Define UI
ui <- navbarPage(
  "Diabetes Risk",      # application title 
  intro_tab,            # intro page
  bar_chart_tab,        # bar chart page
  violin_plot_tab,      # violin plot page 
  box_plot_tab,         # box plot page 
#  conclusion_tab        # conclusion page
)