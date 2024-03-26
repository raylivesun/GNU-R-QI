#!/usr/bin/r

S4 <- function(x) {
  y <- 2*x
  z <- 2*y
  print(x)
  print(y)
  print(z)
}

money <- function(n) {
  sq <- function() n*n
  n*sq()
}

start.account <- function(total) {
  list(
    deposit = function(amount) {
      if(amount <= 0)
        stop("Deposits must be positive!\n")
      total <<- total + amount
      cat(amount, "deposited. Your balance is", total, "\n\n")
    },
    withdraw = function(amount) {
      if(amount > total)
        stop("You don't have that much money!\n")
      total <<- total - amount
      cat(amount, "withdrawn. Your balance is", total, "\n\n")
    },
    balance = function() {
      cat("Your balance is", total, "\n\n")
    }
  )
}
promise <- start.account(100)
richer <- start.account(200)
promise$withdraw(30)
promise$deposit(1435)
promise$balance()

