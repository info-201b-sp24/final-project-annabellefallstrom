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
### CHART 2 
climate_change <- data %>% rename("population" = "Population (CDP)")
climate_change <- data %>% rename("long" ="Longitude (others) [degrees]")
climate_change <- data %>% rename("city_name" = "City name")
climate_change <- data %>% rename("lat" = "Latitude (others) [degrees]")
climate_change <- data %>% rename("emissions_quality_flag_cdp" = "Emissions Quality Flag (CDP)")

 # Filter data based on selected city
  selected_city_data <- reactive({
    if (length(input$city_name) > 0) {
      filter(climate_change, city_name %in% input$city_name)
    } else {
      NULL
    }
  })
  
  # Define the color palette for the map
  palette <- colorFactor(palette = c("darkseagreen2", "darkseagreen", "darkolivegreen", "darkgreen", "black"),
                         levels = c("A", "B", "C", "D", "E"), na.color = "grey")
  
  # Build the map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = 0, lat = 30, zoom = 2) %>%
      addCircleMarkers(
        data = climate_change,
        lng = ~long,
        lat = ~lat,
        label = ~paste(city_name, ": ", emissions_quality_flag_cdp),
        stroke = FALSE,
        fillColor = ifelse(climate_change$city_name %in% input$city_name, "red", palette(climate_change$emissions_quality_flag_cdp)),
        fillOpacity = 1,
        radius = 5
      ) 
  })
  
  output$dynamic_text <- renderText({
    if (input$city_name != "") {
      paste("You have selected:", input$city_name)
    } else {
      "Please select a city to zoom in on."
    }
  })
  
  
  output$additional_info <- renderUI({
    additional_info_text <- HTML("
      <h3>Understanding Emissions Quality Flags</h3>
      <p>This map shows the relationship between a city's geographic location and its emissions flag rating. It aims to illustrate whether a city's location affects the type of data it reports and whether its size correlates with the quality of reported data.</p>
      
      <h4>Emissions Quality Flag (EQF) Definitions:</h4>
      <ul>
        <li><b>A:</b> TOT = S1 + S2: Total emissions (TOT) is the sum of Scope 1 (S1) and Scope 2 (S2) emissions.<br>
        TOT ≈ S1 + S2: Total emissions are approximately equal to the sum of Scope 1 and Scope 2 emissions.<br>
        TOT calculated by summing scopes since TOT = S1 or S2: Total emissions are calculated by summing scopes because TOT is either Scope 1 or Scope 2 emissions.</li>
        
        <li><b>B:</b> S3 included in total, but TOT = S1 + S2. Both cannot be true: Scope 3 emissions (S3) are included in the total emissions, but it contradicts the condition that TOT should equal the sum of S1 and S2.</li>
        
        <li><b>C:</b> S1 exists, S2 missing: Scope 1 emissions are reported, but Scope 2 emissions are missing (applies to 3 cities).<br>
        S2 exists, S1 missing (later derived): Scope 2 emissions are reported, but Scope 1 emissions are missing (applies to 6 cities).</li>
        
        <li><b>D:</b> Both scopes missing: Both Scope 1 and Scope 2 emissions data are missing.</li>
        
        <li><b>E:</b> S1 exists, S2 missing, and TOT = S1 + S2 = S1. S1 likely correct therefore TOT is incomplete: Scope 1 emissions are reported, Scope 2 emissions are missing, and total emissions equal Scope 1. Since total emissions should include Scope 2, the total is considered incomplete.</li>
      </ul>
      
      <p>Essentially, <b>A</b> means that the data collected from that city is accurate and useful. It contains all of the emissions data that we strive to analyze. Further down the alphabet, more information is missing.</p>
      
      <p>To best use this resource, search for the city you are looking for and notice its quality flag rating. When you use the other charts in this application, take into consideration how this flag rating (quality of data) impacts your analysis.</p>
    ")
    return(additional_info_text)
  })
        
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

