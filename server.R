<<<<<<< HEAD
## Mapping Citys and their emissions flag rating 


# Load in 
library(tidyverse)
library(leaflet)
library(dplyr)
library(sf)
library(stringr)
library(ggplot2)


setwd("/Users/annabellefallstrom/Desktop/INFO201/SCRIPTS-2/DATA")

climate_change <- read_tsv("D_FINAl.tsv")


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
