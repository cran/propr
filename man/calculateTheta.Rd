% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/5-propdCall.R
\name{calculateTheta}
\alias{calculateTheta}
\title{Calculate Theta}
\usage{
calculateTheta(counts, group, alpha = NA, lrv = NA, only = "all",
  weighted = FALSE, weights = as.matrix(NA))
}
\arguments{
\item{counts}{A data.frame or matrix. A "count matrix" with
subjects as rows and features as columns. Note that this matrix
does not necessarily have to contain counts.}

\item{group}{A character vector. Group or sub-group memberships,
ordered according to the row names in \code{counts}.}

\item{alpha}{A double. See vignette for details. Leave missing
to skip Box-Cox transformation.}

\item{lrv}{A numeric vector. A vector of pre-computed
log-ratio variances. Optional parameter.}

\item{only}{A character string. The name of the theta
type to return if only calculating one theta type.
Used to make \code{updateCutoffs} faster.}

\item{weighted}{A boolean. Toggles whether to calculate
theta using \code{limma::voom} weights.}

\item{weights}{A matrix. Pre-computed \code{limma}-based
weights. Optional parameter.}
}
\value{
A data.frame of theta values if \code{only = "all"}.
 Otherwise, this function returns a numeric vector.
}
\description{
Calculate differential proportionality measure, theta.
 Used by \code{\link{propd}} to build the \code{@results}
 slot. A numeric \code{alpha} argument will trigger
 the Box-Cox transformation.
}
