#!/usr/bin/r

x = c(.314,.289,.282,.279,.275,.267,.266,.265,.256,.250,.249,.211,.161)
tmp = hist(x)
# store the results
lines(c(min(tmp$breaks),tmp$mids,max(tmp$breaks)),c(0,tmp$counts,0),type="l")

data(faithful)
attach(faithful)
# make eruptions visible
hist(eruptions,15,prob=T)
# proportions, not frequencies
lines(density(eruptions))
# lines makes a curve, default bandwidth
lines(density(eruptions,bw="SJ"),col="green") # Use SJ bandwidth, in red

