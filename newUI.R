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
chrt1_pg <- tabPanel(
  "Chart 1",
  titlePanel("Countries With the Highest Emissions"),
  
  mainPanel(
    h3("content area"),
    p("plots and details here")
  )
)

# chart page 2
chrt2_pg <- tabPanel(
  "Chart 2",
  titlePanel("Cities Mapped by Emissions Rating"),
  
  mainPanel(
    h3("content area"),
    p("plots and details here")
  )
)

# chart page 3
chrt3_pg <- tabPanel(
  "Chart 3",
  titlePanel("The Effect of Fuel Prices on Emissions"),
  
  mainPanel(
    h3("content area"),
    p("plots and details here"),
    plotlyOutput("fuel_chart"),
    radioButtons(
      inputId = "fuel_selector",
      label = "Fuel Type",
      choices = list(
        "Diesel" = 1,
        "Gasoline" = 2
      ),
      selected = 2
    )
  )
)

# conclusion page
concl_pg <- tabPanel(
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
  chrt1_pg,
  chrt2_pg,
  chrt3_pg,
  concl_pg
)