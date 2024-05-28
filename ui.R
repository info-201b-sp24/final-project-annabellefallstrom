<<<<<<< HEAD

first_tab_panel <- tabPanel("First graph",
                                    h1("add graph title"),
                                    
)


second_tab_panel <- tabPanel("Second graph",
                             h1("TO DO: Add another graph here.")

                             
i <- fluidPage(
  
  # Application title
  titlePanel('Search the world'),
  
  # Sidebar with a drop down box for city names
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = 'city_name',
                  label = 'City to zoom in on:',
                  choices = climate_change$city_name)
    ),
    
    # Show the map
    mainPanel(
     leafletOutput('map')
    )
  )
)
)


third_tab_panel <- tabPanel("third graph",
                            h1("add graph title"),
                            
)

ui <- navbarPage("Add title",
                 first_tab_panel,
                 secont_tab_panel,
                 third_tab_panel
=======

maternity_leave_by_plot <- tabPanel("Maternity Leave By Country",
                                    h1("Maternity Leave By Country"),
                                    
                                    sidebarLayout(
                                      sidebarPanel(
                                        h2("Options for Graph"),
                                        selectInput(inputId = "country_select",
                                                    label = "Select Countries",
                                                    choices = maternity_df$Country.Name,
                                                    selected = "Ireland",
                                                    multiple = TRUE)
                                      ),
                                      mainPanel(
                                        h2("Maternity Leave by Country Plot"),
                                        plotlyOutput(outputId = "maternity_plotly")
                                      )
                                    )
)


secont_tab_panel <- tabPanel("Second graph",
                             h1("TO DO: Add another graph here.")
)

ui <- navbarPage("Maternity Leave",
                 maternity_leave_by_plot,
                 secont_tab_panel
>>>>>>> a1e2bfad1bb5811e937082fdd6da97eac2fbf5ab
)
