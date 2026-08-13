library(shiny)
library(leaflet)
library(readr)
library(ggplot2)

server <- function(input, output, session) {
  
  wa_nursing_homes <- read_csv("../data/clean/wa_nursing_homes.csv") 
    
  observe({
    updateSelectInput(
      session,
      inputId = "county_filter",
      choices = c("All", sort(unique(wa_nursing_homes$county))),
      selected = "All"
    )
  })
  
  filtered_data <- reactive({
    data <- wa_nursing_homes
    
    if (input$county_filter != "All") {
      data <- data[data$county == input$county_filter, ]
    }
    
    data <- data[data$overall_rating >= input$rating_filter | is.na(data$overall_rating), ]
    
    data
  })  
  
  output$kpi_count <- renderText({
    nrow(filtered_data())
  })
  
  output$kpi_avg_rating <- renderText({
    round(mean(filtered_data()$overall_rating, na.rm = TRUE), 2)
  })
  
  output$kpi_avg_staffing <- renderText({
    round(mean(filtered_data()$total_nursing_hours, na.rm = TRUE), 2)
  })
  
  output$kpi_avg_rn <- renderText({
    round(mean(filtered_data()$rn_hours, na.rm = TRUE), 2)
  })
  
  output$kpi_total_fines <- renderText({
    round(sum(filtered_data()$total_fines, na.rm = TRUE), 0)
  })
  
  output$kpi_pct_high_rated <- renderText({
    data <- filtered_data()
    pct <- mean(data$overall_rating >= 4, na.rm = TRUE) * 100
    paste0(round(pct, 1), "%")
  })
  
  output$staffing_rating_plot <- renderPlot({
    data <- filtered_data()
    
    summary_data <- aggregate(
      total_nursing_hours ~ overall_rating,
      data = data,
      FUN = mean,
      na.rm = TRUE
    )
    
    ggplot(summary_data, aes(x = factor(overall_rating), y = total_nursing_hours)) +
      geom_col(fill = "steelblue") +
      labs(
        x = "Overall Rating",
        y = "Avg Total Nursing Hours",
        title = "Average Staffing Hours by Overall Rating"
      ) +
      theme_minimal()
  })
  
  pal <- colorNumeric(palette = "RdYlGn", domain = wa_nursing_homes$overall_rating)
  
  output$map <-renderLeaflet({
    leaflet(filtered_data()) %>%
      addTiles()%>%
      addCircleMarkers(
        lng = ~longitude, 
        lat = ~latitude, 
        popup = ~provider_name, 
        color = ~pal(overall_rating),
        radius = 6,
        fillOpacity = 0.8) %>%
      addLegend(
        position = "bottomright",
        pal = pal,
        values = ~overall_rating,
        opacity = 1
      )
    
  })
  
  
  
  
}