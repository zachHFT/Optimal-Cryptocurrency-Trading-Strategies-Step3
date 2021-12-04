library(imputeTS)
library(dplyr)

impute <- function(prices, gap){
  prices <- prices %>%
    mutate(timestamp = as.POSIXlt(timestamp, format = "%Y-%m-%d %H:%M:%S")) %>%
    complete(timestamp = seq(min(timestamp), max(timestamp), by=gap))
  
  close_with_na <- with(prices, close)
  prices$close <- na_kalman(close_with_na)

  return(prices)
}