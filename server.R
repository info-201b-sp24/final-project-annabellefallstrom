<<<<<<< HEAD
## Mapping Citys and their emissions flag rating 


# Load in 
library(tidyverse)
library(leaflet)
library(dplyr)
library(sf)
library(stringr)
library(ggplot2)


climate_change <- read_excel("./D_FINAL.xlsx")




  names(climate_change)[names(climate_change) == "Emissions Quality Flag (CDP)"] <- "emissions_quality_flag_cdp"
  names(climate_change)[names(climate_change) == "Latitude (others) [degrees]"] <- "latitude"
  names(climate_change)[names(climate_change) == "Longitude (others) [degrees]"] <- "longitude"
  names(climate_change)[names(climate_change) == "City Name"] <- "city_name"
  
  climate_change <- climate_change %>% rename("city_name" = "City name")
  climate_change <- climate_change %>% rename("population" = "Population (CDP)")
  


palette <- colorFactor(palette = c("darkseagreen2", "darkseagreen", "darkolivegreen","darkgreen", "black"),
                       levels = c("A", "B", "C", "D", "E"), na.color = "grey")

# Define server logic required to make the map
server <- function(input, output) {
  
  # build the map
  output$map <- renderLeaflet({
    
    # Create the leaflet map
    climate_change %>%
      leaflet() %>%
      addTiles() %>%
      addCircleMarkers(
        label = ~paste(city_name, ":", emissions_quality_flag_cdp, " Population: ", population),
        stroke = FALSE,
        fillColor = ~palette(emissions_quality_flag_cdp),
        fillOpacity = 1,  # Adjusted fillOpacity to be within the 0-1 range
        radius = 5  # Adjusted radius for better visibility
      ) %>%
      addLegend(
        position = "bottomleft",
        pal = palette,
        values = ~emissions_quality_flag_cdp,
        title = "Emissions Flag Rating by City"
      )
  })
  
}

=======
#bar chart for top 7 countries and their emissions
library(shiny)
library(dplyr)
library(readxl)
library(ggplot2)
library(plotly)

ui <- fluidPage(
  titlePanel("Top 7 Countries with Highest CO2 Emissions (CDP)"),
  plotlyOutput("emissionsPlot")
)

server <- function(input, output) {
  emissions_data <- reactive({
    file_path <- "./D_FINAL.xlsx"
    data <- read_excel(file_path, sheet = 1) %>% 
      select(`Scope-1 GHG emissions [tCO2 or tCO2-eq]`, `Total emissions (CDP) [tCO2-eq]`, Country) %>%
      rename(Scope1_Emissions = `Scope-1 GHG emissions [tCO2 or tCO2-eq]`, 
             Total_Emissions_CDP = `Total emissions (CDP) [tCO2-eq]`, 
             Country = Country) %>%
      arrange(desc(Total_Emissions_CDP)) %>%
      head(10)
    data
  })
  
  # Render the plot
  output$emissionsPlot <- renderPlotly({
    gg_chart <- ggplot(emissions_data(), aes(x = reorder(Country, -Total_Emissions_CDP), y = Total_Emissions_CDP, fill = Country)) +
      geom_bar(stat = "identity") +
      scale_fill_manual(values = rep(c("darkseagreen2", "darkseagreen", "darkolivegreen", "darkgreen", "black"), 2)) +
      labs(x = "Country", y = "Total Emissions (CDP) [tCO2-eq]", title = "Top 7 Countries with Highest CO2 Emissions (CDP)") +
      theme_minimal()
    ggplotly(gg_chart)
  })
}

=============

library(dplyr)
library(plotly)
library(ggplot2)

maternity_df <- read.csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/maternity-leave-2021.csv", stringsAsFactors = FALSE)

server <- function(input, output) {
  output$maternity_plotly <- renderPlotly({
    selected_df <- maternity_df %>%
      filter(Country.Name %in% input$country_select)
    
    maternity_plot <- ggplot(selected_df) +
      geom_col(aes(x = Value,
                   y = reorder(Country.Name, +Value),
                   fill = Country.Name,
      ))
    
    maternity_plotly <- ggplotly(maternity_plot)
    
    return(maternity_plotly)
    
  })
}
  
  
  
>>>>>>> a1e2bfad1bb5811e937082fdd6da97eac2fbf5ab
