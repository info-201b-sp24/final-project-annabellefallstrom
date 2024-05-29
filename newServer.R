# libraries
library(readxl)
library(dplyr)
library(plotly)

# create server function
server <- function(input, output) {
  # load data
  data <- read_excel("./D_FINAL.xlsx")
  
  ### CHART 3 ###
  # fuel data
  fuel_data <- data %>%
    select(
      `Emissions per Person (CDP) [tCo2-eq]` =
        `Total emissions (CDP) [tCO2-eq]` / `Population (CDP)`,
      `Diesel price (GEA+) [USD/liter]`,
      `Gasoline price (GEA+) [USD/liter]`
    ) %>%
    na.omit()
  
  # get selected fuel based on ui
  fuel <- if () {
    select(fuel_data, 1)
  }
  
  # chart 3: gas / diesel prices vs emissions
  output$fuel_chart <- renderPlotly({
    plot_ly(
      data = fuel_data,
      x = fuel,
      y = ~ `Emissions per Person (CDP) [tCo2-eq]`,
      type = "scatter"
      
    ) 
  })
}