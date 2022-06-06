library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(bslib)
library(stringr)
library(plyr)

library(tidyverse)
library(hrbrthemes)
library(viridis)
library(forcats)

# Data Cleaning--------------------------------------------------------

# load in data

# path for daniella
# healthIndicators_df <- read.csv("/Users/daniella/Desktop/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")
healthIndicators_df <- read.csv("C:/Users/Daniella/Documents/School/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")

# path for brandon
# healthIndicators_df <- read.csv("C:/Users/brand/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")

# path for roberto
# healthIndicators_df <- read.csv("C:/Users/rober/Documents/College/Year 2/Quarter 3/INFO 201/final-projects-daniellatsing/data/diabetes_012_health_indicators_BRFSS2015.csv")

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
plotly1 <- ggplotly(plot1)

plot1b <- ggplot(data = age_df, aes(x = Age, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "Age & Diabetes Classification", x = "Age (years)", y = "Frequency")
plot(plot1b)
plotly1b <- ggplotly(plot1b)

plot1c <- ggplot(data = sex_df, aes(x = Sex, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "Sex & Diabetes Classification", x = "Sex", y = "Frequency")
plot(plot1c)
plotly1c <- ggplotly(plot1c)

plot1d <- ggplot(data = bmi_df, aes(x = BMI, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "BMI & Diabetes Classification", x = "BMI", y = "Frequency")
plot(plot1d)
plotly1d <- ggplotly(plot1d)

plot1e <- ggplot(data = smoker_df, aes(x = Smoker, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "Smoking Habits", x = "Has Smoked At Least 100 Cigarettes in Lifetime", y = "Frequency")
plot(plot1e)
plotly1e <- ggplotly(plot1e)

plot1f <- ggplot(data = bp_df, aes(x = HighBP, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "High Blood Pressure & Diabetes Classification", x = "Has High Blood Pressure", y = "Frequency")
plot(plot1f)
plotly1f <- ggplotly(plot1f)

plot1g <- ggplot(data = chol_df, aes(x = HighChol, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "High Cholesterol & Diabetes Classification", x = "Has High Cholesterol", y = "Frequency")
plot(plot1g)
plotly1g <- ggplotly(plot1g)

plot1h <- ggplot(data = heart_df, aes(x = HeartDiseaseorAttack, y = freq, fill = classification)) +
  geom_col(position = position_dodge())  +
  labs(title = "Heart Complications", x = "Had Coronary Heart Disease or Myocardial Infarction", y = "Frequency")
plot(plot1h)
plotly1h <- ggplotly(plot1h)

bar_plots_vector <- c(plot1, plot1b, plot1c, plot1d, plot1e, plot1f, plot1g, plot1h)

# Page 3---------------------------------------------------------------
plot3 <- ggplot(data = income_df, aes(fill=Income, y=freq, x=classification)) +
  geom_bar(position="fill", stat="identity") +
  labs(title = "Median Household Income on Scale of 1-8", x = "Diabetes Classification", y = "Income Level")
plot(plot1)

plot3b <- ggplot(data = age_df, aes(fill = Age, y = freq, x = classification)) +
  geom_bar(position="fill", stat="identity") +
  labs(title = "Age & Diabetes Classification", x = "Age (years)", y = "Frequency")
plot(plot1b)

plot3c <- ggplot(data = sex_df, aes(fill = Sex, y = freq, x = classification)) +
  geom_bar(position="fill", stat="identity") +
  labs(title = "Sex & Diabetes Classification", x = "Sex", y = "Frequency")
plot(plot1c)

plot3d <- ggplot(data = bmi_df, aes(fill = BMI, y = freq, x = classification)) +
  geom_bar(position="fill", stat="identity") +
  labs(title = "BMI & Diabetes Classification", x = "BMI", y = "Frequency")
plot(plot1d)

plot3e <- ggplot(data = smoker_df, aes(fill = Smoker, y = freq, x = classification)) +
  geom_bar(position="fill", stat="identity") +
  labs(title = "Smoking Habits", x = "Has Smoked At Least 100 Cigarettes in Lifetime", y = "Frequency")
plot(plot1e)

plot3f <- ggplot(data = bp_df, aes(xfill= HighBP, y = freq, x = classification)) +
  geom_bar(position="fill", stat="identity") +
  labs(title = "High Blood Pressure & Diabetes Classification", x = "Has High Blood Pressure", y = "Frequency")
plot(plot1f)

plot3g <- ggplot(data = chol_df, aes(fill = HighChol, y = freq, x = classification)) +
  geom_bar(position="fill", stat="identity") +
  labs(title = "High Cholesterol & Diabetes Classification", x = "Has High Cholesterol", y = "Frequency")
plot(plot1g)

plot3h <- ggplot(data = heart_df, aes(fill = HeartDiseaseorAttack, y = freq, x = classification)) +
  geom_bar(position="fill", stat="identity") +
  labs(title = "Heart Complications", x = "Had Coronary Heart Disease or Myocardial Infarction", y = "Frequency")
plot(plot1h)

stacked_bar_plots_vector <- c(plot3, plot3b, plot3c, plot3d, plot3e, plot3f, plot3g, plot3h)

# Define server logic
server <- function(input, output){
  
  # Define bar chart to render in the UI
  output$income_bar_chart <- renderPlotly({
    
    if (input$bar_chart == "Income"){
      return(plotly1)
    }
    if (input$bar_chart == "Age"){
      return(plotly1b)
    }
    if(input$bar_chart == "Sex"){
      return(plotly1c)
    }
    if(input$bar_chart == "BMI"){
      return(plotly1d)
    }
    if(input$bar_chart == "Smoker"){
      return(plotly1e)
    }
    if(input$bar_chart == "HighBP"){
      return(plotly1f)
    }
    if(input$bar_chart == "HighChol"){
      return(plotly1g)
    }
    if(input$bar_chart == "HeartDiseaseorAttack"){
      return(plotly1h)
    }
  })
  
  output$histo <- renderPlotly({
    filter_df <- healthIndicators_df %>% filter(BMI %in% (input$age[1] : input$age[2]))
    filter_df$Diabetes_012 <- as.factor(filter_df$Diabetes_012)
    
    #BMI Histogram
    BMI_histo <- ggplot(data = filter_df, aes(x=BMI, fill = Diabetes_012 )) +
      geom_histogram(alpha=0.6, binwidth = 1) +
      scale_fill_viridis(discrete=TRUE) +
      scale_color_viridis(discrete=TRUE) +
      theme_ipsum() +
      theme(
        legend.position="none",
        panel.spacing = unit(0.1, "lines"),
        strip.text.x = element_text(size = 8)
      ) +
      xlab("BMI") +
      ylab("Count") +
      facet_wrap(vars(Diabetes_012), scales='free')
    
    BMI_plotly <- ggplotly(BMI_histo)
    return(BMI_plotly)
  })
  
  #Stacked barplot
  output$stacked_barplot <- renderPlot({
    
    if (input$stacked_bar_input == "Income"){
      return(plot3)
    }
    if (input$stacked_bar_input == "Age"){
      return(plot3b)
    }
    if(input$stacked_bar_input == "Sex"){
      return(plot3c)
    }
    if(input$stacked_bar_input == "BMI"){
      return(plot3d)
    }
    if(input$stacked_bar_input == "Smoker"){
      return(plot3e)
    }
    if(input$stacked_bar_input == "HighBP"){
      return(plot3f)
    }
    if(input$stacked_bar_input == "HighChol"){
      return(plot3g)
    }
    if(input$stacked_bar_input == "HeartDiseaseorAttack"){
      return(plot3h)
    }
  })
  
  output$edu_box_plot <- renderPlotly({
    edu_filter_df <- healthIndicators_df
    edu_filter_df$Diabetes_012 <- as.factor(edu_filter_df$Diabetes_012)
    
    ggplot(data = edu_filter_df, aes(x = Diabetes_012, y = PhysHlth)) +
      geom_boxplot(color = "black", fill=input$color) +
      #theme_ipsum() +
      #theme(
        #legend.position ="none",
        #strip.text.x = element_text(size = 8)
      #) +
      xlab("Diabetes Classification") +
      ylab("Days**")
  })
}