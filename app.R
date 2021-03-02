library(sass)
library(shiny.semantic)

ships_data_manager <- ShipsDataManager$new(data.table::fread("data/ships.csv"))

grid_template <- shiny.semantic::grid_template(
  default = list(
    areas = rbind(
      c("header"),
      c("map")
    ),
    cols_width = c("100%"),
    rows_height = c("100px", "auto")
  ),
  mobile = list(
    areas = rbind(
      "header",
      "map"
    ),
    rows_height = c("400px", "auto"),
    cols_width = c("100%")
  )
)

ui <- semanticPage(
  includeCSS("www/styles.css"),
  shiny.semantic::grid(
    grid_template,
    map = ship_route_map_ui("ship_route_map"),
    header = div(
      class = "dashboard-header",
      h1(class = "ui header", icon("ship"), div(class = "content", "Ships Explorer")),
      ship_selection_menu_ui("ship_selection"),
      div(
        div(
          class = "ui huge center aligned header distance-banner",
          icon("ruler"),
          div(
            class = "content",
            textOutput(outputId = "distance"),
            div(class = "sub header", "Distance")
          )
        )
      ),
    )
  )
)

server <- function(input, output, session) {
  ship_route_map_server("ship_route_map", ship_route)
  ship_selection_data <- ship_selection_menu_server("ship_selection", ships_data_manager)
  
  ship_route <- reactive({
    req(ship_selection_data$ship_name())
    ships_data_manager$get_longest_distance_route(ship_selection_data$ship_name())
  })
  
  output$distance <- renderText({
    paste0(round(ship_route()$distance, 2), "m")
  })
}

shinyApp(ui, server)
