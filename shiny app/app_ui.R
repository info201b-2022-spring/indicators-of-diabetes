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
    includeCSS("styles.css"),
    theme = bs_theme(version = 4, bootswatch = "minty"),
    h1("As diabetes is so prevalent, what risk factors are most indicative of diabetes risk?"),
    br(),
    HTML('<img src="diabetes-awareness-month.jpeg" alt="Diabetes Awareness Month" id="picture">'),
    # imageOutput("diabetes_awareness_month"),
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
      plotlyOutput(outputId = "histo")
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
           school), 6 = college 4 years or more (College graduate).")),
      p(em("* Diabetes classifications are in 0, 1, 2 where 0 = No Diabetes, 1 = Pre-Diabetes, 2 = Diabetes.")),
      p(em("** Days within 30-day span that surveyee reported bad physical health"))
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
    includeCSS("styles.css"),
    h1("Summary Takeaways of Our Diabetes Analysis"),
    br(),
    HTML('<img src="diabetes_img.jpg" alt="Diabetes Image" id="picture">'),
    br(), br(),
    p("1. The vast majority of the respondents in the telephone survey had no diabetes, which led to the
      'No Diabetes' group being the highest in the bar graphs compared to the pre-diabetic and diabetic
      groups. The number of non-diabetic respondents (213,703) outnumbers the number of pre-diabetic (4,631)
      and diabetic (35,346) respondents. Therefore, we cannot use the bar graphs to compare the diabetic
      classifications relative to one another. Instead, we can use the bar graphs to look only at each
      classification separately and note how frequency changes across the different variables on the horizontal
      axis. For example, choosing to look at just diabetes, we see that people with diabetes tend to have
      higher blood pressure and cholesterol."),
    br(),
    p("2. From the three histograms, we can see that relative to the non-diabetic group, the plots for
      the pre-diabetic and diabetic groups are shifted to the right, giving us evidence that people
      who are pre-diabetic and diabetic tend to have a higher body mass index (BMI)."),
    br(),
    p("3. Analyzing the box plots, we can see that the diabetic respondents have a greater range of days
      in which they reported poor physical health. However, the median days of poor physical health for
      diabetic patients is only slightly higher compared to the other two groups. This observation shows
      that physical health may have a link to diabetes, but that many people with diabetes don't suffer
      from poor health."),
    br(),
    p("4. The stacked barplots allowed us to more easily compare the different diabetes classifications
      relative to each other, as the graphs are percentage-based instead of quantity-based. From the plots,
      we can tell that people without diabetes tend to have higher income and are younger, while people
      with diabetes are more likely to have high cholesterol and have heart attacks.")
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