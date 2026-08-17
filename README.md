# WA Nursing Home Quality Dashboard

An R Shiny dashboard for exploring nursing home quality across Washington State, built with CMS Care Compare data.

**Author:** Robel Girma

## Demo
Deployment to shinyapps.io was attempted but blocked by a known compatibility issue between the `terra` package (a transitive dependency of `leaflet`) 
and shinyapps.io's server-side GDAL library version. The app runs correctly in a local R/Shiny environment — see the demo video below.

[Watch the demo video](demo/dashboard_demo.mp4)

## Features
- Interactive map with facility markers color-coded by overall rating
- County and minimum-rating filters
- Six live KPI summaries
- Fines-by-rating and staffing-vs-rating charts
- Searchable, sortable facility data table
- Clickable facility detail popups
- About modal with data sources and methodology

## How to Run Locally
1. Clone this repository
2. Open `app/ui.R` or `app/server.R` in RStudio
3. Click "Run App"

## Data Source
CMS Care Compare (https://data.cms.gov/provider-data/topics/nursing-homes), filtered to Washington State (193 facilities).