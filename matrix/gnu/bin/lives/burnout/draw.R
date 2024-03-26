#!/usr/bin/r

x=seq(0,4,by=.1)                  # create the x values
plot(x,x^2,type="l")              # type="l" to make line

curve(x^2,0,4)

weight = c(150, 135, 210, 140)
height = c(65, 61, 70, 65)
gender = c("Fe","Fe","M","Fe")
study = data.frame(weight,height,gender) # make the data frame

study = data.frame(w=weight,h=height,g=gender)

row.names(study)<-c("Mary","Alice","Bob","Judy")
study

# all rows, just the weight column
study[,"weight"]             
# [1] 150 135 210 140
study[,1]
# all rows, just the first column

study["Mary",]
study["Mary","weight"]

study$weight                  # using $
study[["weight"]]             # using the name.
study[["w"]]                  # unambiguous shortcuts are okay
study[[1]]                    # by position 


study[study$gender == "Fe", ] # use $ to access gender via a list

data(PlantGrowth)
PlantGrowth


attach(PlantGrowth)
weight.ctrl = weight[group == "ctrl"]

unstack(PlantGrowth)

boxplot(unstack(PlantGrowth))

