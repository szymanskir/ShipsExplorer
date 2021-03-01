test_that("Ships Data Manager returns all unique available types of ships", { 
  ships_data <- data.table::data.table(
    SHIPNAME = c("KAROLI", "KAROLI", "KERLI", "REDUT"),
    ship_type = c("Cargo", "Cargo", "Cargo", "Tug")
  )
  
  ships_data_manager <- ShipsDataManager$new(ships_data)
  
  result <- ships_data_manager$get_ship_types()
  
  expect_equal(result, c("Cargo", "Tug"))
})


test_that("Ships Data Manager returns all unique ships of given type", {
  ships_data <- data.table::data.table(
    SHIPNAME = c("KAROLI", "KAROLI", "KERLI", "REDUT"),
    ship_type = c("Cargo", "Cargo", "Cargo", "Tug")
  )
  
  ships_data_manager <- ShipsDataManager$new(ships_data)
  
  result <- ships_data_manager$get_ships_of_given_type("Cargo")
  
  expect_equal(result, c("KAROLI", "KERLI"))
})