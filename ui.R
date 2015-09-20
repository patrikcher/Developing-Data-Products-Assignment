#setwd("/Users/patrickcher/Dropbox/Learning/Data Science/JHU Data Science/09 Developing Data Products/Shiny Assignment")

library(shiny)

# shiny ui codes
fluidPage(
  # title
  titlePanel("Word cloud generated from a selection of Shakespeare's books"),
  
  sidebarLayout(
    # sidebar with dropdown list and sliders
    sidebarPanel(
      selectInput("selection", "Choose a book:",
                  choices = books),
      actionButton("update", "Change"),
      hr(),
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 1,  max = 50, value = 15),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 300,  value = 100)
      ),
    
      # plot wordcloud
      mainPanel(
        plotOutput("wordcloud")
      )
    )
  )
