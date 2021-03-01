library(sass)
library(shiny.semantic)

ships_data_manager <- ShipsDataManager$new(data.table::fread("data/ships.csv"))

ui <- semanticPage(
  includeCSS("www/styles.css"),
  ship_selection_menu_ui("ship-selection")
)

server <- function(input, output, session) {
  ship_selection_data <- ship_selection_menu_server("ship-selection", ships_data_manager)
}

shinyApp(ui, server)
