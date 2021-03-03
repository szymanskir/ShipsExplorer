ship_selection_menu_ui <- function(id) {
  ns <- NS(id)
    div(
      class = "ship-selection-menu-container",
      div(
        shiny.semantic::selectInput(
          inputId = ns("ship_type_dropdown"),
          label = "Ship type:",
          choices = ""
        )
      ),
      div(
        shiny.semantic::selectInput(
          inputId = ns("ship_name_dropdown"),
          label = "Ship Name:",
          choices = ""
        )
      )
  )
}

ship_selection_menu_server <- function(id, ships_data_manager) {
  moduleServer(
    id,
    function(input, output, session) {
      ship_type <- reactive({ input$ship_type_dropdown })
      ship_name <- reactive({ input$ship_name_dropdown })
      
      ship_names_list <- reactive({
        ships_data_manager$get_ships_of_given_type(input$ship_type_dropdown)
      })
      
      shiny.semantic::updateSelectInput(
        session = session,
        inputId = "ship_type_dropdown",
        choices = ships_data_manager$get_ship_types()
      )
      
      observeEvent(ship_names_list(), {
        ship_names <- ship_names_list()
        
        shiny.semantic::updateSelectInput(
          session = session,
          inputId = "ship_name_dropdown",
          choices = ship_names,
          selected = ship_names[1]
        )
      })
      
      return(
        list(
          ship_type = ship_type,
          ship_name = ship_name
        )
      )
    }
  )
}
