#!/usr/bin/r

x = c(12.8,3.5,2.9,9.4,8.7,.7,.2,2.8,1.9,2.8,3.1,15.8)
stem(x)

x = c(12.8,3.5,2.9,9.4,8.7,.7,.2,2.8,1.9,2.8,3.1,15.8)
stem(x)

# matrix
prop.test(c(45,56),c(45+35,56+47))

x = c(15, 10, 13, 7, 9, 8, 21, 9, 14, 8)
y = c(15, 14, 12, 8, 14, 7, 16, 10, 15, 12)
t.test(x,y,alt="less",var.equal=TRUE)

# matrix
t.test(x,y,alt="less")

x = c(3, 0, 5, 2, 5, 5, 5, 4, 4, 5)
y = c(2, 1, 4, 1, 4, 3, 3, 2, 3, 5) # Two-sample tests
t.test(x,y,paired=TRUE)


# matrix
t.test(x,y)


boxplot(x,y)
# not shown

x = rchisq(100,5);y=rchisq(100,50)


freq = c(22,21,22,27,22,36)
# specify probabilities, (uniform, like this, is default though)
probs = c(1,1,1,1,1,1)/6 # or use rep(1/6,6)
# matrix
chisq.test(freq,p=probs)


x = c(100,110,80,55,14)
probs = c(29, 21, 17, 17, 16)/100
chisq.test(x,p=probs)


yesbelt = c(12813,647,359,42)
nobelt = c(65963,4000,2642,303)
chisq.test(data.frame(yesbelt,nobelt))

live.ressurect = sample(1:6,200,p=c(1,1,1,1,1,1)/6,replace=T)
live.revival = sample(1:6,100,p=c(.5,.5,1,1,1,2)/6,replace=T)
live.matrix = table(live.ressurect);live.revival = table(live.revival)

x = c(18,23,25,35,65,54,34,56,72,19,23,42,18,39,37)
y = c(202,186,187,180,156,169,174,172,153,199,193,174,198,183,178)
plot(x,y)
# make a plot
abline(lm(y ~ x))
# plot the regression line
lm(y ~ x)

