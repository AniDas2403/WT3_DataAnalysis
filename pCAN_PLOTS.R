library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)

setwd("F:/Desk/Winter2021/WT-CivilWebsite/Report")
path <- getwd()

pCAN_WC <- read_csv("pCAN_DA_WC.csv")
colnames(pCAN_WC) <- c("index", "word", "word_count", "PER")
pCAN_WC <- pCAN_WC %>% mutate(word = reorder(word, word_count))
pCAN_WC_Plot <- pCAN_WC %>% filter(word_count >= 4)

G_pCAN <- pCAN_WC_Plot %>% 
  ggplot(aes(word_count, word)) +
  geom_col() +
  labs(y = NULL) + 
  ggtitle("Most Common Words present in the responses from the professors") +
  xlab("Word Count")
G_pCAN
