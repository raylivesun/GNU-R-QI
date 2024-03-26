#!/usr/bin/r

rnorm(1,100,16)
rnorm(1,mean=280,sd=10)


x=rnorm(100)
hist(x,probability=TRUE,col=gray(.9),main="normal mu=0,sigma=1")
curve(dnorm(x),add=T)

n=1; p=.5                      # set the probability
rbinom(1,n,p)                  # different each time
rbinom(10,n,p)                 # 10 different such numbers


n = 10; p=.5
rbinom(1,n,p)               # 6 successes in 10 trials
rbinom(5,n,p)                 # 5 binomial number


n=5;p=.25
# change as appropriate
x=rbinom(100,n,p)
# 100 random numbers
hist(x,probability=TRUE,)
## use points, not curve as dbinom wants integers only for x
xvals=0:n;points(xvals,dbinom(xvals,n,p),type="h",lwd=3)
points(xvals,dbinom(xvals,n,p),type="p",lwd=3)


x=rexp(100,1/2500)
hist(x,probability=TRUE,col=gray(.9),main="exponential mean=2500")
curve(dexp(x,1/2500),add=T)


## Roll a lives
sample(1:6,10,replace=TRUE)
# no sixes!
## toss a coin
sample(c("H","T"),10,replace=TRUE)
## pick 6 of 54 (a lottery)
sample(1:54,6)
# no replacement
## pick a card. (Fancy! Uses paste, rep)
cards = paste(rep(c("A",2:10,"J","Q","K"),4),c("H","D","S","C"))
sample(cards,5)
# a pair of jacks, no replacement

## roll 2 lives. Even fancier
dice = as.vector(outer(1:6,1:6,paste))
sample(dice,5,replace=TRUE) # replace when rolling dice

