library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(plotly)
library(bslib)
library(stringr)
library(plyr)
library(rsconnect)
source("app_server.R")
source("app_ui.R")

# Run the application
shinyApp(ui = ui, server = server)