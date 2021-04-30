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
file <- "pCAN/total.txt"

dt_1_pCAN <- unname(sapply(file, readLines))
dt_1_pCAN <- as_tibble(dt_1_pCAN)
colnames(dt_1_pCAN) <- c("text")
dt_1_pCAN <- dt_1_pCAN %>% dplyr::mutate(linenumber = row_number())
dt_pCAN <- dt_1_pCAN %>% unnest_tokens(word, text)
dt_td_pCAN <- dt_pCAN %>% anti_join(stop_words)
dt_td_pCAN_c <- dt_td_pCAN %>% dplyr::count(word, sort = TRUE)

word_no <- as.numeric(dt_td_pCAN_c$word)
i <- which(word_no != "N/A")
TD_pCAN <- dt_td_pCAN_c[-i,]

WC <- as.numeric(TD_pCAN$n)
S<- sum(WC)
TD_pCAN <- TD_pCAN %>% mutate(per = (n/S)*100)

TD_pCAN_S_A <- TD_pCAN %>% inner_join(get_sentiments("afinn"))
TD_pCAN_S_B <- TD_pCAN %>% inner_join(get_sentiments("bing"))

write.csv(TD_pCAN, "pCAN_DA_WC.csv")
write.csv(TD_pCAN_S_A,"pCAN_DA_S_AFINN.csv")
write.csv(TD_pCAN_S_B,"pCAN_DA_S_BING.csv")



