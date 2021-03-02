test_that("lagged geo distance is calculated correctly", {
  lat <- c(0, 10, 20)
  lon <- c(10, 20, 40)
  
  mockery::stub(calculate_lagged_geo_distance, "calculate_geo_distance", calculate_manhattan_distance)
  
  result <- calculate_lagged_geo_distance(lat, lon)
  
  expect_equal(result, c(20, 30))
})

test_that("maximum distance is selected", {
  lat <- c(0, 10, 20)
  lon <- c(10, 20, 40)
  
  mockery::stub(calculate_max_travelled_distance, "calculate_lagged_geo_distance", function(...) c(20, 30))
  
  result <- calculate_max_travelled_distance(lat, lon)
  expected_result <- list(
    distance = 30,
    index = 2
  )
  
  expect_equal(result, expected_result)
})

test_that("last maximum distance is selected if doubled", {
  lat <- c(0, 10, 20)
  lon <- c(10, 20, 40)
  
  mockery::stub(calculate_max_travelled_distance, "calculate_lagged_geo_distance", function(...) c(20, 30, 30, 10))
  
  result <- calculate_max_travelled_distance(lat, lon)
  expected_result <- list(
    distance = 30,
    index = 3
  )
  
  expect_equal(result, expected_result)
})