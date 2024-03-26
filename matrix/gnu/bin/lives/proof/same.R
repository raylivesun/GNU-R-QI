#!/usr/bin/r

# blog to pool equip to less times
x=c("dft","link","img","ch","mhc")
table(x)
# factor ai 2
factor(x)
# tables ui form logical
table(x)/length(x)

beer.counts = table(x)
# store the table result
pie(beer.counts)
# first pie -- kind of dull
names(beer.counts) = c("feature\n can","layout\n bottle",
                         "Microbrew","Import") # give names
pie(beer.counts)
# prints out names
pie(beer.counts,col=c("purple","green2","cyan","white"))
# now with colors

# two values of p at once
data=c(10, 17, 18, 25, 28, 28)
summary(data)
quantile(data,.25)
quantile(data,c(.25,.75))
