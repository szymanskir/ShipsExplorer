ShipsDataManager <- R6::R6Class(
  classname = "ShipsDataManager",
  
  private = list(
    ship_data = NA
  ),
  public = list(
    initialize = function(ship_data) {
      private$ship_data <- ship_data
    },
    
    get_ship_types = function() {
      unique(private$ship_data$ship_type) 
    },
    
    get_ships_of_given_type = function(type) {
      unique(private$ship_data[ship_type == type, SHIPNAME])
    }
  )
)