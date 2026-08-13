library(shiny)
library(leaflet)

ui <- fluidPage(
  titlePanel("WA Nursing Home Quality Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = 'county_filter',
        label = 'county',
        choices = c("All"),
        selected = 'All'
      ),
      
      sliderInput(
        inputId ='rating_filter',
        label = 'Minimum Overall Rating',
        min = 1,
        max = 5,
        value = 1,
        step = 1
      )
      
    ),
    
    mainPanel(
      fluidRow(
        column(4, h4("Facilities Shown"), textOutput("kpi_count")),
        column(4, h4("Avg Overall Rating"), textOutput("kpi_avg_rating")),
        column(4, h4("Avg Staffing Hours"), textOutput("kpi_avg_staffing"))
      ),
      
      hr(),
      leafletOutput("map")
      
    )
  )
)
