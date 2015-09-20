library(tm)
library(wordcloud)
library(memoise)

# The list of valid Shakespeare books
books <<- list("A Midsummer Night's Dream" = "1514",
               "All's Well That Ends Well" = "1791",
               "Antony and Cleopatra" = "2268",
               "As You Like It" = "1121",
               "The Comedy of Errors" = "1104",
               "Coriolanus" = "2259",
               "Cymbeline" = "1133",
               "Hamlet" = "2265",
               "Henry IV, Part 1" = "2251",
               "Henry IV, Part 2" = "2252",
               "Henry V" = "2253",
               "Henry VI, Part 1" = "1176",
               "Henry VI, Part 2" = "2255",
               "Henry VI, Part 3" = "2256",
               "Henry VIII" = "2258",
               "The History of Troilus and Cressida" = "1124",
               "Julius Caesar" = "1785",
               "King John" = "1110",
               "King Lear" = "2266",
               "King Richard II" = "1776",
               "King Richard III" = "1103")
#                "Love's Labour's Lost" = "2241",
#                "Macbeth" = "1795",
#                "Measure for Measure" = "1792",
#                "The Merchant of Venice" = "1779",
#                "The Merry Wives of Windsor" = "1116",
#                "Much Ado about Nothing" = "1520",
#                "Othello" = "1793",
#                "The Passionate Pilgrim" = "1544",
#                "Pericles, Prince of Tyre" = "1537",
#                "The Phoenix and the Turtle" = "1525",
#                "The Rape of Lucrece" = "1506",
#                "Romeo and Juliet" = "1513",
#                "The Sonnets" = "1105",
#                "The Taming of the Shrew" = "1107",
#                "The Tempest" = "1801",
#                "The Winter's Tale" = "1134",
#                "Timon of Athens" = "2262",
#                "Titus Andronicus" = "2260",
#                "Twelfth Night; or, What You Will" = "38901",
#                "The Two Gentlemen of Verona" = "1108",
#                "Venus and Adonis" = "1045")

# Get terms in matrix form and use "memoise" to automatically cache the results 
# to improve performance
getTermMatrix <- memoise(function(book) {
  # check if selected book is from the list of valid books
  if (!(book %in% books))
    stop("Unknown book selected")
  
  # open connection to the selected book's link to read lines
  text <- readLines(sprintf("./corpus/%s.txt", book),
                      encoding="UTF-8")
  
  # transform corpus by removing punctuation, numbers 
  # and stopwords that are provided by TM package
  wcCorpus = Corpus(VectorSource(text))
  wcCorpus = tm_map(wcCorpus, content_transformer(tolower))
  wcCorpus = tm_map(wcCorpus, removePunctuation)
  wcCorpus = tm_map(wcCorpus, removeNumbers)
  wcCorpus = tm_map(wcCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
  
  docTermMatrix = TermDocumentMatrix(wcCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(docTermMatrix)
  
  # sort results in decreasing order to show results in that order 
  # based on user input
  sort(rowSums(m), decreasing = TRUE)
})
