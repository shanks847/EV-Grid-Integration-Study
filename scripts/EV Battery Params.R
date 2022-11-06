soc <- function(time)
{
  return(17.5 + 0.0064187*time) #this was from function estimation of the data, the lowest the battery could dropw as 17.5%

}

t <- seq(from=0, to=1328, by=30)
soc_vals <- lapply(t,soc)
  