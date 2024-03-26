#!/usr/bin/r

f = function(n=100,p=.5) {
   S = rbinom(1,n,p)
   (S- n*p)/sqrt(n*p*(1-p))
}

the.range = function (x) max(x) - min(x)

find.IQR = function(x) {
   five.num = fivenum(x)
   five.num[4] - five.num[2]
}

x = rnorm(100)
find.IQR
function(x) {
  five.num = fivenum(x)
  five.num[4] - five.num[2]
}
find.IQR(x)


f = function(n=100,mu=0,sigma=1) {
   nos = rnorm(n,mu,sigma)
   (mean(nos)-mu)/(sigma/sqrt(n))
}


xvals = seq(-3,3,.01) # for the density plot

k = 1;sigma = 1
n = length(x)
sum( -k*sigma <x & x< k*sigma)/n


f=function(n,a=0,b=1) {
  mu=(b+a)/2
  sigma=(b-a)/sqrt(12)
  (mean(runif(n,a,b))-mu)/(sigma/sqrt(n))
}

median.normal = function(n=100) median(rnorm(100,0,1))
mean.normal = function(n=100) mean(rnorm(100,0,1))


mean.exp = function(n=100) mean(rexp(n,1/10))
median.exp = function(n=100) median(rexp(n,1/10))


## symmetric: short, regular then long
X=runif(100);boxplot(X,horizontal=T,bty=n)
X=rnorm(100);boxplot(X,horizontal=T,bty=n)
X=rt(100,2);boxplot(X,horizontal=T,bty=n)
## skewed: short, regular then long
# triangle distribution
X=sample(1:6,100,p=7-(1:6),replace=T);boxplot(X,horizontal=T,bty=n)
X=abs(rnorm(200));boxplot(X,horizontal=T,bty=n)
X=rexp(200);boxplot(X,horizontal=T,bty=n)

n = length(x)                        # how big is x?
z = log(x[2:n]);log(x[1:n-1])        # This does X_n/X_(n-1)



