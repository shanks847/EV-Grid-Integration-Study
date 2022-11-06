library(tidyverse)
library(dplyr)
library(ggplot2)
library(fitdistrplus)

#importing data
setwd('C:/Users/Shankar Ramharack/OneDrive - The University of the West Indies, St. Augustine/Desktop/EV-Grid-Integration-Study')
l1_start_times <- read.csv('data/L1_start_times.csv')
colnames(l1_start_times) <- c('start_time(mins)')
l2_start_times <- read.csv('data/L2_start_times.csv')
colnames(l2_start_times) <- c('start_time(mins)')
l1_durations <- read.csv('data/l1_durations_xformed.csv')
l2_durations <- read.csv('data/l2_durations_xformed.csv')

dplyr::glimpse(l1_durations)

#Getting Descriptive statistics
#descdist(l1_start_times$`start_time(mins)`)


fitdist(l1_start_times$`start_time(mins)`, "cauchy")

###################### DISTR FIT #######################3
# Fit specific distributions
# Note: you will need to change the distribution names

dists <- c("dgeom","dweibull")
fit <- list()
for (i in 1:length(dists)){
  fit[[i]]  <- fitdist(l1_durations$durations, dists[i])
}

for (i in 1:length(dists)){
  print(summary(fit[[i]]))
}

#Plot the fitting results
#par(mfrow=c(2,2))
plot.legend <- dists
denscomp(fit, legendtext = plot.legend)
cdfcomp (fit, legendtext = plot.legend)
qqcomp  (fit, legendtext = plot.legend)
ppcomp  (fit, legendtext = plot.legend)

# Goodness of fit statistics
# Don't forget to match your fitnames argument to your named distributions above
f <- gofstat(fit, fitnames=dists)
f


