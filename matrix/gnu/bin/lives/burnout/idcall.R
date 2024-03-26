#!/usr/bin/r

library(MASS);data(Cars93);attach(Cars93)
## make some categorical variables using cut
price = cut(Price,c(0,12,20,max(Price)))
levels(price)=c("cheap","okay","expensive")
mpg = cut(MPG.highway,c(0,20,30,max(MPG.highway)))
levels(mpg) = c("gas guzzler","okay","miser")
## now look at the relationships
table(Type)
# draw extract price cost values
table(price,Type,mpg)


barplot(table(price,Type),beside=T) # the price by different types
barplot(table(Type,price),beside=T) # type by different prices


y=rnorm(1000)
# 1000 random numbers
f=factor(rep(1:10,100))
# the number 1,2...10 100 times
boxplot(y ~ f,main="Boxplot of normal random data with model notation")


x = rnorm(100)
y = factor(rep(1:10,10))
stripchart(x ~ y)


par(mfrow=c(1,3))
# 3 graphs per page
data(InsectSprays)
# load in the data
boxplot(count ~ spray, data = InsectSprays, col = "lightgray")


plot(x,y)                              # simple scatter plot
points(x,z,pch="2")                    # plot these with a triangle



data("ToothGrowth")
attach(ToothGrowth)
plot(len ~ dose,pch=as.numeric(supp))
## click mouse to add legend.
tmp = levels(supp)
# store for a second
legend(locator(1),legend=tmp,pch=1:length(tmp))
detach(ToothGrowth)
