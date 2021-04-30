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
file <- "sCAN/total.txt"

dt_1_sCAN <- unname(sapply(file, readLines))
dt_1_sCAN <- as_tibble(dt_1_sCAN)
colnames(dt_1_sCAN) <- c("text")
dt_1_sCAN <- dt_1_sCAN %>% dplyr::mutate(linenumber = row_number())
dt_sCAN <- dt_1_sCAN %>% unnest_tokens(word, text)
dt_td_sCAN <- dt_sCAN %>% anti_join(stop_words)
dt_td_sCAN_c <- dt_td_sCAN %>% dplyr::count(word, sort = TRUE)
TD_sCAN <- dt_td_sCAN_c

WC <- as.numeric(TD_sCAN$n)
S<- sum(WC)
TD_sCAN <- TD_sCAN %>% mutate(per = (n/S)*100)

TD_sCAN_S_A <- TD_sCAN %>% inner_join(get_sentiments("afinn"))
TD_sCAN_S_B <- TD_sCAN %>% inner_join(get_sentiments("bing"))

write.csv(TD_sCAN, "sCAN_DA_WC.csv")
write.csv(TD_sCAN_S_A,"sCAN_DA_S_AFINN.csv")
write.csv(TD_sCAN_S_B,"sCAN_DA_S_BING.csv")



