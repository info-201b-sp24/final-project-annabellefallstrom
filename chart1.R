library(shiny)
library(dplyr)
library(readxl)
library(ggplot2)
library(plotly)

# Define the server logic
server <- function(input, output) {
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

# Run the application
shinyApp(ui = ui, server = server)
