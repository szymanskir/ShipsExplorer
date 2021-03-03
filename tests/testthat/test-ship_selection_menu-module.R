testthat("Dropdown fields are updated correctly", {
  ships_data <- data.table::data.table(
    SHIPNAME = c("KAROLI", "KAROLI", "KERLI", "REDUT"),
    ship_type = c("Cargo", "Cargo", "Cargo", "Tug")
  )
  
  ships_data_manager <- ShipsDataManager$new(ships_data)
  
  testServer(ship_selection_menu_server, args = list(ships_data_manager = ships_data_manager), {
    session$setInputs(ship_type_dropdown = "Tug")
    
    expect_equal(ship_names_list(), c("REDUT"))
  })
    
})
  