library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)

setwd("F:/Desk/Winter2021/WT-CivilWebsite/Report")
path <- getwd()

sCAN_WC <- read_csv("sCAN_DA_WC.csv")
colnames(sCAN_WC) <- c("index", "word", "word_count", "PER")
sCAN_WC <- sCAN_WC %>% mutate(word = reorder(word, word_count))
sCAN_WC_Plot <- sCAN_WC %>% filter(word_count >= 4)

G_sCAN <- sCAN_WC_Plot %>% 
  ggplot(aes(word_count, word)) +
  geom_col() +
  labs(y = NULL) + 
  ggtitle("Most Common Words present in the responses for students in Canada") +
  xlab("Word Count")
G_sCAN
