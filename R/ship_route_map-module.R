.draw_initial_map <- function() {
  leaflet::leaflet() %>% 
    leaflet::addProviderTiles(
      provider = leaflet::providers$CartoDB.Positron
    )
}

ship_route_map_ui <- function(id) {
  ns <- NS(id)
  leaflet::leafletOutput(outputId = ns("map"), height = "100%")
}

ship_route_map_server <- function(id, ship_route) {
  moduleServer(
    id,
    function(input, output, session) {
      output$map <- leaflet::renderLeaflet({
        .draw_initial_map()
      })
      
      observeEvent(ship_route(), {
        
        # It is assumed that coordinates are vectors of form c(lat, lon)
        start_lat <- ship_route()$start[1]
        start_lon <- ship_route()$start[2]
        stop_lat <- ship_route()$stop[1]
        stop_lon <- ship_route()$stop[2]
        
        map_data <- data.frame(
          lat = c(start_lat, stop_lat),
          lon = c(start_lon, stop_lon),
          color = c("green", "red")
        )
          
        leaflet::leafletProxy("map", data = map_data) %>% 
          leaflet::clearMarkers() %>% 
          leaflet::clearShapes() %>% 
          leaflet::addAwesomeMarkers(
            lng = ~lon,
            lat = ~lat,
            icon = leaflet::makeAwesomeIcon("circle", library = "fa", markerColor = ~color, iconColor = "white")
          ) %>% 
          leaflet::addPolylines(
            lng = ~lon,
            lat = ~lat
          ) %>% 
          leaflet::fitBounds(
            lng1 = start_lon,
            lat1 = start_lat,
            lng2 = stop_lon,
            lat2 = stop_lat
          ) %>% 
          leaflet::addMiniMap(width = 250, height = 250, tiles = leaflet::providers$CartoDB.Positron)
      })
    }
  )
}