library(sass)
library(shiny.semantic)

ships_data_manager <- ShipsDataManager$new(data.table::fread("data/ships.csv"))

ui <- semanticPage(
  includeCSS("www/styles.css"),
  ship_route_map_ui("ship_route_map"),
  ship_selection_menu_ui("ship_selection")
)

server <- function(input, output, session) {
  ship_route_map_server("ship_route_map", ship_route)
  ship_selection_data <- ship_selection_menu_server("ship_selection", ships_data_manager)
  
  ship_route <- reactive({
    req(ship_selection_data$ship_name())
    ships_data_manager$get_longest_distance_route(ship_selection_data$ship_name())
  })
  
}

shinyApp(ui, server)
