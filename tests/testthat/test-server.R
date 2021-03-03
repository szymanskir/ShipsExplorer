test_that("Server e2e reactive graph smoke test", {
  withr::local_envvar(R_CONFIG_ACTIVE = "test")
  
    testServer(expr = {
      expect_silent({
        session$setInputs(`ship_selection-ship_type_dropdown` = "Cargo")
        session$setInputs(`ship_selection-ship_name_dropdown` = "KAROLI")
        
        expect_true(!is.null(ship_route()))
      })
    })
})
