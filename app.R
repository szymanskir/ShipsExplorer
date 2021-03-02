library(sass)
library(shiny.semantic)

ships_data_manager <- ShipsDataManager$new(data.table::fread("data/ships.csv"))

ui <- semanticPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/styles.css")
  ),
  shiny.semantic::grid(
    create_grid_template(),
    map = ship_route_map_ui("ship_route_map"),
    header = div(
      class = "dashboard-header",
      h1(class = "ui header", icon("ship"), div(class = "content", "Ships Explorer")),
      ship_selection_menu_ui("ship_selection"),
      distance_tile_ui("distance_info")
    )
  )
)

server <- function(input, output, session) {
  ship_route_map_server("ship_route_map", ship_route)
  distance_tile_server("distance_info", ship_route)
  ship_selection_data <- ship_selection_menu_server("ship_selection", ships_data_manager)
  
  ship_route <- reactive({
    req(ship_selection_data$ship_name())
    ships_data_manager$get_longest_distance_route(ship_selection_data$ship_name())
  })
}

shinyApp(ui, server)
