#!/usr/bin/r

x = c(4,3,4,5,2,3,4,5)
y = c(4,4,5,5,4,5,4,4)
z = c(3,4,2,4,5,5,4,4)
scores = data.frame(x,y,z)
boxplot(scores)

scores = stack(scores)
names(scores)
# matrix
oneway.test(values ~ ind, data=scores, var.equal=T)

df = stack(data.frame(x,y,z)) # prepare the data
oneway.test(values ~ ind, data=df,var.equal=T)


anova(lm(values ~ ind, data=df))


kruskal.test(values ~ ind, data=df)

data(mtcars)
names(mtcars)

make.t = function(x,mu) {(mean(x)-mu)/( sqrt(var(x)/length(x)))}
mu = 1;x=rnorm(100,mu,1)
make.t(x,mu)

mu = 10;x=rexp(100,1/mu);make.t(x,mu)

results = c()
# initialize the results vector
for (i in 1:200) results[i] = make.t(rexp(100,1/mu),mu)

.First <- function() print("Hola")
.Last <- function() print("Hasta La Vista")

td <- function (x) sqrt(var(x))
data <- c(1,3,2,4,1,4,6)

hello.world <- function() print("hello world")
hello.world()


hello.have <- function(name="world") print(paste("hello ",name))
hello.have()


sim.t <- function(n) {
   mu <- 10;sigma<-5;
   X <- rnorm(n,mu,sigma)
   (mean(X) - mu)/(sd(X)/n)
}
sim.t(4)


sim.t <- function(n,mu=10,sigma=5) {
  X <- rnorm(n,mu,sigma)
  (mean(X) - mu)/(sd(X)/n)
}

sim.t(4)
sim.t(4,3,10)
sim.t(4,5)
sim.t(4,sigma=100)
sim.t(4,sigma=100,mu=1)


plot.f <- function(f,a,b,...) {
  xvals<-seq(a,b,length=100)
  plot(xvals,f(xvals),type="l",...)
}

our.average <- function (x) sum(x)/length(x)
our.average(c(1,2,3))


silly.sum <- function (x) {
  ret <- 0; # Entering Data into R
  for (i in 1:length(x)) ret <- ret + x[i]
  ret
}
silly.sum(c(1,2,3,4))

