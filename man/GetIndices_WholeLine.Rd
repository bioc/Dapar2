% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Filtering.R
\name{GetIndices_WholeLine}
\alias{GetIndices_WholeLine}
\title{Search lines which respects query on all their elements.}
\usage{
GetIndices_WholeLine(metacell.mask)
}
\arguments{
\item{metacell.mask}{xxx}
}
\description{
This function looks for the lines where each element respect the query.
}
\examples{
utils::data(Exp1_R25_pept, package='DAPARdata2')
obj <- Exp1_R25_pept[20:30]
level <- GetTypeDataset(obj, 2)
pattern <- 'missing POV'
metacell.mask <- match.metacell(metadata=GetMetacell(obj), pattern=pattern, level=level)
ind <- GetIndices_WholeLine(metacell.mask)

}
