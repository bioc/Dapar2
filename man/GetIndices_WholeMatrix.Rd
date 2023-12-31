% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Filtering.R
\name{GetIndices_WholeMatrix}
\alias{GetIndices_WholeMatrix}
\title{Search lines which respects request on one or more conditions.}
\usage{
GetIndices_WholeMatrix(metacell.mask, op = "==", percent = FALSE, th = 0)
}
\arguments{
\item{metacell.mask}{xxx}

\item{op}{String for operator to use. List of operators is available with SymFilteringOperators().}

\item{percent}{A boolean to indicate whether the threshold represent an absolute value (percent = FALSE) or
a percentage (percent=TRUE).}

\item{th}{A floating number which is in the interval [0, 1]}
}
\description{
This function looks for the lines that respect the request in either all conditions
or at least one condition.
}
\examples{
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- Exp1_R25_pept[1:10]
level <- GetTypeDataset(obj, 2)
pattern <- 'missing'
metacell.mask <- match.metacell(metadata=Get_qMetadata(obj), pattern=pattern, level=level)
percent <- FALSE
th <- 3
op <- '>='
ind <- GetIndices_WholeMatrix(metacell.mask, op, percent, th)

}
