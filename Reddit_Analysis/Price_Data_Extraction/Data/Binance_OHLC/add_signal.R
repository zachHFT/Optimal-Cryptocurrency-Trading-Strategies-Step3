add_signal <- function(prices, signal){
  #signal should be a named list 
  
  for (sign in names(signal)){
    prices$sign <- signal[[sign]]
  }
  
  return(list('prices_with_signal'=prices))
}