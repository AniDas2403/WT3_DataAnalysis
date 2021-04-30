library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)
library(reshape2)
library(tm)
library(wordcloud)

setwd("F:/Desk/Winter2021/WT-CivilWebsite/Report")
path <- getwd()

sCAN_S_A <- read_csv("sCAN_DA_S_AFINN.csv")
sCAN_S_B <- read_csv("sCAN_DA_S_BING.csv")
colnames(sCAN_S_A) <- c("index", "word", "word_count", "PER", "value")
colnames(sCAN_S_B) <- c("index", "word", "word_count", "PER", "sentiment")

AVG_sCAN <- sum(sCAN_S_A$value*sCAN_S_A$word_count)/sum(sCAN_S_A$word_count)

I_sCAN_pnw <- sCAN_S_B %>%
  dplyr::count(word, sentiment, sort=TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors =c("gray20", "gray80"))

G_sCAN_S <- sCAN_S_B %>%
  group_by(sentiment) %>%
  ungroup() %>%
  mutate(word = reorder(word, word_count)) %>%
  ggplot(aes(word_count, word, fill=sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment,scales = "free_y") +
  labs(x = "Contribution to sentiment", y = NULL)
G_sCAN_S
