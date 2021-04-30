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
file <- "sIND/total.txt"

dt_1_sIND <- unname(sapply(file, readLines))
dt_1_sIND <- as_tibble(dt_1_sIND)
colnames(dt_1_sIND) <- c("text")
dt_1_sIND <- dt_1_sIND %>% dplyr::mutate(linenumber = row_number())
dt_sIND <- dt_1_sIND %>% unnest_tokens(word, text)
dt_td_sIND <- dt_sIND %>% anti_join(stop_words)
dt_td_sIND_c <- dt_td_sIND %>% dplyr::count(word, sort = TRUE)
TD_sIND <- dt_td_sIND_c

WC <- as.numeric(TD_sIND$n)
S<- sum(WC)
TD_sIND <- TD_sIND %>% mutate(per = (n/S)*100)

TD_sIND_S_A <- TD_sIND %>% inner_join(get_sentiments("afinn"))
TD_sIND_S_B <- TD_sIND %>% inner_join(get_sentiments("bing"))

write.csv(TD_sIND, "sIND_DA_WC.csv")
write.csv(TD_sIND_S_A,"sIND_DA_S_AFINN.csv")
write.csv(TD_sIND_S_B,"sIND_DA_S_BING.csv")



