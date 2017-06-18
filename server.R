### Data Science Capstone : Course Project
### server.R file for the Shiny app
### Github repo : https://github.com/justusfrantz/capstone

suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))

# Load Quadgram,Trigram & Bigram Data frame files

pentagram <- readRDS("combine5gram.RData")
quadgram <- readRDS("combine4gram.RData")
trigram <- readRDS("combine3gram.RData")
bigram <- readRDS("combine2gram.RData")
unigram <- readRDS("combine1gram.RData") 
mesg <<- ""

# Cleaning of user input before predicting the next word

Predict <- function(x) {
  y <- x
  xclean <- removeNumbers(removePunctuation(tolower(x)))
  xs <- strsplit(xclean, " ")[[1]]
  
  # Back Off Algorithm
  # Predict the next term of the user input sentence
  # 1. For prediction of the next word, Quadgram is first used (first three words of Quadgram are the last three words of the user provided sentence).
  # 2. If no Quadgram is found, back off to Trigram (first two words of Trigram are the last two words of the sentence).
  # 3. If no Trigram is found, back off to Bigram (first word of Bigram is the last word of the sentence)
  # 4. If no Bigram is found, back off to the most common word with highest frequency 'the' is returned.
  if (length(xs)>= 5) {
    xs <- tail(xs,5)
    if (identical(character(0),head(pentagram[pentagram$sentence == y, 2],1))){
      Predict(paste(xs[2],xs[3],xs[4], xs[5],sep=" "))
    }
    else {mesg <<- "Next word is predicted using 5-gram."; head(pentagram[pentagram$sentence == y, 2],1)}
  }  
  else  if (length(xs)== 4) {
    xs <- tail(xs,4)
    if (identical(character(0),head(quadgram[quadgram$sentence == y, 2],1))){
      Predict(paste(xs[2],xs[3],xs[4],sep=" "))
    }
    else {mesg <<- "Next word is predicted using 5-gram."; head(quadgram[quadgram$sentence == y, 2],1)}
  }  
  else if (length(xs)== 3) {
    xs <- tail(xs,3)
    if (identical(character(0),head(trigram[trigram$sentence == y, 2],1))){
      Predict(paste(xs[2],xs[3],sep=" "))
    }
    else {mesg <<- "Next word is predicted using 4-gram."; head(trigram[trigram$sentence == y, 2],1)}
  }
  else if (length(xs) == 2){
    xs <- tail(xs,2)
    if (identical(character(0),head(bigram[bigram$sentence == y, 2],1))) {
      Predict(xs[2])
    }
    else {mesg<<- "Next word is predicted using 3-gram."; head(bigram[bigram$sentence == y, 2],1)}
  }
  else if (length(xs) == 1){
    xs <- tail(xs,1)
    if (identical(character(0),head(unigram[unigram$sentence == y, 2],1))) {mesg<<-"No match found. Most common word 'the' is returned."; head("the",1)}
    else {mesg <<- "Next word is predicted using 2-gram."; head(unigram[unigram$sentence == y, 2],1)}
  }
}


shinyServer(function(input, output) {
  output$prediction <- renderPrint({
    result <- Predict(input$inputString)
    output$text2 <- renderText({mesg})
    result
  });
  
  output$text1 <- renderText({
    input$inputString});
}
)