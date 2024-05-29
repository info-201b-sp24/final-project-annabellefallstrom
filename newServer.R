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
  
  # chart 3: gas / diesel prices vs emissions
  output$fuel_chart <- renderPlotly({
    # create diesel chart
    diesel_chart <- plot_ly(
      data = fuel_data,
      x = ~ `Diesel price (GEA+) [USD/liter]`,
      y = ~ `Emissions per Person (CDP) [tCo2-eq]`,
      type = "scatter",
      mode = "markers"
    )
    
    # create diesel chart
    gas_chart <- plot_ly(
      data = fuel_data,
      x = ~ `Gasoline price (GEA+) [USD/liter]`,
      y = ~ `Emissions per Person (CDP) [tCo2-eq]`,
      type = "scatter",
      mode = "markers"
    ) 
    
    # return based on selection
    if (input$fuel_selector == 1) {
      return(diesel_chart)
    }
    return(gas_chart)
  })
}