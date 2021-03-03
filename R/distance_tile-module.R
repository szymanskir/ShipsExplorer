distance_tile_ui <- function(id) {
  ns <- NS(id)
  div(
    div(
      class = "ui huge center aligned header distance-banner",
      icon("ruler"),
      div(
        class = "content",
        textOutput(outputId = ns("distance")),
        div(class = "sub header", "Distance")
      )
    )
  )
}

distance_tile_server <- function(id, ship_route) {
  moduleServer(
    id,
    function(input, output, session) {
      output$distance <- renderText({
        paste0(round(ship_route()$distance, 2), "m")
      })
    }
  )
}