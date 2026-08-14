library(shiny)
library(leaflet)
library(ggplot2)
library(DT)

# UI
ui <- fluidPage(
  titlePanel("WA Nursing Home Quality Dashboard"),
  
  sidebarLayout(
    
 # SIDEBAR Filters,KPIs and Legend 
    sidebarPanel(
      
# Filtering 
      selectInput(
        inputId = 'county_filter',
        label = 'county',
        choices = c("All"),
        selected = 'All'
      ),
      
      sliderInput(
        inputId = 'rating_filter',
        label = 'Minimum Overall Rating',
        min = 1,
        max = 5,
        value = 1,
        step = 1
      ),
      
#Performance Indicator cards

   div(style = "background-color:#2c7fb8; color:white; padding:15px; margin-bottom:10px; border-radius:6px;",
    icon("hospital", style="font-size:20px;"),
      h3(textOutput("kpi_count"), style="margin:5px 0 0 0;"),
      p("Facilities Shown", style="margin:0;")
      ),

#  KPI for Overall Ratings  -----------------------------------------------

div(style = "background-color:#2c7fb8; color:white; padding:15px; margin-bottom:10px; border-radius:6px;",
   icon("star", style="font-size:20px;"),
   h3(textOutput("kpi_avg_rating"), style="margin:5px 0 0 0;"),
  p("Avg Overall Rating", style="margin:0;")
      ),

#  KPI for Avg staffing Hours  --------------------------------------------

div(style = "background-color:#2c7fb8; color:white; padding:15px; margin-bottom:10px; border-radius:6px;",
          icon("user-nurse", style="font-size:20px;"),
          h3(textOutput("kpi_avg_staffing"), style="margin:5px 0 0 0;"),
          p("Avg Staffing Hours", style="margin:0;")
      ),

#  KPI for Nurse Hrs ------------------------------------------------------

div(style = "background-color:#2c7fb8; color:white; padding:15px; margin-bottom:10px; border-radius:6px;",
  icon("user-doctor", style="font-size:20px;"),
  h3(textOutput("kpi_avg_rn"), style="margin:5px 0 0 0;"),
p("Avg RN Hours", style="margin:0;")
      ),
      

#  KPI for Total Fines  ---------------------------------------------------

 div(style = "background-color:#e34a33; color:white; padding:15px; margin-bottom:10px; border-radius:6px;",
          icon("triangle-exclamation", style="font-size:20px;"),
          h3(textOutput("kpi_total_fines"), style="margin:5px 0 0 0;"),
          p("Total Fines", style="margin:0;")
      ),

#  KPI for Facilites Rating  ----------------------------------------------

div(style = "background-color:#41ab5d; color:white; padding:15px; margin-bottom:10px; border-radius:6px;",
          icon("circle-check", style="font-size:20px;"),
          h3(textOutput("kpi_pct_high_rated"), style="margin:5px 0 0 0;"),
          p("% Rated 4+ Stars", style="margin:0;")
      ),
      
      hr(),
      
#  Legend/(color Key) 
      div(style = "padding: 10px;",
          h5("Color Key", style="margin-bottom:12px; font-size:18px;"),
          p(span(style="display:inline-block; width:20px; height:20px; background-color:#2c7fb8; margin-right:10px; border-radius:4px; vertical-align:middle;"), 
            span("Informational", style="font-size:16px; vertical-align:middle;")),
          p(span(style="display:inline-block; width:20px; height:20px; background-color:#e34a33; margin-right:10px; border-radius:4px; vertical-align:middle;"), 
            span("Needs attention", style="font-size:16px; vertical-align:middle;")),
          p(span(style="display:inline-block; width:20px; height:20px; background-color:#41ab5d; margin-right:10px; border-radius:4px; vertical-align:middle;"), 
            span("Positive indicator", style="font-size:16px; vertical-align:middle;"))
      )
    ),
    
 # MAIN PANEL Map, Table, Charts 
    mainPanel(
      
 # Map ----
      leafletOutput("map"),
      
#  Facility Table ----
      DTOutput("facility_table"),
      
      hr(),
      
 # Charts Bar chart + Scatter plot side by side 
      fluidRow(
        style = "margin: 0;",
        column(6, style = "padding: 0;",
               plotOutput("staffing_rating_plot", width = "100%", height = "350px")
        ),
        column(6, style = "padding: 0;",
               plotOutput("staffing_scatter_plot", width = "100%", height = "350px")
        )
      )
    )
  )
)