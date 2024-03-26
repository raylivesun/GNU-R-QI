#!/usr/bin/r

methods(class="data.frame")
methods(plot)

yi <- function(p, j=0, bj, xij, ei) {
  p <- c(5*2+100*10)
  bj <- j
  xij <- p * j
  ei <- p * bj / xij
  
  c(p,bj,xij,ei)
  
}
