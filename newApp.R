# libraries
library(shiny)

# load ui and server from files
source("newUI.R")
source("newServer.R")

shinyApp(ui = ui, server = server)