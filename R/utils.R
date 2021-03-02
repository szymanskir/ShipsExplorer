calculate_geo_distance <- function(x, y) {
  geosphere::distm(x, y)
}

calculate_lagged_geo_distance <- function(lat_vec, lon_vec) {
  checkmate::assert_numeric(lat_vec)
  checkmate::assert_numeric(lon_vec)
  checkmate::assert_true(length(lat_vec) == length(lon_vec))
  
  vec_length <- length(lat_vec)
  
  sapply(seq_len(length(lat_vec) - 1), function(index) {
    calculate_geo_distance(
      x = c(lat_vec[index], lon_vec[index]),
      y = c(lat_vec[index + 1], lon_vec[index + 1])
    )[1]
  })
}

calculate_max_travelled_distance <- function(lat_vec, lon_vec) {
  lagged_geo_distance <- calculate_lagged_geo_distance(lat_vec, lon_vec)
  
  max_distance <- max(lagged_geo_distance)
  max_index <- tail(which(lagged_geo_distance == max_distance), n = 1)
  
  list(
    distance = max_distance,
    index = max_index
  )
}