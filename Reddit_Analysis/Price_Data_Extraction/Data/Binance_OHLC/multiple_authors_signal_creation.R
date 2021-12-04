library(tidyverse)
library(dplyr)

##Read files
filenames <- list.files(pattern="+_posts_nrstmin.*csv")

##Create list of author names using filenames 
names <-sub("_.*", "", filenames)

post_times <- list()
for (i in 1:length(filenames)){
  post_times[[i]] <- as.data.frame(read.csv(filenames[i]))$X0
}
names(post_times) <- names

source("add_signal.R")
source("create_signal.R")
source("impute.R")

btc_authors <- c("simplelifestyle", "CoinCorner_Sam")

ETHUSD1m <- as.data.frame(read.csv("ETHUSDT-1m-binance.csv"))
BTCUSD1m <- as.data.frame(read.csv("BTCUSDT-1m-binance.csv"))

ETHUSD1m.imputed <- impute(prices=ETHUSD1m, gap="min")
BTCUSD1m.imputed <- impute(prices=BTCUSD1m, gap="min")

signals <- list()
for (i in 1:length(filenames)){
  if(names(post_times)[i] %in% btc_authors){
    signals[[i]] <- create_signal(post_times[[i]], BTCUSD1m, 'min')
  }else{
    signals[[i]] <- create_signal(post_times[[i]], ETHUSD1m, 'min')
  }
}
names(signals) <- names

