library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)
library(reshape2)
library(tm)
library(wordcloud)

setwd("F:/Desk/Winter2021/WT-CivilWebsite/Report")
path <- getwd()

ECE_S_A <- read_csv("ECE_DA_S_AFINN.csv")
ECE_S_B <- read_csv("ECE_DA_S_BING.csv")
colnames(ECE_S_A) <- c("index", "word", "word_count", "PER", "value")
colnames(ECE_S_B) <- c("index", "word", "word_count", "PER", "sentiment")

AVG_ECE <- sum(ECE_S_A$value*ECE_S_A$word_count)/sum(ECE_S_A$word_count)

I_ECE_pnw <- ECE_S_B %>%
  dplyr::count(word, sentiment, sort=TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors =c("gray20", "gray80"))
