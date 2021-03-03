test_that("Ships Data Manager returns all unique available types of ships", { 
  ships_data <- data.table::data.table(
    SHIPNAME = c("KAROLI", "KAROLI", "KERLI", "REDUT"),
    ship_type = c("Cargo", "Cargo", "Cargo", "Tug")
  )
  
  ships_data_manager <- ShipsDataManager$new(ships_data)
  
  result <- ships_data_manager$get_ship_types()
  
  expect_equal(result, c("Cargo", "Tug"))
})

test_that("Ships Data Manager returns types of ships in sorted order", { 
  ships_data <- data.table::data.table(
    SHIPNAME = c("KAROLI", "KAROLI", "KERLI", "REDUT"),
    ship_type = c("Tug", "Tug", "Tug", "Cargo")
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

test_that("Ships Data Manager returns all unique ships of given type in sorted order", {
  ships_data <- data.table::data.table(
    SHIPNAME = c("KERLI", "KERLI", "KAROLI"),
    ship_type = c("Cargo", "Cargo", "Cargo")
  )
  
  ships_data_manager <- ShipsDataManager$new(ships_data)
  
  result <- ships_data_manager$get_ships_of_given_type("Cargo")
  
  expect_equal(result, c("KAROLI", "KERLI"))
})

test_that("Ships Data Manager returns the shortest route correctly", {
  ships_data <- data.table::data.table(
    LAT = c(50, 55, 55, 55),
    LON = c(50, 60, 65, 55),
    DATETIME = c(
      ISOdatetime(2020, 1, 1, 10, 0, 0, "UTC"),
      ISOdatetime(2020, 1, 1, 11, 0, 0, "UTC"),
      ISOdatetime(2020, 1, 1, 12, 0, 0, "UTC"),
      ISOdatetime(2020, 1, 1, 10, 0, 0, "UTC")
    ),
    SHIPNAME = c("KAROLI", "KAROLI", "KAROLI", "REDUT"),
    ship_type = c("Cargo", "Cargo", "Cargo", "Tug")
  )
  
  ships_data_manager <- ShipsDataManager$new(ships_data)
  
  result <- ships_data_manager$get_longest_distance_route("Cargo", "KAROLI")
  
  expect_true(all(c("start", "stop", "distance") %in% names(result)))
  expect_equal(result$start, c(50, 50))
  expect_equal(result$stop, c(55, 60))
})

test_that("Ships Data Manager returns the shortest route correctly when data is not sorted", {
  ships_data <- data.table::data.table(
    LAT = c(50, 55, 55, 55),
    LON = c(50, 65, 60, 55),
    DATETIME = c(
      ISOdatetime(2020, 1, 1, 10, 0, 0, "UTC"),
      ISOdatetime(2020, 1, 1, 12, 0, 0, "UTC"),
      ISOdatetime(2020, 1, 1, 11, 0, 0, "UTC"),
      ISOdatetime(2020, 1, 1, 10, 0, 0, "UTC")
    ),
    SHIPNAME = c("KAROLI", "KAROLI", "KAROLI", "REDUT"),
    ship_type = c("Cargo", "Cargo", "Cargo", "Tug")
  )
  
  ships_data_manager <- ShipsDataManager$new(ships_data)
  
  result <- ships_data_manager$get_longest_distance_route("Cargo", "KAROLI")
  
  expect_true(all(c("start", "stop", "distance") %in% names(result)))
  expect_equal(result$start, c(50, 50))
  expect_equal(result$stop, c(55, 60))
})