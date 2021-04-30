library(dplyr)
library(plyr)
library(readr)
library(stringr)
library(tidytext)
library(tidyverse)
library(ggplot2)
data(stop_words)

setwd("F:/Desk/Winter2021/WT-CivilWebsite/Report")
path <- getwd()
file <- "ECE/total.txt"

dt_1_ECE <- unname(sapply(file, readLines))
dt_1_ECE <- as_tibble(dt_1_ECE)
colnames(dt_1_ECE) <- c("text")
dt_1_ECE <- dt_1_ECE %>% dplyr::mutate(linenumber = row_number())
dt_ECE <- dt_1_ECE %>% unnest_tokens(word, text)
dt_td_ECE <- dt_ECE %>% anti_join(stop_words)
dt_td_ECE_c <- dt_td_ECE %>% dplyr::count(word, sort = TRUE)

word_no <- as.numeric(dt_td_ECE_c$word)
i <- which(word_no != "N/A")
TD_ECE <- dt_td_ECE_c[-i,]

WC <- as.numeric(TD_ECE$n)
S<- sum(WC)
TD_ECE <- TD_ECE %>% mutate(per = (n/S)*100)

TD_ECE_S_A <- TD_ECE %>% inner_join(get_sentiments("afinn"))
TD_ECE_S_B <- TD_ECE %>% inner_join(get_sentiments("bing"))

write.csv(TD_ECE, "ECE_DA_WC.csv")
write.csv(TD_ECE_S_A,"ECE_DA_S_AFINN.csv")
write.csv(TD_ECE_S_B,"ECE_DA_S_BING.csv")



