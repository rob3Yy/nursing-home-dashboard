library(shiny)
library(leaflet)
library(readr)
library(ggplot2)
library(DT)

server <- function(input, output, session) {
  
# load the data
wa_nursing_homes <- read_csv("../data/clean/wa_nursing_homes.csv") 
  
 # populate county drop down from the data
  observe({
    updateSelectInput(
      session,
      inputId = "county_filter",
      choices = c("All", sort(unique(wa_nursing_homes$county))),
      selected = "All"
    )
  })
  
# filters the data based on county + rating slider
  filtered_data <- reactive({
data <- wa_nursing_homes
    
if (input$county_filter != "All") {
  data <- data[data$county == input$county_filter, ]
    }
data <- data[data$overall_rating >= input$rating_filter | is.na(data$overall_rating), ]
data
  })  
 # KPI stuff
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
  
  output$kpi_pct_high_rated <- renderText({
    data <- filtered_data()
    pct <- mean(data$overall_rating >= 4, na.rm = TRUE) * 100
    paste0(round(pct, 1), "%")
  })
  
  
# bar chart - avg staffing per rating group
  output$fines_rating_plot <- renderPlot({
    data <- filtered_data()
    
    summary_data <- aggregate(
      total_fines ~ overall_rating,
      data = data,
      FUN = mean,
      na.rm = TRUE
    )
    
    ggplot(summary_data, aes(x = factor(overall_rating), y = total_fines)) +
      geom_col(fill = "#e34a33") +
      geom_text(aes(label = paste0("$", format(round(total_fines), big.mark = ","))), 
                vjust = -0.5, size = 4) +
      scale_y_continuous(labels = scales::dollar) +
      labs(
        x = "Overall Star Rating (1–5 Stars)",
        y = "Average Fine per Facility ($)",
        title = "Average Fines by Overall Rating"
      ) +
      theme_minimal()
  })
  
# scatter plot - staffing hours per facility
  output$staffing_scatter_plot <- renderPlot({
    data <- filtered_data()
    
    ggplot(data, aes(x = overall_rating, y = total_nursing_hours)) +
      geom_jitter(width = 0.15, alpha = 0.6, color = "steelblue") +
      geom_smooth(method = "lm", se = TRUE, color = "darkred", linewidth = 1) +
      labs(
        x = "Overall Rating",
        y = "Total Nursing Hours",
        title = "Staffing Hours by Facility"
      ) +
      theme_minimal()
  })
  
 # facility table
  output$facility_table <- renderDT({
    data <- filtered_data()[, c("provider_name", "city", "county", "overall_rating", "total_nursing_hours")]
    data$total_nursing_hours <- round(data$total_nursing_hours, 1)
    data
  })

 # map stuff
  pal <- colorNumeric(palette = "RdYlGn", domain = wa_nursing_homes$overall_rating)
  
  output$map <- renderLeaflet({
    leaflet(filtered_data()) %>%
      setView(lng = -120.5, lat = 47.4, zoom = 7) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~longitude, 
        lat = ~latitude, 
        popup = ~provider_name, 
        fillColor = ~pal(overall_rating),
        color = "black",
        weight = 2.5,
        radius = 6,
        fillOpacity = 0.9
      ) %>%
      addLegend(
        position = "bottomright",
        pal = pal,
        values = ~overall_rating,
        opacity = 1
      )
  })
  
}