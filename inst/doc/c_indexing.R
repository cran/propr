## ---- dpi = 66-----------------------------------------------------------
library(propr)
data(marg.abs)
marg.rel <- t(apply(marg.abs, 1, function(x) x / sum(x)))

## ---- dpi = 66-----------------------------------------------------------
Abs.cor <- stats::cor(marg.abs, use = "pairwise.complete.obs")
Rel.cor <- stats::cor(marg.rel, use = "pairwise.complete.obs")

## ---- dpi = 66, fig.keep = "last"----------------------------------------
plot(hist(Abs.cor))

## ---- dpi = 66, fig.keep = "last"----------------------------------------
plot(hist(Rel.cor))

## ---- dpi = 66-----------------------------------------------------------
llt <- propr:::lltRcpp
x <- sample(1:length(llt(Abs.cor)), 5000)
plot(llt(Abs.cor)[x], llt(Rel.cor)[x],
     xlab = "Abs", ylab = "Rel", ylim = c(-1,1), xlim = c(-1,1))

## ---- dpi = 66-----------------------------------------------------------
table("Observed" = llt(Rel.cor) > .95,
      "Actual" = llt(Abs.cor) > .95)

## ---- dpi = 66-----------------------------------------------------------
calculatePrecision <- function(observed, actual){
  conf <- table("Observed" = observed, "Actual" = actual)
  precision <- conf["TRUE", "TRUE"] / (conf["TRUE", "FALSE"] + conf["TRUE", "TRUE"])
}

calculateRecall <- function(observed, actual){
  conf <- table("Observed" = observed, "Actual" = actual)
  recall <- conf["TRUE", "TRUE"] / (conf["FALSE", "TRUE"] + conf["TRUE", "TRUE"])
}

## ---- dpi = 66-----------------------------------------------------------
result <- NULL
for(cutoff in c(0, .5, .8, .9, .95, .98)){
  p <- calculatePrecision(llt(Rel.cor) > cutoff, llt(Abs.cor) > cutoff)
  r <- calculateRecall(llt(Rel.cor) > cutoff, llt(Abs.cor) > cutoff)
  result <- rbind(result, data.frame(cutoff, p, r))
}
knitr::kable(result)

## ---- dpi = 66-----------------------------------------------------------
library(propr)
rho.clr <- perb(marg.abs)@matrix

## ---- dpi = 66-----------------------------------------------------------
plot(llt(Abs.cor)[x], llt(rho.clr)[x],
     xlab = "Abs", ylab = "rho (clr)", ylim = c(-1,1), xlim = c(-1,1))

## ---- dpi = 66-----------------------------------------------------------
result <- NULL
for(cutoff in c(0, .5, .8, .9, .95, .98)){
  p <- calculatePrecision(llt(rho.clr) > cutoff, llt(Abs.cor) > cutoff)
  r <- calculateRecall(llt(rho.clr) > cutoff, llt(Abs.cor) > cutoff)
  result <- rbind(result, data.frame(cutoff, p, r))
}
knitr::kable(result)

## ---- dpi = 66-----------------------------------------------------------
i <- order(apply(marg.abs, 2, var))[1:5]
rho.alr <- perb(marg.abs, ivar = i)@matrix
plot(llt(Abs.cor)[x], llt(rho.alr)[x],
     xlab = "Abs", ylab = "rho (alr)", ylim = c(-1,1), xlim = c(-1,1))

## ---- dpi = 66-----------------------------------------------------------
result <- NULL
for(cutoff in c(0, .5, .8, .9, .95, .98)){
  p <- calculatePrecision(llt(rho.alr) > cutoff, llt(Abs.cor) > cutoff)
  r <- calculateRecall(llt(rho.alr) > cutoff, llt(Abs.cor) > cutoff)
  result <- rbind(result, data.frame(cutoff, p, r))
}
knitr::kable(result)

## ---- dpi = 66-----------------------------------------------------------
N <- 20
sd <- 1/sqrt(N - 3)

## ---- dpi = 66-----------------------------------------------------------
z05 <- qnorm(.05, lower.tail = FALSE)
z_cutoff <- sd * z05

## ---- dpi = 66-----------------------------------------------------------
r_cutoff <- tanh(z_cutoff)

## ---- dpi = 66-----------------------------------------------------------
D <- 1000
z_cutoff <- 1 / sqrt(N - 3) * qnorm(.05 / (D * (D - 1)), lower.tail = FALSE)
r_cutoff <- tanh(z_cutoff)
r_cutoff

## ---- dpi = 66-----------------------------------------------------------
result <- NULL
for(D in unique(round(2^seq(1, 16, .05)))){
  for(N in unique(4*seq(1, 32))){
    
    z_cutoff <- 1 / sqrt(N - 3) * qnorm(.05 / (D * (D - 1)), lower.tail = FALSE)
    r_cutoff <- tanh(z_cutoff)
    result <- rbind(result, data.frame(D, N, r_cutoff))
  }
}
knitr::kable(head(result))

## ---- dpi = 66-----------------------------------------------------------
library(ggplot2)
library(directlabels)
g <- ggplot(result, aes(x = D, y = N)) + stat_contour(binwidth = .05,
                                                      aes(z = r_cutoff,
                                                          colour = ..level..)) +
  theme_bw() + scale_colour_gradientn(colours = c("black",
                                                  rev(heat.colors(18)),
                                                  "black"),
                                      limits = c(0, 1)) +
  scale_y_continuous(breaks = 4*seq(1, 32)) +
  scale_x_continuous(breaks = 2^(c(0, 12, 14, 15, 16)))
direct.label(g, method = "top.pieces")

