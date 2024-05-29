# libraries
library(readxl)
library(dplyr)
library(plotly)
library(ggplot2)

# create server function
server <- function(input, output) {
  # load data
  data <- read_excel("./D_FINAL.xlsx")

  ### CHART 1 ###
  # Define the server logic
  emissions_data <- reactive({
    file_path <- "./D_FINAL.xlsx"
    data <- read_excel(file_path, sheet = 1) %>% 
      select(`Scope-1 GHG emissions [tCO2 or tCO2-eq]`, `Total emissions (CDP) [tCO2-eq]`, Country) %>%
      rename(Scope1_Emissions = `Scope-1 GHG emissions [tCO2 or tCO2-eq]`, 
             Total_Emissions_CDP = `Total emissions (CDP) [tCO2-eq]`, 
             Country = Country) %>%
      arrange(desc(Total_Emissions_CDP)) %>%
      head(7)  # Adjusted to show the top 7 countries
    data
  })
  
  # Render the plot
  output$emissionsPlot <- renderPlotly({
    selected_emission <- input$emissions_selector
    gg_chart <- ggplot(emissions_data(), aes_string(x = "Country", y = selected_emission, fill = "Country")) +
      geom_bar(stat = "identity") +
      scale_fill_manual(values = rep(c("darkseagreen2", "darkseagreen", "darkolivegreen", "darkgreen", "black"), 2)) +
      labs(x = "Country", y = selected_emission, title = "Top 7 Countries with Highest CO2 Emissions (CDP)") +
      theme_minimal()
    ggplotly(gg_chart)
  })
}

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

