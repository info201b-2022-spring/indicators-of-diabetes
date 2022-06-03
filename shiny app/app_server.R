library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(bslib)
library(stringr)
library(plyr)

# Define server logic
server <- function(input, output){
  output$diabetes-awareness-month <- renderImage({
    
    list(src = "www/diabetes-awareness-month.jpeg",
    width = "100%",
    height = 810)
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
  
}
