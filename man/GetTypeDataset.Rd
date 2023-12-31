% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metacell.R
\docType{data}
\name{GetTypeDataset}
\alias{GetTypeDataset}
\alias{GetTypeDataset,SummarizedExperiment-method}
\alias{GetTypeDataset,QFeatures-method}
\title{Get the type of dataset}
\format{
An object of class \code{standardGeneric} of length 1.
}
\usage{
GetTypeDataset

\S4method{GetTypeDataset}{SummarizedExperiment}(object, ...)

\S4method{GetTypeDataset}{QFeatures}(object, i, ...)
}
\arguments{
\item{object}{xxx}

\item{...}{xxx}

\item{i}{xxx}
}
\description{
Get the type of dataset
}
\examples{
utils::data(Exp1_R25_pept, package='DAPARdata2')
GetTypeDataset(Exp1_R25_pept[[2]])

}
\author{
Samuel Wieczorek
}
\keyword{datasets}
