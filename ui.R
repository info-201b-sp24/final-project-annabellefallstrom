# libraries
library(shiny)
library(plotly)
library(readxl)
library(leaflet)


# introduction page
intro_pg <- tabPanel(
  "Introduction",
  h3("Introduction"),
  p("Introduction tab."),
  tabsetPanel(
    tabPanel(
      "Brief Introduction",
      h4(
        "Climate change has become a global epidemic, with human activities
         strongly impacting the Earth’s biodiversity, ecosystems, and,
        ultimately, the atmosphere. This causes tremendous concerns as these
        climate changes negatively influence other important natural resources
        such as our terrestrial, oceanic, glaciological, and hydrological
        ecosystems. As the effects of climate change multiply through the years
        to come, it is imperative to inform ourselves of its impacts and explore
        effective mitigation and adaptation strategies. This project aims to
        investigate the multifaceted effects of climate change on various
        environmental ecosystems and provide insights."
      ),
      img(src = "ghgi.png", height = "400px", width = "600px")
    ),
    tabPanel(
      "Research Questions",
      h4(
        "How has the climate change and greenhouse gas emissions changed over
        time?"
      ),
      p(
        " - With our data, we can see the trends around carbon emissions over
        the years. Analyzing this data could teach us about how temperatures
        have changed across the world."
      ),
      p(
        " - This data would help us understand possible hypotheses correlating
        temperature changes to other environmental factors, such as natural
        disasters."
      )
    ),
    tabPanel(
      "Our Data",
      h4("Content for Sub-tab 2"),
      p(
        "Data was found on PANGEA, an open-access library for georeferenced data
        from earth system research."
      ),
      a(
        "https://doi.pangaea.de/10.1594/PANGAEA.884141",
        href = "https://doi.pangaea.de/10.1594/PANGAEA.884141"
      ),
      p(
        "First, the researchers scoped the data from the Carbon Disclosure
        Project (CDP) about greenhouse gas emissions. This data was collected
        through online response systems, where people could report climate 
        hazards. Governments disclosed emissions data. Then, they separated CO2 
        emissions from non-CO2 greenhouse gas emissions. Then, they integrated 
        datasets about emissions from developing countries from the Carbon
        Climate Registry."
      ),
      p(
        "Since cities are concentrations of population, energy use, and economic
        output, they are important focal points for investigating emission
        drivers and mitigation options. This prompts across-city comparative
        analyses of greenhouse gas emissions and energy use."
      ),
      p(
        "The authors declare that there are no competing interests for this
        dataset. We would like to consider the political and policy implications
        of the findings of this data and hold those responsible for the
        emissions accountable."
      )
    ),
    tabPanel(
      "Ethics and limitations",
      h4("Content for Sub-tab 3"),
      p(
        "One possible limitation of this dataset is that the data collected by 
        the Carbon Disclosure Project relies on self-reported data about climate
        hazards and emissions from cities. The problem is that cities could have
        a political agenda and might disclose fewer emissions than they
        produced. It also means that the data is a bit biased; cities
        self-select to disclose their emissions data, meaning many cities can 
        choose not to disclose their emissions data. This means the sample of
        data is non-random. This data is also intended to compare carbon dioxide
        emissions across many cities but only has information on 343 cities, a
        fraction of the cities in the entire world. Since these cities chose to
        declare their carbon dioxide emissions and have the means to track them,
        there might not be enough diversity among the cities to have a good
        comparison. This diversity would include city size, economic standing,
        geographic factors, and city production. Diversity among cities is
        important to narrow down what factors contribute to climate change. Such
        a small sample size might not be able to do this. The creators of this
        dataset also do not define a city. Is it determined by area? Population?
        Governments? This is an important aspect to consider when comparing
        cities since we need to know what we are comparing."
      ),
      p(
        "Some limitations to address with our project would be data on smaller
        countries, cities, and locations without the technology to record data
        properly. Our data isn’t fully complete; most of the data from our data
        set was self-reported rather than hand-collected. We have to count for
        slight inaccuracies in our data analysis."
      ),
      p(
        "In our project proposal, we targeted many different effects of climate
        change. It could be challenging to manage and properly analyze all the
        data. Studying all the different side effects of climate change could
        make our proposal too broad and limit its effectiveness. Comparatively,
        if we only focused on one specific part of climate change, we could come
        up with a much deeper conclusion in that specific topic. However, that
        would make our proposal too narrow in scope. In our proposal, we must
        find the middle ground of covering all of our topics while fully
        answering our research questions."
      )
    )
  )
)


