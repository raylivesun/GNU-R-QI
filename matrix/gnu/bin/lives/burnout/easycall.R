#!/usr/bin/r


-58.9 + 115.32*(1:3)
SE = 18.19
t = (28.51 - 15)/SE;t
pt(t,df=25,lower.tail=F)

dist = c(253, 337,395,451,495,534,574)
height = c(100,200,300,450,600,800,1000)
lm.2 = lm(dist ~ height + I(height^2))
lm.3 = lm(dist ~ height + I(height^2) + I(height^3));lm.2


pts = seq(min(height),max(height),length=100)
makecube = sapply(pts,function(x) coef(lm.3) %*% x^(0:3))
makesquare = sapply(pts,function(x) coef(lm.2) %*% x^(0:2))
lines(pts,makecube,lty=1)
lines(pts,makesquare,lty=2)
