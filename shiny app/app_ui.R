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
    theme = bs_theme(version = 4, bootswatch = "minty"),
    h1("As diabetes is so prevalent, what risk factors are most indicative of diabetes risk?"),
    br(),
    imageOutput("diabetes_awareness_month"),
    br(), br(),
    a("Dataset Source", href = "https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset"),
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
    strong("3. What health factors might influence the risk of diabetes?"),
    br(), br()
  )
)

<<<<<<< HEAD
# Data Cleaning--------------------------------------------------------

# load in data

# path for daniella
#healthIndicators_df <- read.csv("/Users/daniella/Desktop/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")

# path for brandon
healthIndicators_df <- read.csv("C:/Users/brand/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")

#path for roberto
#healthIndicators_df <- read.csv("C:/Users/rober/Documents/College/Year 2/Quarter 3/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")

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

=======
>>>>>>> 28bc0985a3b50f1c31ad4b83beb1fe709184a1e9
# Page 1---------------------------------------------------------------
# create the tab
bar_chart_tab <- tabPanel(
  "Bar Chart",
  titlePanel("Comparing Different Factors"),
  
  sidebarLayout(
    sidebarPanel(
      # Select factor to analyze on bar graph
      selectInput(inputId = "bar_chart", label = strong("Select health indicator"),
                  choices = colnames(diabetes_df), selected = "Income"),
      em("Notes:"),
      p(em("* Income is on a scale of 1-8, where 1 = less than $10,000, 5 = less than $
        35,000, 8 = $75,000 or more.")),
      p(em("* Age is on a scale of 1-13, where 1 = ages 18-24, 9 = ages 60-64, 13 = ages 80 or older.")),
      p(em("* Sex is on a scale of 0-1, where 0 = females, 1 = males.")),
      p(em("* Smoker is on a scale of 0-1, representing if the person has smoked at least
        100 ciagarettes in their entire life, where 0 = no, 1 = yes.")),
      p(em("* High BP is on a scale of 0-1, where 0 = no high BP, 1 = high BP.")),
      p(em("* High Chol is on a scale of 0-1, where 0 = no high cholesterol, 1 = high cholesterol.")),
      p(em("* Heart Disease or Attack is on a scale of 0-1, representing if the person has coronary heart disease
        (CHD) or myocardial infarction (MD), where 0 = no, 1 = yes.")),
    ),
    mainPanel(
      plotlyOutput(outputId = "income_bar_chart"),
      tableOutput(outputId = "income_table")
    )
  )
)

# Page 2---------------------------------------------------------------
histogram_tab <- tabPanel(
  "Histograms",
  titlePanel("Diabetes Clasification vs. BMI"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "age", 
                  label = "BMI from 10 to 60",
                  min = 10, max = 60, value = c(10, 60)),
      em("Notes:"),
      p(em("* Diabetes classifications are in 0, 1, 2 where 0 = No Diabetes, 1 = Pre-Diabetes, 2 = Diabetes"))
    ),
    mainPanel(
      plotlyOutput(outputId = "violin")
    )
  )
)

# Page 3---------------------------------------------------------------
# create the tab
stacked_bar_chart_tab <- tabPanel(
  "Stacked Bar Chart",
  titlePanel("Comparing Different Factors"),
  
  sidebarLayout(
    sidebarPanel(
      # Select factor to analyze on bar graph
      selectInput(inputId = "stacked_bar_input", label = strong("Select health indicator"),
                  choices = colnames(diabetes_df), selected = "Income"),
      em("Notes:"),
      p(em("* Income is on a scale of 1-8, where 1 = less than $10,000, 5 = less than $
        35,000, 8 = $75,000 or more.")),
      p(em("* Age is on a scale of 1-13, where 1 = ages 18-24, 9 = ages 60-64, 13 = ages 80 or older.")),
      p(em("* Sex is on a scale of 0-1, where 0 = females, 1 = males.")),
      p(em("* Smoker is on a scale of 0-1, representing if the person has smoked at least
        100 ciagarettes in their entire life, where 0 = no, 1 = yes.")),
      p(em("* High BP is on a scale of 0-1, where 0 = no high BP, 1 = high BP.")),
      p(em("* High Chol is on a scale of 0-1, where 0 = no high cholesterol, 1 = high cholesterol.")),
      p(em("* Heart Disease or Attack is on a scale of 0-1, representing if the person has coronary heart disease
        (CHD) or myocardial infarction (MD), where 0 = no, 1 = yes.")),
    ),
    mainPanel(
      plotOutput(outputId = "stacked_barplot", click = "stacked_bar_click"),
      tableOutput(outputId = "stacked_table")
    )
  )
)

box_plot_tab <- tabPanel(
 "BMI Data Distribution",
 titlePanel("Income vs. BMI"),

 sidebarLayout(
   sidebarPanel(
     selectInput(inputId = "class", label = strong("Select diabetes classification"),
                 choices = list("No Diabetes" = 1, "Pre-Diabetes" = 2, "Diabetes" = 3),
                 selected = 1)
   ),
   mainPanel(
     plotlyOutput(outputId = "box_plot")
   )
 )
)

# Page 4---------------------------------------------------------------
box_plot_tab <- tabPanel(
  "Box Plot Distribution",
  titlePanel("How does Education relate to Diabetes?"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "color",
        label = "Select color",
        c("Red",
          "Blue",
          "Orange",
          "Green",
          "Purple",
          "Pink",
          "Yellow",
          "Grey"
          )
        ),
      em("Notes:"),
      p(em("* Education is on a scale of 1-6, where 1 = never attend school or only kindergarten, 
           2 = grades 1-8 (Elementary and secondary), 3 = grades 9-11 (Some high school), 4 = grades 
           12 or GED (High school graduate), 5 = college 1 year to 3 years (Some college or technical 
           school), 6 = college 4 years or more (College graduate)"))
    ),
    mainPanel(
      plotlyOutput(outputId = "edu_box_plot")
    )
  )
)

# Conclusion ----------------------------------------------------------
conclusion_tab <- tabPanel(
  "Conclusion",
  fluidPage(
    h1("Summary Takeaways of Our Diabetes Analysis"),
    br(),
    imageOutput("diabetes_img"),
    br(), br(),
    p("The data set "),
    br()
    )
)

# Define UI
ui <- navbarPage(
  theme = bs_theme(version = 4, bootswatch = "minty"),
  "Diabetes Risk",      # application title 
  intro_tab,            # intro page
  bar_chart_tab,        # bar chart page
  histogram_tab,        # histogram page 
  stacked_bar_chart_tab,# stacked bar chart page 
  box_plot_tab,         # box plot page 
  conclusion_tab        # conclusion page
)