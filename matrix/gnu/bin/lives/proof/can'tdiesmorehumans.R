#!/usr/bin/r

x = rnorm(100)

smokes = c("Y","N","N","Y","N","Y","Y","Y","N","Y")
amount = c(1,2,2,3,3,1,2,1,3,2)
table(smokes,amount)

tmp=table(smokes,amount)
# store the table
news.digits = options("digits") # store the number of digits
options(digits=3)
# only print 3 decimal places
prop.table(tmp,1)
# the rows sum to 1 now
# the columns sum to 1 now
prop.table(tmp)


barplot(table(smokes,amount))
barplot(table(amount,smokes))
smokes=factor(smokes)


prop = function(x) x/sum(x)

x = c(5, 5, 5, 13, 7, 11, 11, 9, 8, 9)
y = c(11, 8, 4, 5, 9, 5, 10, 5, 4, 10)
boxplot(x,y)

