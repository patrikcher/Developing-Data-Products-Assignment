library(shiny)

# shiny server codes
function(input, output, session) {
  # define a reactive expression for the document term matrix
  terms <- reactive({
    # change main panel when the "update" button is pressed
    input$update
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$selection)
      })
    })
  })
  
  # make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  # plot wordcloud
  output$wordcloud <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale = c(4, 0.5),
                  min.freq = input$freq, max.words = input$max,
                  colors=brewer.pal(8, "Dark2"))
  })
}