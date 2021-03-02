.draw_initial_map <- function() {
  leaflet::leaflet() %>% 
    leaflet::addProviderTiles(
      provider = leaflet::providers$CartoDB.Positron
    )
}

ship_route_map_ui <- function(id) {
  ns <- NS(id)
  div(
    leaflet::leafletOutput(outputId = ns("map"), height = "80vh")
  )
}

ship_route_map_server <- function(id, ship_route) {
  moduleServer(
    id,
    function(input, output, session) {
      output$map <- leaflet::renderLeaflet({
        .draw_initial_map()
      })
      
      observeEvent(ship_route(), {
        
        map_data <- matrix(
          c(rev(ship_route()$start), rev(ship_route()$stop)),
          byrow = TRUE,
          nrow = 2
        )
        
        mean_lat <- (ship_route()$start[1] + ship_route()$stop[1]) / 2
        mean_lon <- (ship_route()$start[2] + ship_route()$stop[2]) / 2
        
        leaflet::leafletProxy("map", data = map_data) %>% 
          leaflet::clearMarkers() %>% 
          leaflet::clearShapes() %>% 
          leaflet::addMarkers() %>% 
          leaflet::addPolylines() %>% 
          leaflet::fitBounds(
            lng1 = ship_route()$start[2],
            lat1 = ship_route()$start[1],
            lng2 = ship_route()$stop[2],
            lat2 = ship_route()$stop[1]
          ) %>% 
          leaflet::addMiniMap(tiles = leaflet::providers$CartoDB.Positron)
      })
    }
  )
}