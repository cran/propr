## ---- dpi = 72, eval = FALSE---------------------------------------------
#  library(propr)
#  data(caneToad.counts)
#  data(caneToad.groups)

## ---- dpi = 72, echo = FALSE---------------------------------------------
library(propr)
data(caneToad.groups)
data(top.counts)
data(top.lr)
best <- new("propr")
best@counts <- top.counts
best@logratio <- top.lr
best@matrix <- propr:::lr2rho(top.lr)
best <- best[">", .995]

## ---- dpi = 72, eval = FALSE---------------------------------------------
#  keep <- apply(caneToad.counts, 2, function(x) sum(x >= 10) >= 10)
#  rho <- perb(caneToad.counts, select = keep)

## ---- dpi = 72, eval = FALSE---------------------------------------------
#  best <- rho[">", .995]

## ---- dpi = 72, results = "hide", fig.show = "hold", fig.keep = "last"----
plot(best)

## ---- dpi = 72, results = "hide"-----------------------------------------
dendrogram(best)

## ---- dpi = 72, eval = FALSE---------------------------------------------
#  best <- simplify(best)

## ---- dpi = 72, results = "hide", message = FALSE, fig.keep = "last"-----
pca(best, group = caneToad.groups)

## ---- dpi = 72, results = "hide", message = FALSE------------------------
snapshot(best)

## ---- dpi = 72, results = "hide", message = FALSE------------------------
clusts <- prism(best, k = 5)

## ---- dpi = 72, results = "hide", message = FALSE------------------------
clusts <- bokeh(best, k = 5)

## ---- dpi = 72, results = "hide", message = FALSE------------------------
clusts <- bucket(best, group = caneToad.groups, k = 5)

## ---- dpi = 72, results = "hide"-----------------------------------------
sub <- subset(best, select = (clusts == 2))

## ---- dpi = 72, results = "hide", message = FALSE, fig.keep = "last"-----
cyt <- cytescape(sub[">", .95])

## ---- dpi = 72, results = "hide", fig.keep = "last"----------------------
pca(sub, group = caneToad.groups)

## ---- dpi = 72-----------------------------------------------------------
transcripts <- colnames(sub@logratio)

