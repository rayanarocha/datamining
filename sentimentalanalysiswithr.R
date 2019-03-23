#https://rpubs.com/giuice/analisesentimentos1

install.packages("twitteR")
install.packages("tidyverse")
install.packages("data.table")
install.packages("tidytext")
install.packages("glue")
install.packages("stringr")
install.packages("stringi")
install.pa?kages("rvest")
install.packages("readr")
install.packages("ptstem")
install.packages("wordcloud2")
install.packages("dplyr")
install.packages("tm")
install.packages("xml2")
install.packages("rvest")
#install.packages("magrittr")

library(twitteR)
library(t?dyverse)
library(data.table)
library(tidytext)
library(glue)
library(stringr)
library(stringi)
library(rvest)
library(readr)
library(ptstem)
library(wordcloud2)
library(dplyr)
library(tm)
library(xml2)
library(rvest)
#library(magrittr)

key <- "fz4wfqMy7a9?QLUvSXQPnyAiQ"
secret <- "FLkFdJAhoePQpxkvERXrSogrOIDurzo0pp8E19T46z6hVJfM8v"
token <- "39617930-k0rPfgmk5YmgY6MjFFmyKjmor0JPQ6YJo7h8bH47I"
secretk <- "bwFSjlEPOinRYt41wH5GBno3wucsFO7OGVpyEaBgd6n5X"

setup_twitter_oauth(key, secret, token, secretk)

trends?rasil <- getTrends(woeid = 23424768)
# 10 primeiros apenas
trendsBrasil$name[1:10]
head(trendsBrasil)
#outros woeid
availableTrendLocations()

#CoisaMaisLinda
coisamaislindatwetts <- searchTwitter("CoisaMaisLinda", n = 100)
head(coisamaislindatwetts)

#tip? da Base
class(coisamaislindatwetts)

#tamanho da Base
length(coisamaislindatwetts)

#limpando o html, trocando br por tags
stopwordsPage <- read_html("https://www.ranks.nl/stopwords/brazilian", enconding="UTF-8")
stopwordsList <- html_nodes(stopwordsPage,?td')
xml_find_all(stopwordsList, ".//br") %>% xml_add_sibling("p", "")
xml_find_all(stopwordsList, ".//br") %>% xml_remove()
swstr <- html_text(stopwordsPage)
#tratando os dados para transformar em um dicionário
sw <- unlist(str_split(swstr,'\\n')) 
glimp??(sw)

#carregando o stopwords da tm
swList2 <- stopwords('portuguese')
glimpse(swList2)

#fazendo um merge, usando a biblioteca tidyverse que é extremamente util fazemos o merge
str(sw)

sw_merged <- union(sw,swList2) 
summary(sw_merged)

#verificando se?n??o há elementos repetidos
tibble(word = sw_merged) %>% 
  group_by(word) %>% 
  filter(n()>1)

#carregando os termos de polaridade
an <- read.csv("adjetivos_negativos.txt", header = F, sep = "\t", strip.white = F,
               stringsAsFactors = F, en?od??g="UTF-8")
exn <- read.csv("expressoes_negativas.txt", header = F, sep = "\t", strip.white = F,
                stringsAsFactors = F, encoding="UTF-8")

vn <- read.csv("verbos_negativos.txt", header = F, sep = "\t", strip.white = F, 
               str?ng??sFactors = F, encoding="UTF-8")

subn <- read.csv("substantivos_negativos.txt", header = F, sep = "\t", strip.white = F, 
                 stringsAsFactors = F, encoding="UTF-8")

ap <- read.csv("adjetivos_positivos.txt", header = F, sep = "\t", strip.?hi?? = F, 
               stringsAsFactors = F, encoding="UTF-8")

exp <- read.csv("expressoes_positivas.txt", header = F, sep = "\t", strip.white = F, 
                stringsAsFactors = F, encoding="UTF-8")

vp <- read.csv("verbos_positivos.txt", header ? F??sep = "\t", strip.white = F, 
               stringsAsFactors = F, encoding="UTF-8")

sp <- read.csv("substantivos_positivos.txt", header = F, sep = "\t", strip.white = F, 
               stringsAsFactors = F, encoding="UTF-8")