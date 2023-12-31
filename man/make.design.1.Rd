% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/limmaAnalysis.R
\name{make.design.1}
\alias{make.design.1}
\title{Builds the design matrix for designs of level 1}
\usage{
make.design.1(sTab)
}
\arguments{
\item{sTab}{The data.frame which correspond to the definition of replicates}
}
\value{
A design matrix
}
\description{
Builds the design matrix for designs of level 1
}
\examples{
library(QFeatures)
utils::data(Exp1_R25_pept, package='DAPARdata2')
make.design.1(colData(Exp1_R25_pept))

}
\author{
Thomas Burger, Quentin Giai-Gianetto, Samuel Wieczorek
}
