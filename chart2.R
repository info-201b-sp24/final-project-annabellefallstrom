
## Mapping Citys and their emmissions flag rating 


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
  

palette_fn <- colorFactor(palette = "Set2", domain = climate_change$emissions_quality_flag_cdp)

palette <- colorFactor(palette = c("darkseagreen2", "darkseagreen", "darkolivegreen","darkgreen", "black"),
                       levels = c("A", "B", "C", "D", "E"), na.color = "grey")


climate_change %>%
  leaflet() %>%

    addCircleMarkers(
                     label = ~emissions_quality_flag_cdp,
                     stroke = FALSE,
                     fillColor = ~palette(emissions_quality_flag_cdp),
                     fillOpacity = 3,
                     radius = 2) %>% 

  addTiles() %>%
  addLegend(position ="bottomleft",
            pal = palette,
            values = ~emissions_quality_flag_cdp,
            title = "Emmissions Flag Rating by City")




i <- fluidPage(
  
  # Application title
  titlePanel('Search the world'),
  
  # Sidebar with a drop down box for city names
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = 'country',
                  label = 'City to zoom in on:',
                  choices = climate_change$city_name)
    ),
    
    # Show the map
    mainPanel(
      tmapOutput('map')
    )
  )
)

# Define server logic required to make the map
server <- function(input, output) {
  
  # build the map
  output$map <- renderLeaflet({
    
    # Define a palette function
    palette <- colorFactor(palette = c("darkseagreen2", "darkseagreen", "darkolivegreen","darkgreen", "black"),
                           levels = c("A", "B", "C", "D", "E"), na.color = "grey")
    
    
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

#### TEXT: 

# This map intends to show the relationship between where a city 
# is geographically and its emissions flag rating. This intends 
# to show if where a city is has an impact on what kinds and how
# much emissions it produce. 


