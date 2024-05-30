# libraries
library(shiny)

# load ui and server from files
source("ui.R")
source("server.R")

# launch app
shinyApp(ui = ui, server = server)