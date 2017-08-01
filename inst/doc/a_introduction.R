## ---- dpi = 72-----------------------------------------------------------
set.seed(12345)
N <- 100
X <- data.frame(a=(1:N), b=(1:N) * rnorm(N, 10, 0.1),
                c=(N:1), d=(N:1) * rnorm(N, 10, 1.0))

## ---- dpi = 72, results = "hide"-----------------------------------------
library(propr)
phi <- phit(X, symmetrize = TRUE)
rho <- perb(X, ivar = 0)
phs <- phis(X, ivar = 0)

## ---- dpi = 72-----------------------------------------------------------
rho99 <- rho[">", .95]
rho99@pairs

## ---- dpi = 72-----------------------------------------------------------
rhoab <- subset(rho, select = c("a", "b"))
rhoab@matrix

## ---- dpi = 72-----------------------------------------------------------
simplify(rho99)

## ---- dpi = 72, results = "hide", fig.show = "hold", fig.keep = "last"----
plot(rho99)

