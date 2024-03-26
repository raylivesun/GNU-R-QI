#!/usr/bin/r

prop.test(42,100)
prop.test(42,100,conf.level=0.90)
## define a function
simple.z.test = function(x,sigma,conf.level=0.95) {
  n = length(x);xbar=mean(x)
  alpha = 1 - conf.level
  zstar = qnorm(1-alpha/2)
  SE = sigma/sqrt(n)
  xbar + c(-zstar*SE,zstar*SE)
}
## now try it
simple.z.test(x,1.5)
# matrix
t.test(x)

x=rnorm(100);y=rt(100,9)
boxplot(x,y)
qqnorm(x);qqline(x)
qqnorm(y);qqline(y)


xvals=seq(-4,4,.01)
plot(xvals,dnorm(xvals),type="l")
for(i in c(2,5,10,20,50)) points(xvals,dt(xvals,df=i),type="l",lty=i)


x = c(110, 12, 2.5, 98, 1017, 540, 54, 4.3, 150, 432)
wilcox.test(x,conf.int=TRUE)


f=function () mean(rnorm(15,mean=10,sd=5))
SE = 5/sqrt(15)
xbar = c(100)
alpha = 0.1;zstar = qnorm(1-alpha/2);sum(abs(xbar-10) < zstar*SE)
alpha = 0.05;zstar = qnorm(1-alpha/2);sum(abs(xbar-10) < zstar*SE)
alpha = 0.01;zstar = qnorm(1-alpha/2);sum(abs(xbar-10) < zstar*SE)


f = function(n=10,p=0.95) {
    y = rnorm(n,mean=0,sd=1+9*rbinom(n,1,1-p))
      t = (mean(y) - 0) / (sqrt(var(y))/sqrt(n))
}
sample = c(100)
qqplot(sample,rt(100,df=9),main="sample vs. t");qqline(sample)
qqnorm(sample,main="sample vs. normal");qqline(sample)
hist(sample)

prop.test(42,100,p=.5)
prop.test(420,1000,p=.5)


## Compute the t statistic. Note we assume mu=25 under H_0
xbar=22;s=1.5;n=10
t = (xbar-25)/(s/sqrt(n));t
## use pt to get the distribution function of t
pt(t,df=n-1)
