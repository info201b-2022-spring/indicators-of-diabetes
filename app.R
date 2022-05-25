library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(bslib)

# Introduction---------------------------------------------------------
intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    h1("As diabetes is so prevalent, what risk factors are most indicative of diabetes risk?"),
    br(),
    img("diabetes-awareness-month.jpeg", 
        src = "/Users/daniella/Downloads/diabetes-awareness-month.jpeg"),
    br(), br(),
    HTML('<a href="https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset" class="link-text"> Data is aggregated from the Behavioral Risk Factor Surveillance System (BRFSS) survey<\a>'),
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
    br(), br(), br(),
    strong("1. What is the income distribution of people who do not have diabetes, are 
           pre-diabetic, or have diabetes and what are the possible reasons?"),
    br(), br(),
    strong("2. At what age range do people typically have diabetes? How does this compare to 
           people who are not diabetic, or are pre-diabetic?"),
    br(), br(),
    strong("3. What health factors might influence the risk of diabetes?")
  )
)

# Page 1---------------------------------------------------------------
plot1 <-
  
# Page 2---------------------------------------------------------------
plot2 <-
  
# Page 3---------------------------------------------------------------
plot3 <-
  
# Conclusion ----------------------------------------------------------
conclusion <- 

# Define UI
ui <- navbarPage(
  "Diabetes Risk",
  intro_tab
)

# Define server logic
server <- function(input, output){
  
}

# Run the application
shinyApp(ui = ui, server = server)