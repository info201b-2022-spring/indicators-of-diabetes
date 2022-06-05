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

# Define server logic
server <- function(input, output){

  output$diabetes_awareness_month <- renderImage({
    list(src = "www/diabetes-awareness-month.jpeg",
    width = "100%",
    height = "100%")
  }, deleteFile = F)
  
  # Define bar chart to render in the UI
  output$income_bar_chart <- renderPlot({
    
    if (input$bar_chart == "Income"){
      return(plot1)
    }
    if (input$bar_chart == "Age"){
      return(plot1b)
    }
    if(input$bar_chart == "Sex"){
      return(plot1c)
    }
    if(input$bar_chart == "BMI"){
      return(plot1d)
    }
    if(input$bar_chart == "Smoker"){
      return(plot1e)
    }
    if(input$bar_chart == "HighBP"){
      return(plot1f)
    }
    if(input$bar_chart == "HighChol"){
      return(plot1g)
    }
    if(input$bar_chart == "HeartDiseaseorAttack"){
      return(plot1h)
    }
  })
  
  # output$income_table <- renderTable({
  #   nearPoints(income_df, input$income_bar_click, xvar = "Income", yvar = "freq")
  # })
  
  # Violin plot (UNUSED)
  output$violin <- renderPlotly({
    filter_df <- healthIndicators_df %>% filter(BMI %in% (input$age[1] : input$age[2]))#(Age %in% (input$age[1] : input$age[2]))
    filter_df$Diabetes_012 <- as.factor(filter_df$Diabetes_012)
    violin_plot <- ggplot(data = filter_df, aes(x = Diabetes_012, y = BMI)) +
      geom_violin() +
      labs(title = "Diabetes Classification vs. Age", x = "Diabetes Classification", y = "BMI")
    
    #BMI Histogram
    BMI_histo <- ggplot(data = filter_df, aes(x=BMI, fill = Diabetes_012 )) +#color=text, fill=text)) +
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
    
      
    
    #violin_plotly <- ggplotly(violin_plot) %>% config(displayModeBar = FALSE)
    
    
    #return(violin_plotly)
    
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
}