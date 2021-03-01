library(shiny.semantic)

ui <- semanticPage(
  card(
    div(class = "content", "ShinyExplorer")
  )
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
