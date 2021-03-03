test_that("Distance tile is correctly updated", {
  x <- reactiveVal()
  
  testServer(app = distance_tile_server, args = list(ship_route = x), {
    x(list(distance = 30))
    session$flushReact()
    expect_equal(output$distance, "30m")
    
    x(list(distance = 500.321))
    session$flushReact()
    expect_equal(output$distance, "500.32m")
  })
  
})
