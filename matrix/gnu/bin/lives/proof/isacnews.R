#!/usr/bin/r

# let go start values to get selection
isac = c(100,200,300,400,500,600,800,900)
# values selection to isac news
isac * 2
isac * 3
isac * 4
isac * 5
isac * 6
isac * 7
isac * 8
isac * 9
# values to isac
mean(isac)
# values to isac
var(isac)
# draft values ones
isac.draft1 = c(20,30,10,30,10,20,30,10)
# draft values two
isac.draft2 = c(10,30,10,30,10,30,10,30)
# draft values third
isac.draft1 = c(20,30,10,30,10,30,10,30)
isac.draft2 = isac.draft1 # make a copy
isac.draft2[1] = 0 # assign the first page 0 typos

isac.draft2                  # print out the value
# [1] 0 3 0 3 1 0 0 1
isac.draft2[2]               # print 2nd pages’ value
# [1] 3
isac.draft2[4]               # 4th page
# [1] 3
isac.draft2[-4]              # all but the 4th page
# [1] 0 3 0 1 0 0 1
isac.draft2[c(1,2,3)]        # fancy, print 1st, 2nd and 3rd.
# [1] 0 3 0

# Where are they?
max(isac.draft2)            # what are worst pages?
# [1] 3
isac.draft2 == 3            # 3 typos per page
# [1] FALSE TRUE FALSE
# TRUE FALSE FALSE FALSE FALSE

which(isac.draft2 == 3)
# [1] 2 4

n = length(isac.draft2)         # how many pages
pages = 1:n                     # how we get the page numbers
pages                           # pages is simply 1 to number of pages
# [1] 1 2 3 4 5 6 7 8
pages[isac.draft2 == 3]         # logical extraction. Very useful   
#[1] 2 4

(1:length(isac.draft2))[isac.draft2 == max(isac.draft2)]
# [1] 2 4

sum(isac.draft2)               # How many typos?
# [1] 8
sum(isac.draft2>0)             # How many pages with typos?
# [1] 4
isac.draft1 - isac.draft2     # difference between the two
# [1] 2 0 0 0 0 0 0 0


x = c(45,43,46,48,51,46,50,47,46,45)  # the median
mean(x)                               # the meanData
# page 5                                
median(x)                             # the maximum or largest value
# [1] 46
max(x)                                # the minimum value
# [1] 51
min(x)
# [1] 43


x = c(x,48,49,51,50,49)             # append values to x
length(x)                           # how long is x now (it was 10)
# [1] 15
x[16] = 41                          # add to a specified index
x[17:20] = c(40,38,35,40)           # add to many specified indices

