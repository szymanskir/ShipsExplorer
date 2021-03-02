library(sass)
library(shiny.semantic)

ships_data_manager <- ShipsDataManager$new(data.table::fread("data/ships.csv"))

grid_template <- shiny.semantic::grid_template(
  default = list(
    areas = rbind(
      c("title", "map"),
      c("controls", "map")
    ),
    cols_width = c("300px", "1fr"),
    rows_height = c("50px", "auto")
  ),
  mobile = list(
    areas = rbind(
      "title",
      "map",
      "controls"
    ),
    rows_height = c("50px", "100px", "auto", "200px"),
    cols_width = c("100%")
  )
)

ui <- semanticPage(
  includeCSS("www/styles.css"),
  shiny.semantic::grid(
    grid_template,
    title = h1(class = "ui header", icon("ship"), div(class = "content", "Ships Explorer")),
    map = ship_route_map_ui("ship_route_map"),
    controls = div(
      ship_selection_menu_ui("ship_selection"),
      div(
        class = "ui raised segment",
        div(
          class = "ui header",
          icon("route"),
          div(
            class = "content",
            "Distance"
          )
        ),
        div(
          class = "ui huge center aligned header",
          style = "font-size: 4em",
          textOutput(outputId = "distance")
        )
      )
    ),
    area_styles = list(controls = "margin: 10px", title = "margin: 10px")
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
