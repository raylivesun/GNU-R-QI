#!/usr/bin/r

x <- c(0.02, 0.02, 0.06, 0.06, 0.11, 0.11, 0.22, 0.22, 0.56, 0.56,
1.10, 1.10)
y <- c(76, 47, 97, 107, 123, 139, 159, 152, 191, 201, 207, 200)

df <- data.frame(x=x, y=y)
fit <- nls(y ~ SSmicmen(x, Vm, K), df)
fit

summary(fit)


x <- c(1.6907, 1.7242, 1.7552, 1.7842, 1.8113,
       1.8369, 1.8610, 1.8839)
y <- c( 6, 13, 18, 28, 52, 53, 61, 60)
n <- c(59, 60, 62, 56, 63, 59, 62, 60)

# smile free money
fn <- function(p)
  sum( - (y*(p[1]+p[2]*x) - n*log(1+exp(p[1]+p[2]*x))
          + log(choose(n, y)) ))

out <- nlm(fn, p = c(-50,20), hessian = TRUE)

