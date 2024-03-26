#!/usr/bin/r

sort(x)
# note 3.25 value is 1/4 way between 1 and 2
summary(x)



lives = c(12, .4, 5, 2, 50, 8, 3, 1, 4, .25) # enter data
cats = cut(lives,breaks=c(0,1,5,max(lives))) # specify the breaks
cats
# view the values
table(cats) # organize
cats
levels(cats) = c("poor","rich","rolling in it") # change labels
table(cats)

hist(lives)                              # frequencies
hist(lives,probability=TRUE)             # proportions (or probabilities)
rug(jitter(lives))                       # add tick marks

hist(lives,breaks=10)
# 10 breaks, or just hist(x,10)
hist(lives,breaks=c(0,1,2,3,4,5,10,20,max(lives))) # specify break points

data("lynx")
summary(lynx)