# chart page 1
chrt1_pg <- tabPanel(
  "Chart 1",
  titlePanel("Countries With the Highest Emissions"),
  
  mainPanel(
    h3("Content Area"),
    p("Plots and details here"),
    plotlyOutput("emissionsPlot"),
    radioButtons(
      inputId = "emissions_selector",
      label = "Emissions Type",
      choices = list(
        "Scope 1 GHG emissions" = "Scope1_Emissions",
        "Total emissions (CDP)" = "Total_Emissions_CDP"
      ),
      selected = "Total_Emissions_CDP"
    )
  )
)

# Define the UI layout
ui <- fluidPage(
  navbarPage(
    "Emissions Analysis",
    chrt1_pg
  )
)


# chart page 2
chrt2_pg <- tabPanel(
  "Chart 2",
  titlePanel("Quality Flag Rating by City"),
  
  # Sidebar with a drop down box for city names
  sidebarLayout(
    sidebarPanel(
      img(src = "www/legend.jpg", height = "200px", width = "200px"),
      
      selectInput(inputId = 'city_name',
                  label = 'City to zoom in on:',
                  choices = c("", unique(
                    read_excel("./D_FINAL.xlsx")$`City name`
                  )),
                  selected = ""), # Set the default selection here
      # The default option is an empty string to show the whole map
      textOutput("dynamic_text") # Display dynamic text in the sidebar
    ),

    
    # Show the map
    mainPanel(
      leafletOutput('map'),
      uiOutput("legend") 
    ),
  ),
  
  # Text generated dynamically from the server
  fluidRow(
    column(
      12,
      div(
        style = "padding: 20px; background-color: #f9f9f9; border-top: 1px solid #ddd;",
        uiOutput("additional_info")  # Display the additional information text
      )
    )
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
    p(
      "Evidently, climate change is a global issue that requires immediate
      attention. Our data analysis identifies trends and patterns including
      greenhouse gas emissions (CO2) per country, and larger causes for the
      emissions such as diesel and gas used. Our data table allowed for us to
      easily pull important information based off the Emission Quality Flag
      ratings, to sort out the amounts of greenhouse gases emitted. Ultimately,
      with such data, we were able to identify that China, Japan, Netherlands,
      South Korea, Taiwan, United Kingdom, and USA were the top amongst emitting
      CO2. The city with the highest emissions per person was Ürümqi (Wulumqi),
      China. Additionally, we could identify a notable correlation between gas
      prices and CO2 emissions; higher gas prices are associated with lower CO2
      emissions per capita, likely due to reduced fuel consumption. Emissions
      flag ratings were also mapped out, so that we could easily identify
      geographic regions with their respective impact on CO2 emissions, with the
      top producers being North America, East Asia, and Latin America &
      Caribbean. Ultimately, this highlights the areas with significant impact
      on the global ecosystem. This underscores the importance of both economic
      factors and regional policies in addressing climate change. Given this
      information, we could tackle the problem of climate change more
      effectively, by narrowing down the many factors that contribute, such as
      the CO2 emissions per country and regions. We also did some investigating
      into how the data was collected, specifically which gases were counted as
      emissions, and found that the most commonly recorded groups were CO2; CH4;
      N2O, CO2, and CO2; CH4; N2O; HFCs; PFCs; SF6, and the group with the
      highest average emissions was CO2; CH4; SF6; N2O. With this understanding,
      we are able to have a much better understanding of our societal
      development's impact on our ecosystem, in order to develop effective
      strategies to mitigate the impacts of climate change. It is crucial that
      we take action now to protect our planet for future generations."
    )
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