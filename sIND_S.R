library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)
library(reshape2)
library(tm)
library(wordcloud)

setwd("F:/Desk/Winter2021/WT-CivilWebsite/Report")
path <- getwd()

sIND_S_A <- read_csv("sIND_DA_S_AFINN.csv")
sIND_S_B <- read_csv("sIND_DA_S_BING.csv")
colnames(sIND_S_A) <- c("index", "word", "word_count", "PER", "value")
colnames(sIND_S_B) <- c("index", "word", "word_count", "PER", "sentiment")

AVG_sIND <- sum(sIND_S_A$value*sIND_S_A$word_count)/sum(sIND_S_A$word_count)

I_sIND_pnw <- sIND_S_B %>%
  dplyr::count(word, sentiment, sort=TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors =c("gray20", "gray80"))

G_sIND_S <- sIND_S_B %>%
  group_by(sentiment) %>%
  ungroup() %>%
  mutate(word = reorder(word, word_count)) %>%
  ggplot(aes(word_count, word, fill=sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment,scales = "free_y") +
  labs(x = "Contribution to sentiment", y = NULL)
G_sIND_S
