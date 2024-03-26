#!/usr/bin/r


results =numeric(0)
# a place to store the results
for (i in 1:100) {
  # the for loop
  S = rbinom(1,n,p)
  # just 1 this time
  results[i]=(S- n*p)/sqrt(n*p*(1-p)) # store the answer
}

primes=c(2,3,5,7,11);
## loop over indices of primes with this
for(i in 1:5) print(primes[i])
## or better, loop directly
for(i in primes) print(i)


results = c();
mu = 0; sigma = 1
for(i in 1:200) {
  X = rnorm(100,mu,sigma)
  # generate random data
  results[i] = (mean(X) - mu)/(sigma/sqrt(100))
}
hist(results,prob=T)

x = rnorm(100,0,1);qqnorm(x,main="normal(0,1)");qqline(x)
x = rnorm(100,10,15);qqnorm(x,main="normal(10,15)");qqline(x)
x = rexp(100,1/10);qqnorm(x,main="exponential mu=10");qqline(x)
x = runif(100,0,1);qqnorm(x,main="unif(0,1)");qqline(x)


f = function () {
   S = rbinom(1,n,p)
   (S- n*p)/sqrt(n*p*(1-p))
}

hist(x)
