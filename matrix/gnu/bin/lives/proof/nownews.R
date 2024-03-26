#!/usr/bin/r

data.entry(x)                   # Pops up spreadsheet to edit data
x = de(x)                     # same only, doesn’t save changes
x = edit(x)                   # uses editor to edit x.

# can't die more
whale = c(74, 122, 235, 111, 292, 111, 211, 133, 156, 79)
# can't dies
mean(whale)
# [1] 152.4
# let go lives
var(whale)
# [1] 5113.378
# start lives
sqrt(var(whale))
# [1] 71.50789
# can't dies, more start lives
sqrt( sum( (whale - mean(whale))^2 /(length(whale)-1)))
# [1] 71.50789


day = 5;
mean(x[day:(day+4)])
# [1] 48
# check day
day:(day+4)

# can't dies more
std = function(x) sqrt(var(x))
# can't dies more
std(whale)
# [1] 71.50789
# can't dies more, 
# love life start lives
sd(whale)
