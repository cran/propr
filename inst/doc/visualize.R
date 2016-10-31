## ---- eval = FALSE-------------------------------------------------------
#  library(propr)
#  data(caneToad.counts)
#  data(caneToad.groups)

## ---- echo = FALSE-------------------------------------------------------
library(propr)
data(caneToad.groups)
data(top)

## ---- eval = FALSE-------------------------------------------------------
#  keep <- apply(caneToad.counts, 2, function(x) sum(x >= 10) >= 10)

## ---- eval = FALSE-------------------------------------------------------
#  rho <- perb(caneToad.counts, select = keep)

## ---- eval = FALSE-------------------------------------------------------
#  best <- rho[">", .995]

## ---- eval = FALSE-------------------------------------------------------
#  plot(best)

## ---- echo = FALSE, results = "hide", fig.show = "hold", fig.keep = "last"----
plot(top)

## ---- eval = FALSE-------------------------------------------------------
#  dendrogram(best)

## ---- echo = FALSE, results = "hide"-------------------------------------
dendrogram(top)

## ---- eval = FALSE-------------------------------------------------------
#  top <- simplify(best)

## ---- results = "hide", message = FALSE----------------------------------
mds(top, group = caneToad.groups)

## ---- results = "hide", message = FALSE----------------------------------
snapshot(top)

## ---- results = "hide", message = FALSE----------------------------------
clusts <- prism(top, k = 5)

## ---- results = "hide", message = FALSE----------------------------------
clusts <- bucket(top, group = caneToad.groups, k = 5)

## ---- results = "hide"---------------------------------------------------
sub <- subset(top, select = (clusts == 4))

## ---- results = "hide"---------------------------------------------------
mds(sub, group = caneToad.groups)

## ------------------------------------------------------------------------
transcripts <- colnames(sub@logratio)

