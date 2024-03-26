#!/usr/bin/r

SE = s * sqrt( sum(x^2)/( n*sum((x-mean(x))^2)))
b0 = 210.04846            # copy or use
t = (b0 - 220)/SE         # (coef(lm.result))[[’(Intercept)’]]
pt(t,13,lower.tail=TRUE)  # use lower tail (220 or less)

x = 1:10
y = sample(1:100,10)
z = x+y
# notice no error term -- sigma = 0
lm(z ~ x+y)
# we use lm() as before
...
# edit out Call:...
# model finds b_0 = 0, b_1 = 1, b_2 = 1 as expected
z = x+y + rnorm(10,0,2)
# now sigma = 2
lm(z ~ x+y)
# found b_0 = .4694, b_1 = 0.9765, b_2 = 0.9891
z = x+y + rnorm(10,0,10)
# more noise -- sigma = 10
lm(z ~ x+y)
# more easy
lm(z ~ x+y -1)

summary(lm(z ~ x+y ))


