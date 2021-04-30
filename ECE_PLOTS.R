library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)

setwd("F:/Desk/Winter2021/WT-CivilWebsite/Report")
path <- getwd()

ECE_WC <- read_csv("ECE_DA_WC.csv")
colnames(ECE_WC) <- c("index", "word", "word_count", "PER")
ECE_WC <- ECE_WC %>% mutate(word = reorder(word, word_count))
ECE_WC_Plot <- ECE_WC %>% filter(word_count >= 5)

G_ECE <- ECE_WC_Plot %>% 
      ggplot(aes(word_count, word)) +
      geom_col() +
      labs(y = NULL) + 
      ggtitle("Most Common Words present in ECE professors' responses") +
      xlab("Word Count")
G_ECE
