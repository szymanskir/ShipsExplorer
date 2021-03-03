create_grid_template <- function() {
  shiny.semantic::grid_template(
    default = list(
      areas = rbind(
        c("header"),
        c("map")
      ),
      cols_width = c("100%"),
      rows_height = c("100px", "auto")
    ),
    mobile = list(
      areas = rbind(
        "header",
        "map"
      ),
      rows_height = c("400px", "auto"),
      cols_width = c("100%")
    )
  )
}