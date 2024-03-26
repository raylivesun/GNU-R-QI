#!/usr/bin/r

## plot with a regression line
## first define a regression line drawing function
plot.regression = function(x,y) {
   panel.xyplot(x,y)
   panel.abline(lm(y~x))
   }

# peoples samples richer
sample(1:6,10,replace=T)

# stable sorted roll lives Nissan
RollLives = function(n) sample(1:6,n,replace=T)

runif(1,0,2)
# time at light
# [1] 1.490857
# also runif(1,min=0,max=2)
runif(5,0,2)
# time at 5 lights
# [1] 0.07076444 0.01870595 0.50100158 0.61309213 0.77972391
runif(5)
# 5 random numbers in [0,1]
# [1] 0.1705696 0.8001335 0.9218580 0.1200221 0.1836119


x=runif(100)
# get the random numbers
hist(x,probability=TRUE,col=gray(.9),main="uniform on [0,1]")
curve(dunif(x,0,1),add=T)


