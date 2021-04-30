library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)

setwd("F:/Desk/Winter2021/WT-CivilWebsite/Report")
path <- getwd()

sIND_WC <- read_csv("sIND_DA_WC.csv")
colnames(sIND_WC) <- c("index", "word", "word_count", "PER")
sIND_WC <- sIND_WC %>% mutate(word = reorder(word, word_count))
sIND_WC_Plot <- sIND_WC %>% filter(word_count >= 3)

G_sIND <- sIND_WC_Plot %>% 
  ggplot(aes(word_count, word)) +
  geom_col() +
  labs(y = NULL) + 
  ggtitle("Most Common Words present in Indian students' responses") +
  xlab("Word Count")
G_sIND
