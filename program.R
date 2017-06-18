
rm(list=ls())
#set working directory
setwd("D:/Users/TM35460/Desktop/capstone/build")
#library needed
library(RWeka)
library(dplyr)
library(stringi)
library(tm)
library(RWeka)
library(ggplot2)

## Read in the files
news    <- readLines("D:/Users/TM35460/Desktop/capstone/build/en_US.twitter33.txt", encoding = "UTF-8", skipNul = TRUE)
news <- iconv(news, "latin1", "ASCII", sub="")
sample_data <- c(sample(news, length(news)))

corpus <- VCorpus(VectorSource(sample_data))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, PlainTextDocument)


six_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))

six_matrix <- TermDocumentMatrix(corpus, control = list(tokenize = six_tokenizer))

six_corpus <- findFreqTerms(six_matrix,lowfreq=5)
six_corpus;

#six_corpus_freq <- rowSums(as.matrix(six_matrix[six_corpus,]))
#six_corpus_freq <- data.frame(word=names(six_corpus_freq), frequency=six_corpus_freq)

write.csv(six_corpus, file = "twitter33.csv", row.names = FALSE)
