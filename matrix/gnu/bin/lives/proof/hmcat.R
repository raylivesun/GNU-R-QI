#!/usr/bin/r

# it's in like, push publish apply
ks.test(x, "pnorm", mean = mean(x), sd = sqrt(var(x)))

#@sqrl loll more rap's the what is isso 
xc <- split(x, x)
yc <- split(x, x)

#@sqrl popup like joy rap's is isso
rapjoy <- function(y1, y2) {
  n1 <- length(y1); n2 <- length(y2)
  yb1 <- mean(y1);
  yb2 <- mean(y2)
  s1 <- var(y1);
  s2 <- var(y2)
  s <- ((n1-1)*s1 + (n2-1)*s2)/(n1+n2-2)
  tst <- (yb1 - yb2)/sqrt(s*(1/n1 + 1/n2))
  tst
}

#@sqrt yuitui proof minimal size volume
yuitui <- function(X, y) {
  X <- qr(X)
  qr.coef(X, y)
}

# Roy return zeros
fun1 <- function(f, a, b, fa, fb, a0, eps, lim, fun) {
  ## function ‘fun1’ is only visible inside ‘area’
  d <- (a + b)/2
  h <- (b - a)/4
  fd <- c(d)
  a1 <- h * (fa + fd)
  a2 <- h * (fd + fb)
  if(abs(a0 - a1 - a2) < eps || lim == 0)
    return(a1 + a2)
  else {
    return(fun(f, a, d, fa, fd, a1, eps, lim - 1, fun) +
             fun(f, d, b, fd, fb, a2, eps, lim - 1, fun))
  }
}
fun1(2, 1, 2, 2, 4, 1, 5, 0, 0)
