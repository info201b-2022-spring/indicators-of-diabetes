library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(bslib)
library(stringr)
library(plyr)

# Define server logic
server <- function(input, output){

  output$diabetes_awareness_month <- renderImage({
    list(src = "www/diabetes-awareness-month.jpeg",
    width = "100%",
    height = "100%")
  }, deleteFile = F)
  
  # Define bar chart to render in the UI
  output$income_bar_chart <- renderPlot({
    filtered_df <- select(merged_df, unique(input$bar_chart), freq, classification)
    plot1 <- ggplot(data = filtered_df, aes(x = filtered_df[1], y = freq, fill = classification)) +
      geom_col(position = position_dodge())  +
      labs(title = "Median Household Income on Scale of 1-8", x = input$bar_chart, y = "Frequency")
    plot1
  })
  output$income_table <- renderTable({
    nearPoints(income_df, input$income_bar_click, xvar = "Income", yvar = "freq")
  })
  
  # Violin plot
  output$violin <- renderPlotly({
    filter_df <- healthIndicators_df %>% filter(Age %in% (input$age[1] : input$age[2]))
    filter_df$Diabetes_012 <- as.factor(filter_df$Diabetes_012)
    violin_plot <- ggplot(data = filter_df, aes(x = Diabetes_012, y = Age)) +
      geom_violin() +
      labs(title = "Diabetes Classification vs. Age", x = "Diabetes Classification", y = "Age")
    
    violin_plotly <- ggplotly(violin_plot) %>% config(displayModeBar = FALSE)
    
    return(violin_plotly)
  })
}
