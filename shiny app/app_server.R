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
    
    if (input$bar_chart = "Income"){
      return(plot1)
    }
    if (input$bar_chart = "Age"){
      return(plot1b)
    }
    
  })
  # output$income_table <- renderTable({
  #   nearPoints(income_df, input$income_bar_click, xvar = "Income", yvar = "freq")
  # })
  
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
