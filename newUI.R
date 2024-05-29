# libraries
library(shiny)
library(plotly)

# introduction page
intro_pg <- tabPanel(
  "Intro",
  titlePanel("Introduction"),
  
  mainPanel(
    h3("content area"),
    p("plots and details here")
  )
)

# chart page 1
cht1_pg <- tabPanel(
  "Chart 1",
  titlePanel("Countries With the Highest Emissions"),
  
  mainPanel(
    h3("content area"),
    p("plots and details here")
  )
)

# chart page 2
cht2_pg <- tabPanel(
  "Chart 2",
  titlePanel("Cities Mapped by Emissions Rating"),
  
  mainPanel(
    h3("content area"),
    p("plots and details here")
  )
)

# chart page 3
cht3_pg <- tabPanel(
  "Chart 3",
  titlePanel("The Effect of Fuel Prices on Emissions"),
  
  mainPanel(
    h3("content area"),
    p("plots and details here"),
    plotlyOutput("fuel_chart")
  )
)

# conclusion page
conc_pg <- tabPanel(
  "Conclusion",
  titlePanel("Conclusion"),
  
  mainPanel(
    h3("content area"),
    p("plots and details here")
  )
)

ui <- navbarPage(
  "Climate Change Analysis",
  intro_pg,
  cht1_pg,
  cht2_pg,
  cht3_pg,
  conc_pg
)