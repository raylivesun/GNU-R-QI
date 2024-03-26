#!/usr/bin/r

data(faithful)
# part of R’s base
names(faithful)
# find the names for faithful
eruptions = faithful[["eruptions"]] # or attach and detach faithful
sample(eruptions,10,replace=TRUE)

pnorm(.7)                     # standard normal
pnorm(.7,1,1)                 # normal mean 1, std 1

pnorm(.7,lower.tail=F)
qnorm(.75)


x = rnorm(5,100,16);x
z = (x-100)/16;z


pnorm(z)
pnorm(x,100,16)


rnorm(5,mean=0,sd=1:5)


n=10;p=.25;S= rbinom(1,n,p)
(S - n*p)/sqrt(n*p*(1-p))


n = 10;p = .25;S = rbinom(100,n,p)
X = (S - n*p)/sqrt(n*p*(1-p)) # has 100 random numbers

hist(X,prob=T)


