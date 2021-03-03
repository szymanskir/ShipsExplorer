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
      private$ship_data$ship_type %>% 
        unique() %>% 
        sort()
    },
    
    get_ships_of_given_type = function(type) {
      checkmate::assert_string(type)
      
      private$ship_data[ship_type == type, SHIPNAME] %>% 
        unique() %>% 
        sort()
    },
    
    get_longest_distance_route = function(ship_name) {
      checkmate::assert_string(ship_name)
      
      ship_observations <- private$ship_data[SHIPNAME == ship_name, ][order(DATETIME)]
      
      max_distance_info <- calculate_max_travelled_distance(ship_observations$LAT, ship_observations$LON)
      start <- ship_observations[max_distance_info$index, .(LAT, LON)]
      stop <- ship_observations[max_distance_info$index + 1, .(LAT, LON)]
      
      list(
        start = c(start$LAT, start$LON),
        stop = c(stop$LAT, stop$LON),
        distance = max_distance_info$distance
      )
    }
  )
)