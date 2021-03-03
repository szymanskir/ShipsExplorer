test_that("Server e2e reactive graph smoke test", {
  withr::local_envvar(R_CONFIG_ACTIVE = "test")
  
  expect_silent({
    testServer(expr = {
      session$setInputs(`ship_selection-ship_type_dropdown` = "Cargo")
      session$setInputs(`ship_selection-ship_name_dropdown` = "KAROLI")
    })
  })
})
